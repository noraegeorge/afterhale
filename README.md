# StressMind - Teen Stress Management App

An iOS app designed to help teenagers manage stress and access mental health resources quickly.

## Features

### 🚨 Panic Button (Home Tab)
- One-tap access to call the 988 Suicide & Crisis Lifeline
- Available 24/7, free and confidential
- Clear confirmation dialog before making the call
- Quick access to Teen Line, Crisis Text Line, and Trevor Project
- Emergency 911 button for life-threatening situations

### 📊 Mood Journal (Mood Tab)
- Track your daily mood with emoji-based entries
- Add notes and tags to understand mood patterns
- View mood history with visual calendar
- Secure, encrypted local storage
- Export or delete your data anytime

### 🎯 Coping Skills Library (Skills Tab)
- 9+ evidence-based coping techniques
- Categories: Grounding, Distraction, Relaxation, Cognitive
- Interactive step-by-step instructions
- Track completion of each step
- Search and filter by category

### 🧘 Guided Meditations (Meditate Tab)
- 8+ guided meditation sessions
- Categories: Breathing, Relaxation, Mindfulness, Sleep
- Duration: 5-20 minutes
- Visual guidance and progress tracking
- Practice anytime, anywhere

### 👥 Emergency Contacts (Contacts Tab)
- Add trusted people you can reach out to
- Store phone numbers, relationships, and notes
- One-tap calling
- Pre-loaded crisis hotline numbers
- Encrypted storage for privacy

## How to Build and Run

### Prerequisites
- macOS with Xcode 14.0 or later
- iOS 15.0 or later target device/simulator
- Apple Developer account (for device deployment)

### Setup Instructions

1. **Create Xcode Project**
   ```bash
   # Create a new Xcode project
   # File > New > Project > iOS > App
   # Product Name: StressMind
   # Interface: SwiftUI
   # Language: Swift
   # Minimum Deployment: iOS 15.0
   ```

2. **Project Structure**
   Add the provided files to your Xcode project:
   ```
   StressMind/
   ├── StressMindApp.swift          (App entry point)
   ├── ContentView.swift             (Main tab view)
   ├── Models/
   │   └── DataModels.swift         (Data structures)
   ├── Services/
   │   └── DataManager.swift        (Encrypted data storage)
   └── Views/
       ├── HomeView.swift           (Crisis hotlines & panic button)
       ├── MoodTrackerView.swift    (Mood journal)
       ├── CopingSkillsView.swift   (Coping techniques)
       ├── MeditationView.swift     (Guided meditations)
       ├── EmergencyContactsView.swift (Personal contacts)
       ├── BreathingView.swift      (Breathing exercises - legacy)
       └── ResourcesView.swift      (Mental health resources - legacy)
   ```

3. **Configure Project Settings**
   - Target: iOS 15.0 or later
   - Enable "App Sandbox" for security (optional)
   - Add `LSApplicationQueriesSchemes` to Info.plist if needed:
     ```xml
     <key>LSApplicationQueriesSchemes</key>
     <array>
         <string>tel</string>
         <string>sms</string>
     </array>
     ```

4. **Import Required Frameworks**
   The app uses:
   - SwiftUI (UI framework)
   - CryptoKit (encryption)
   - Foundation (data management)

5. **Build and Run**
   - Select your target device or simulator
   - Press Cmd+R or click the Play button
   - For phone functionality, test on a real device

### Testing

#### On Simulator
- All UI features work
- Phone calls show alert but won't connect
- Data storage and encryption work fully

#### On Physical Device
- Full phone call functionality
- Test with a test phone number first
- Emergency calls (911) will connect to real emergency services

### Testing Checklist
- [ ] Panic button shows confirmation
- [ ] Mood journal saves and encrypts data
- [ ] Coping skills display correctly
- [ ] Meditation timer works
- [ ] Emergency contacts can be added/edited/deleted
- [ ] VoiceOver navigation works
- [ ] Dynamic Type scales text
- [ ] Data persists after app restart
- [ ] Data deletion removes all entries

## Privacy & Safety

### Data Privacy
- **No data collection**: App doesn't collect, store, or transmit data to external servers
- **Local storage only**: All data stays on your device
- **Encrypted**: AES-256 encryption protects your mood entries and contacts
- **No user accounts**: No registration, login, or email required
- **No tracking**: No analytics, cookies, or third-party trackers
- **No ads**: Completely ad-free experience

### User Control
- **Export data**: Export all your data as text
- **Delete data**: Permanently delete all app data anytime
- **Offline capable**: Works without internet (except phone calls)

### Safety
- **Verified hotlines**: All crisis resources are legitimate, trusted services
- **Confirmation dialogs**: Alerts before calling to prevent accidental calls
- **HIPAA compliant**: Healthcare data protection standards
- **COPPA compliant**: Safe for teens, no data collection from minors
- **WCAG accessible**: Full VoiceOver and accessibility support

## Crisis Resources Included

### National 988 Suicide & Crisis Lifeline
- Available 24/7
- Free and confidential
- Professional counselors
- Call or text 988

### Crisis Text Line
- Text-based crisis support
- Available 24/7
- Text HOME to 741741

### Teen Line (Teens helping teens)
- Available 6pm-10pm PT daily
- Call: (310) 855-4673
- Text: TEEN to 839863

### Trevor Project (LGBTQ+ Youth)
- 24/7 support for LGBTQ+ youth
- Call: 1-866-488-7386
- Text: START to 678678

## Important Notes

⚠️ **This app is not a replacement for professional medical advice, diagnosis, or treatment.**

- If you're experiencing a medical emergency, call 911
- For ongoing mental health concerns, please consult with a healthcare provider
- This app provides quick access to crisis resources but is not a substitute for therapy or counseling

## Future Enhancements

Potential features for future versions:
- Audio-guided meditations with recordings
- Mood trend analytics and insights
- Daily affirmations and reminders
- Integration with HealthKit for wellness tracking
- Customizable coping strategies
- Group support features
- Therapist/counselor connection
- Multi-language support

## Compliance

This app is designed to comply with:
- **HIPAA**: Healthcare data protection
- **COPPA**: Children's online privacy (13+)
- **WCAG 2.1 Level AA**: Accessibility standards

See `COMPLIANCE.md` for detailed compliance documentation.

## License

This is a sample project created for educational purposes.

## Support

If you're in crisis or need someone to talk to:
- Call 988 (Suicide & Crisis Lifeline)
- Text HOME to 741741 (Crisis Text Line)
- Call 1-800-273-8255 (National Suicide Prevention Lifeline)

You're not alone. Help is available.
