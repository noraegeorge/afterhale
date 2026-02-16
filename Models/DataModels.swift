import Foundation
import SwiftUI

// MARK: - Mood Entry Model
struct MoodEntry: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var mood: MoodType
    var note: String
    var tags: [String]

    enum MoodType: String, Codable, CaseIterable {
        case veryHappy = "Very Happy"
        case happy = "Happy"
        case okay = "Okay"
        case sad = "Sad"
        case stressed = "Stressed"
        case anxious = "Anxious"
        case angry = "Angry"

        var emoji: String {
            switch self {
            case .veryHappy: return "😄"
            case .happy: return "🙂"
            case .okay: return "😐"
            case .sad: return "😢"
            case .stressed: return "😰"
            case .anxious: return "😟"
            case .angry: return "😠"
            }
        }

        var color: Color {
            switch self {
            case .veryHappy: return .green
            case .happy: return .mint
            case .okay: return .yellow
            case .sad: return .blue
            case .stressed: return .orange
            case .anxious: return .purple
            case .angry: return .red
            }
        }
    }
}

// MARK: - Emergency Contact Model
struct EmergencyContact: Identifiable, Codable {
    var id = UUID()
    var name: String
    var relationship: String
    var phoneNumber: String
    var note: String
}

// MARK: - Meditation Model
struct Meditation: Identifiable {
    let id = UUID()
    let title: String
    let duration: String
    let description: String
    let icon: String
    let category: Category

    enum Category: String {
        case breathing = "Breathing"
        case relaxation = "Relaxation"
        case mindfulness = "Mindfulness"
        case sleep = "Sleep"
    }
}

// MARK: - Coping Skill Model
struct CopingSkill: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let instructions: [String]
    let icon: String
    let color: Color
    let category: Category

    enum Category: String {
        case grounding = "Grounding"
        case distraction = "Distraction"
        case relaxation = "Relaxation"
        case cognitive = "Cognitive"
    }
}
