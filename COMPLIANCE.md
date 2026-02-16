# Compliance Documentation

## Overview
StressMind is designed with strict compliance to HIPAA, COPPA, and WCAG accessibility standards.

## HIPAA Compliance

### Data Protection
- **Encryption**: All user data is encrypted using AES-256 encryption
- **Key Management**: Encryption keys are securely stored in iOS Keychain
- **Local Storage Only**: No data is transmitted to external servers
- **Secure Deletion**: Users can delete all their data at any time

### Implementation Details
- `DataManager.swift` implements AES-GCM encryption for all sensitive data
- Mood entries and emergency contacts are encrypted before storage
- Encryption keys are generated using `CryptoKit.SymmetricKey`
- Keys are stored in iOS Keychain (kSecClassGenericPassword)

### Data Types Protected
- Mood journal entries (mood type, notes, tags, timestamps)
- Emergency contact information (names, phone numbers, relationships)
- All personally identifiable information (PII)

## COPPA Compliance (Children's Online Privacy Protection Act)

### Age Requirements
- App is designed for users 13+ years old
- If targeting users under 13, parental consent mechanism must be added

### Data Collection
- **NO external data collection**: App does not collect, transmit, or share any data
- **Local only**: All data stays on the user's device
- **No tracking**: No analytics, cookies, or tracking mechanisms
- **No ads**: No third-party advertising networks

### Privacy by Design
- No user accounts required
- No email addresses collected
- No location tracking
- No push notifications without explicit permission
- No in-app purchases that could lead to unexpected charges

## WCAG 2.1 Level AA Compliance

### Accessibility Features Implemented

#### 1. Perceivable
- **Text Alternatives**: All images have accessibility labels
- **Color Contrast**: Minimum 4.5:1 ratio for text
- **Resizable Text**: Supports Dynamic Type for text scaling
- **Visual Design**: Colors are not the only means of conveying information

#### 2. Operable
- **Keyboard/Touch**: All functionality available via touch
- **Focus**: Clear focus indicators for all interactive elements
- **Navigation**: Logical tab order through content
- **Timing**: No time limits on user interactions

#### 3. Understandable
- **Readable**: Clear, simple language
- **Predictable**: Consistent navigation and behavior
- **Input Assistance**: Clear labels and error messages
- **Confirmation**: Alerts before critical actions (delete, call)

#### 4. Robust
- **VoiceOver Support**: Full VoiceOver compatibility
- **Semantic HTML/SwiftUI**: Proper use of accessibility traits
- **Screen Reader**: All content accessible via screen readers

### Specific Accessibility Implementations

```swift
// Example: Accessibility labels
.accessibilityLabel("Call 988 Crisis Hotline")
.accessibilityHint("Double tap to initiate call")

// Example: Header traits
.accessibilityAddTraits(.isHeader)

// Example: Selection state
.accessibilityAddTraits(isSelected ? .isSelected : [])

// Example: Combining elements
.accessibilityElement(children: .combine)
```

### Testing Checklist
- [ ] VoiceOver navigation works smoothly
- [ ] All buttons have descriptive labels
- [ ] Dynamic Type scales text properly
- [ ] Color contrast meets WCAG AA standards
- [ ] Focus order is logical
- [ ] All alerts are announced by VoiceOver
- [ ] Form fields have clear labels

## Privacy Policy Requirements

### Required Disclosures
When submitting to App Store, include:

1. **Data Collection**: "This app does not collect any personal data"
2. **Data Storage**: "All data is stored locally on your device only"
3. **Data Sharing**: "We do not share any data with third parties"
4. **Data Security**: "Data is encrypted using industry-standard encryption"
5. **Data Deletion**: "You can delete all app data at any time"

### App Store Privacy Labels
- **Data Not Collected**: Check all categories
- **Data Not Linked to You**: N/A (no data collected)
- **Data Not Used for Tracking**: Confirmed

## Security Best Practices

### Implemented Security Measures
1. **Encryption at Rest**: AES-256-GCM for all stored data
2. **Secure Key Storage**: iOS Keychain for encryption keys
3. **No Network Requests**: Except for phone calls to hotlines
4. **Secure Phone Calls**: Using tel:// URL scheme with confirmation
5. **Input Validation**: Phone numbers and text fields validated
6. **Secure Deletion**: Overwrite data on deletion

### Code Security
```swift
// Secure encryption implementation
private func encrypt(_ data: Data) throws -> Data {
    let sealedBox = try AES.GCM.seal(data, using: encryptionKey)
    return sealedBox.combined!
}

// Secure decryption
private func decrypt(_ data: Data) throws -> Data {
    let sealedBox = try AES.GCM.SealedBox(combined: data)
    return try AES.GCM.open(sealedBox, using: encryptionKey)
}

// Secure key management
private static func getOrCreateEncryptionKey() -> SymmetricKey {
    // Retrieve from Keychain or generate new
    // Store in Keychain for persistence
}
```

## Data Retention and Deletion

### User Rights
- Right to access their data (export function)
- Right to delete their data (delete all function)
- Right to know what data is collected (none, except locally stored)

### Implementation
```swift
// Export user data
func exportAllData() -> String {
    // Returns formatted string of all user data
}

// Delete all user data
func deleteAllData() {
    moodEntries.removeAll()
    emergencyContacts.removeAll()
    UserDefaults.standard.removeObject(forKey: moodEntriesKey)
    UserDefaults.standard.removeObject(forKey: emergencyContactsKey)
}
```

## Audit and Monitoring

### Regular Reviews
- Review encryption implementation
- Test accessibility features
- Update privacy documentation
- Monitor iOS security best practices

### Third-Party Audits
- Consider security audit before public release
- Accessibility audit by users with disabilities
- Legal review of privacy policy

## Incident Response

### Data Breach Protocol
Since data is local only:
1. No remote data breach possible
2. Physical device access would be required
3. Device passcode and biometrics provide additional security
4. Encryption provides defense in depth

### User Support
- Clear documentation on data security
- Contact information for privacy questions
- Instructions for data export and deletion

## Updates and Maintenance

### Future Considerations
- Keep encryption methods up to date
- Monitor WCAG updates (WCAG 3.0)
- Stay current with iOS security best practices
- Regular accessibility testing with users

## Legal Disclaimer

**Important**: This app is not a substitute for professional medical care.

- Not FDA approved
- Not a medical device
- Provides access to crisis resources only
- User responsible for seeking professional help
- Developer not liable for outcomes

Include appropriate disclaimers in:
- App Store description
- In-app about section
- Privacy policy
- Terms of service

## Contact Information

For privacy questions or data deletion requests:
- Include support email
- Response time: 48 hours
- Data deletion: Instant (user can do it themselves)

## Compliance Verification

Before release, verify:
- [ ] HIPAA: Data encrypted and local only
- [ ] COPPA: No data collection from minors
- [ ] WCAG: All accessibility features tested
- [ ] Privacy policy published
- [ ] Terms of service published
- [ ] App Store privacy labels accurate
- [ ] All disclaimers in place
- [ ] Contact information provided
- [ ] User data export works
- [ ] User data deletion works
