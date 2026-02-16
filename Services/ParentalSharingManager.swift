import Foundation
import SwiftUI

class ParentalSharingManager: ObservableObject {
    static let shared = ParentalSharingManager()

    @Published var settings: ParentalSharingSettings

    private let settingsKey = "parentalSharingSettings"
    private let encryptionKey: SymmetricKey

    private init() {
        self.encryptionKey = DataManager.shared.encryptionKey
        self.settings = ParentalSharingManager.loadSettings(with: encryptionKey)
    }

    // MARK: - Settings Management

    func updateSettings(_ newSettings: ParentalSharingSettings) {
        settings = newSettings
        saveSettings()
    }

    func enableSharing() {
        settings.isEnabled = true
        settings.shareDate = Date()
        saveSettings()
    }

    func disableSharing() {
        settings.isEnabled = false
        settings.sharedWith.removeAll()
        saveSettings()
    }

    private func saveSettings() {
        do {
            let data = try JSONEncoder().encode(settings)
            let encryptedData = try encrypt(data)
            UserDefaults.standard.set(encryptedData, forKey: settingsKey)
        } catch {
            print("Error saving parental sharing settings: \(error)")
        }
    }

    private static func loadSettings(with key: SymmetricKey) -> ParentalSharingSettings {
        guard let encryptedData = UserDefaults.standard.data(forKey: "parentalSharingSettings") else {
            return ParentalSharingSettings()
        }

        do {
            let data = try decrypt(encryptedData, with: key)
            return try JSONDecoder().decode(ParentalSharingSettings.self, from: data)
        } catch {
            print("Error loading parental sharing settings: \(error)")
            return ParentalSharingSettings()
        }
    }

    // MARK: - Mood Summary Generation

    func generateMoodSummary(for timeframe: Timeframe = .lastTwoWeeks) -> MoodSummary {
        let moodEntries = DataManager.shared.moodEntries
        let filteredEntries = filterEntries(moodEntries, for: timeframe)

        guard !filteredEntries.isEmpty else {
            return MoodSummary(
                dateRange: timeframe.description,
                totalEntries: 0,
                moodBreakdown: [:],
                topTags: [],
                averageMood: "No data",
                trendDirection: .insufficient
            )
        }

        // Calculate mood breakdown
        var moodCounts: [String: Int] = [:]
        var allTags: [String] = []

        for entry in filteredEntries {
            moodCounts[entry.mood.rawValue, default: 0] += 1
            allTags.append(contentsOf: entry.tags)
        }

        // Get top tags
        let tagCounts = Dictionary(grouping: allTags, by: { $0 }).mapValues { $0.count }
        let topTags = tagCounts.sorted { $0.value > $1.value }
            .prefix(5)
            .map { $0.key }

        // Determine trend
        let trend = calculateTrend(from: filteredEntries)

        // Determine average mood
        let averageMood = determineAverageMood(from: moodCounts, total: filteredEntries.count)

        return MoodSummary(
            dateRange: timeframe.description,
            totalEntries: filteredEntries.count,
            moodBreakdown: moodCounts,
            topTags: Array(topTags),
            averageMood: averageMood,
            trendDirection: trend
        )
    }

    enum Timeframe {
        case lastWeek
        case lastTwoWeeks
        case lastMonth
        case last90Days

        var days: Int {
            switch self {
            case .lastWeek: return 7
            case .lastTwoWeeks: return 14
            case .lastMonth: return 30
            case .last90Days: return 90
            }
        }

        var description: String {
            switch self {
            case .lastWeek: return "Last 7 days"
            case .lastTwoWeeks: return "Last 14 days"
            case .lastMonth: return "Last 30 days"
            case .last90Days: return "Last 90 days"
            }
        }
    }

    private func filterEntries(_ entries: [MoodEntry], for timeframe: Timeframe) -> [MoodEntry] {
        let cutoffDate = Calendar.current.date(byAdding: .day, value: -timeframe.days, to: Date()) ?? Date()
        return entries.filter { $0.date >= cutoffDate }
    }

    private func calculateTrend(from entries: [MoodEntry]) -> MoodSummary.TrendDirection {
        guard entries.count >= 4 else {
            return .insufficient
        }

        // Split entries into two halves
        let midpoint = entries.count / 2
        let firstHalf = entries[..<midpoint]
        let secondHalf = entries[midpoint...]

        // Calculate average mood scores
        let firstAverage = averageMoodScore(from: Array(firstHalf))
        let secondAverage = averageMoodScore(from: Array(secondHalf))

        let difference = secondAverage - firstAverage

        if difference > 0.5 {
            return .improving
        } else if difference < -0.5 {
            return .declining
        } else {
            return .stable
        }
    }

    private func averageMoodScore(from entries: [MoodEntry]) -> Double {
        let scores = entries.map { moodScore(for: $0.mood) }
        return scores.reduce(0, +) / Double(scores.count)
    }

    private func moodScore(for mood: MoodEntry.MoodType) -> Double {
        switch mood {
        case .veryHappy: return 5.0
        case .happy: return 4.0
        case .okay: return 3.0
        case .sad: return 2.0
        case .stressed: return 2.0
        case .anxious: return 1.5
        case .angry: return 1.0
        }
    }

    private func determineAverageMood(from breakdown: [String: Int], total: Int) -> String {
        guard let mostCommon = breakdown.max(by: { $0.value < $1.value }) else {
            return "Varied"
        }

        let percentage = Double(mostCommon.value) / Double(total) * 100

        if percentage > 50 {
            return "Mostly \(mostCommon.key)"
        } else {
            return "Mixed (\(mostCommon.key) most common)"
        }
    }

    // MARK: - Sharing Actions

    func generateShareableContent(timeframe: Timeframe = .lastTwoWeeks) -> String {
        let summary = generateMoodSummary(for: timeframe)
        return summary.generateShareableText()
    }

    // MARK: - Emergency Detection

    func checkForEmergencyTriggers() -> EmergencyAlert? {
        let recentEntries = DataManager.shared.moodEntries.prefix(5)

        // Check for multiple consecutive negative moods
        let negativeCount = recentEntries.filter {
            $0.mood == .anxious || $0.mood == .stressed || $0.mood == .sad || $0.mood == .angry
        }.count

        if negativeCount >= 4 && settings.isEnabled {
            return EmergencyAlert(
                triggerDate: Date(),
                reason: .multipleNegativeMoods,
                message: "Your teen has logged several difficult moods recently. Consider checking in with them."
            )
        }

        return nil
    }

    // MARK: - Encryption Helpers

    private func encrypt(_ data: Data) throws -> Data {
        let sealedBox = try AES.GCM.seal(data, using: encryptionKey)
        return sealedBox.combined!
    }

    private static func decrypt(_ data: Data, with key: SymmetricKey) throws -> Data {
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        return try AES.GCM.open(sealedBox, using: key)
    }
}

// Import CryptoKit for encryption
import CryptoKit
