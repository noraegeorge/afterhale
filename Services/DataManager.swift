import Foundation
import CryptoKit

/// Secure data manager with encryption for HIPAA/COPPA compliance
/// All data is stored locally on device with AES-256 encryption
class DataManager: ObservableObject {
    static let shared = DataManager()

    @Published var moodEntries: [MoodEntry] = []
    @Published var emergencyContacts: [EmergencyContact] = []

    private let moodEntriesKey = "moodEntries"
    private let emergencyContactsKey = "emergencyContacts"
    let encryptionKey: SymmetricKey  // Made internal for ParentalSharingManager access

    private init() {
        // Generate or retrieve encryption key from Keychain
        self.encryptionKey = DataManager.getOrCreateEncryptionKey()
        loadData()
    }

    // MARK: - Encryption Key Management

    private static func getOrCreateEncryptionKey() -> SymmetricKey {
        let keychainKey = "com.stressmind.encryptionKey"

        // Try to retrieve existing key from Keychain
        if let keyData = KeychainHelper.load(key: keychainKey) {
            return SymmetricKey(data: keyData)
        }

        // Generate new key if none exists
        let newKey = SymmetricKey(size: .bits256)
        let keyData = newKey.withUnsafeBytes { Data($0) }
        KeychainHelper.save(key: keychainKey, data: keyData)

        return newKey
    }

    // MARK: - Encryption/Decryption

    private func encrypt(_ data: Data) throws -> Data {
        let sealedBox = try AES.GCM.seal(data, using: encryptionKey)
        return sealedBox.combined!
    }

    private func decrypt(_ data: Data) throws -> Data {
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        return try AES.GCM.open(sealedBox, using: encryptionKey)
    }

    // MARK: - Mood Entries

    func addMoodEntry(_ entry: MoodEntry) {
        moodEntries.insert(entry, at: 0)
        saveMoodEntries()
    }

    func deleteMoodEntry(_ entry: MoodEntry) {
        moodEntries.removeAll { $0.id == entry.id }
        saveMoodEntries()
    }

    func updateMoodEntry(_ entry: MoodEntry) {
        if let index = moodEntries.firstIndex(where: { $0.id == entry.id }) {
            moodEntries[index] = entry
            saveMoodEntries()
        }
    }

    private func saveMoodEntries() {
        do {
            let data = try JSONEncoder().encode(moodEntries)
            let encryptedData = try encrypt(data)
            UserDefaults.standard.set(encryptedData, forKey: moodEntriesKey)
        } catch {
            print("Error saving mood entries: \(error)")
        }
    }

    private func loadMoodEntries() {
        guard let encryptedData = UserDefaults.standard.data(forKey: moodEntriesKey) else {
            return
        }

        do {
            let data = try decrypt(encryptedData)
            moodEntries = try JSONDecoder().decode([MoodEntry].self, from: data)
        } catch {
            print("Error loading mood entries: \(error)")
        }
    }

    // MARK: - Emergency Contacts

    func addEmergencyContact(_ contact: EmergencyContact) {
        emergencyContacts.append(contact)
        saveEmergencyContacts()
    }

    func deleteEmergencyContact(_ contact: EmergencyContact) {
        emergencyContacts.removeAll { $0.id == contact.id }
        saveEmergencyContacts()
    }

    func updateEmergencyContact(_ contact: EmergencyContact) {
        if let index = emergencyContacts.firstIndex(where: { $0.id == contact.id }) {
            emergencyContacts[index] = contact
            saveEmergencyContacts()
        }
    }

    private func saveEmergencyContacts() {
        do {
            let data = try JSONEncoder().encode(emergencyContacts)
            let encryptedData = try encrypt(data)
            UserDefaults.standard.set(encryptedData, forKey: emergencyContactsKey)
        } catch {
            print("Error saving emergency contacts: \(error)")
        }
    }

    private func loadEmergencyContacts() {
        guard let encryptedData = UserDefaults.standard.data(forKey: emergencyContactsKey) else {
            return
        }

        do {
            let data = try decrypt(encryptedData)
            emergencyContacts = try JSONDecoder().decode([EmergencyContact].self, from: data)
        } catch {
            print("Error loading emergency contacts: \(error)")
        }
    }

    // MARK: - Load All Data

    private func loadData() {
        loadMoodEntries()
        loadEmergencyContacts()
    }

    // MARK: - Data Export/Deletion (HIPAA/COPPA Compliance)

    func exportAllData() -> String {
        var export = "StressMind Data Export\n"
        export += "Generated: \(Date())\n\n"

        export += "=== Mood Entries ===\n"
        for entry in moodEntries {
            export += "\(entry.date): \(entry.mood.rawValue) - \(entry.note)\n"
        }

        export += "\n=== Emergency Contacts ===\n"
        for contact in emergencyContacts {
            export += "\(contact.name) (\(contact.relationship}): \(contact.phoneNumber)\n"
        }

        return export
    }

    func deleteAllData() {
        moodEntries.removeAll()
        emergencyContacts.removeAll()
        UserDefaults.standard.removeObject(forKey: moodEntriesKey)
        UserDefaults.standard.removeObject(forKey: emergencyContactsKey)
    }
}

// MARK: - Keychain Helper

class KeychainHelper {
    static func save(key: String, data: Data) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]

        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    static func load(key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true
        ]

        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)

        return result as? Data
    }
}
