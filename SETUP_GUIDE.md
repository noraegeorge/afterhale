# StressMind - Complete Setup Guide

This guide will walk you through setting up the StressMind iOS app in Xcode from scratch.

## Prerequisites

Before you begin, ensure you have:
- **macOS** (Ventura 13.0 or later recommended)
- **Xcode 14.0+** (download from Mac App Store)
- **Apple Developer Account** (free or paid, for device testing)
- **iPhone/iPad running iOS 15.0+** (for real device testing)

## Step 1: Create New Xcode Project

1. **Open Xcode**
   - Launch Xcode from Applications

2. **Create New Project**
   - Click "Create a new Xcode project"
   - Or: File > New > Project (⇧⌘N)

3. **Choose Template**
   - Select **iOS** tab
   - Choose **App** template
   - Click **Next**

4. **Configure Project**
   - **Product Name**: `StressMind`
   - **Team**: Select your Apple Developer account
   - **Organization Identifier**: `com.yourcompany` (use your own)
   - **Bundle Identifier**: Will auto-generate (e.g., `com.yourcompany.StressMind`)
   - **Interface**: **SwiftUI**
   - **Language**: **Swift**
   - **Storage**: Core Data - **Unchecked**
   - **Include Tests**: **Checked** (recommended)
   - Click **Next**

5. **Choose Location**
   - Select where to save your project
   - **Create Git repository**: Check if you want version control
   - Click **Create**

## Step 2: Configure Project Settings

1. **Select Project in Navigator**
   - Click on "StressMind" at the top of the Project Navigator (left sidebar)

2. **General Tab**
   - **Display Name**: StressMind
   - **Bundle Identifier**: Verify it's correct
   - **Version**: 1.0
   - **Build**: 1
   - **Deployment Target**: iOS 15.0
   - **Supported Destinations**: iPhone
   - **Supported Orientations**: Portrait, Landscape Left, Landscape Right

3. **Signing & Capabilities Tab**
   - **Automatically manage signing**: Check
   - **Team**: Select your Apple Developer account
   - **Signing Certificate**: Should show "Apple Development"

## Step 3: Organize Project Structure

1. **Create Folder Groups**
   Right-click on "StressMind" folder in Project Navigator:

   - Create group named `Models`
   - Create group named `Services`
   - Create group named `Views`

2. **Your structure should look like:**
   ```
   StressMind
   ├── StressMindApp.swift
   ├── ContentView.swift
   ├── Models
   ├── Services
   └── Views
   ```

## Step 4: Add Source Files

### A. Replace Root Files

1. **Delete default ContentView.swift**
   - Right-click > Delete
   - Choose "Move to Trash"

2. **Replace StressMindApp.swift**
   - Open the provided `StressMindApp.swift`
   - Copy all content
   - Paste into your project's `StressMindApp.swift`

3. **Add new ContentView.swift**
   - File > New > File (⌘N)
   - Choose "Swift File"
   - Name it `ContentView.swift`
   - Save in project root
   - Copy content from provided `ContentView.swift`

### B. Add Model Files

1. **Add DataModels.swift**
   - File > New > File
   - Choose "Swift File"
   - Name: `DataModels.swift`
   - **Group**: Select `Models` folder
   - Click Create
   - Copy content from provided file

### C. Add Service Files

1. **Add DataManager.swift**
   - File > New > File
   - Choose "Swift File"
   - Name: `DataManager.swift`
   - **Group**: Select `Services` folder
   - Copy content from provided file

### D. Add View Files

Add each view file to the `Views` group:

1. **HomeView.swift**
2. **MoodTrackerView.swift**
3. **CopingSkillsView.swift**
4. **MeditationView.swift**
5. **EmergencyContactsView.swift**
6. **SettingsView.swift**

Optional (legacy):
7. **BreathingView.swift**
8. **ResourcesView.swift**

For each file:
- File > New > File
- Choose "Swift File"
- Name it correctly
- Save in `Views` group
- Copy content from provided file

## Step 5: Configure Info.plist

1. **Open Info.plist**
   - Click on `Info.plist` in Project Navigator

2. **Add URL Schemes** (if not already present)
   - Click the **+** button
   - Add key: `LSApplicationQueriesSchemes`
   - Type: Array
   - Add items:
     - Item 0: String = `tel`
     - Item 1: String = `sms`

3. **Verify Display Name**
   - Find `Bundle display name` (or add if missing)
   - Value: `StressMind`

## Step 6: Build and Test

### Build the Project

1. **Select Target Device**
   - Click device selector next to "StressMind" at top
   - Choose "iPhone 15 Pro" (or any simulator)

2. **Build Project**
   - Product > Build (⌘B)
   - Wait for build to complete
   - Check for errors in Issue Navigator

3. **Fix Any Errors**
   - Most common: Missing imports
   - Solution: Add `import SwiftUI` at top of files if needed

### Run on Simulator

1. **Run App**
   - Product > Run (⌘R)
   - Or: Click Play button (▶)

2. **Test Features**
   - [ ] App launches successfully
   - [ ] All 5 tabs visible
   - [ ] Home view shows panic button
   - [ ] Mood journal opens
   - [ ] Coping skills load
   - [ ] Meditations display
   - [ ] Emergency contacts work
   - [ ] Settings accessible

### Test on Physical Device

1. **Connect iPhone**
   - Connect via USB cable
   - Trust computer if prompted
   - Enter device passcode

2. **Select Your Device**
   - Device selector > Your iPhone name

3. **Run on Device**
   - Click Run (⌘R)
   - First time may ask for permission
   - App installs and launches

4. **Test Phone Functionality**
   - **IMPORTANT**: Test with a safe number first, not 911!
   - Try calling a known number
   - Verify confirmation dialogs appear

## Step 7: Testing Checklist

### Functional Testing
- [ ] Panic button shows alert
- [ ] Crisis hotline buttons work
- [ ] Mood entry saves successfully
- [ ] Mood entries display in list
- [ ] Mood entries can be deleted
- [ ] Coping skills open detail view
- [ ] Meditation timer works
- [ ] Emergency contact can be added
- [ ] Emergency contact can be edited
- [ ] Emergency contact can be deleted
- [ ] Settings opens
- [ ] Data export works
- [ ] Data deletion works

### Accessibility Testing
- [ ] Enable VoiceOver (Settings > Accessibility > VoiceOver)
- [ ] Navigate through app with VoiceOver
- [ ] All buttons have labels
- [ ] All images have descriptions
- [ ] Forms are navigable
- [ ] Alerts are announced

### Data Persistence Testing
- [ ] Add mood entry
- [ ] Force quit app (swipe up from app switcher)
- [ ] Reopen app
- [ ] Verify mood entry still exists
- [ ] Add emergency contact
- [ ] Force quit app
- [ ] Reopen app
- [ ] Verify contact still exists

## Step 8: Common Issues & Solutions

### Build Errors

**Error**: "No such module 'CryptoKit'"
- **Solution**: Check Deployment Target is iOS 15.0+

**Error**: "Cannot find 'DataManager' in scope"
- **Solution**: Ensure DataManager.swift is added to target
- Click file > Show File Inspector > Target Membership > Check StressMind

**Error**: "Cannot find type 'MoodEntry' in scope"
- **Solution**: Ensure DataModels.swift is added to target

### Runtime Errors

**App crashes on launch**
- Check Console for error messages
- Verify all @State properties initialized
- Ensure DataManager.shared is accessible

**Phone calls don't work in simulator**
- **Expected**: Simulator can't make real calls
- **Solution**: Test on physical device

**VoiceOver doesn't read labels**
- Add `.accessibilityLabel()` modifiers
- Check that elements aren't hidden from accessibility

## Step 9: Prepare for Distribution

### App Icon

1. **Create Icon Assets**
   - Need 1024x1024 PNG image
   - No transparency
   - No alpha channel

2. **Add to Project**
   - Assets.xcassets > AppIcon
   - Drag 1024x1024 image to "1024pt" slot

### Privacy Policy

1. **Write Privacy Policy**
   - See COMPLIANCE.md for requirements
   - Host on website or include in app

2. **Add to App**
   - Can add as Settings > Privacy Policy

### App Store Connect

1. **Create App Record**
   - Log in to appstoreconnect.apple.com
   - My Apps > + > New App
   - Fill in details

2. **Privacy Nutrition Labels**
   - Data Not Collected: Check all
   - No tracking
   - No data linked to user

## Step 10: Advanced Configuration (Optional)

### Enable Encryption Stronger Than Default

Already implemented via:
- CryptoKit AES-256-GCM
- iOS Keychain for key storage

### Add App Transport Security Exception

Not needed - no network requests except tel:// and sms://

### Configure Background Modes

Not needed for current features

### Add Push Notifications

Future feature - not in v1.0

## Troubleshooting

### App Won't Build

1. Clean Build Folder: Product > Clean Build Folder (⇧⌘K)
2. Delete Derived Data:
   - Xcode > Preferences > Locations
   - Click arrow next to Derived Data
   - Delete "StressMind-..." folder
3. Restart Xcode

### App Won't Run on Device

1. Check device is unlocked
2. Trust developer certificate on device:
   - Settings > General > VPN & Device Management
   - Tap your developer account
   - Tap "Trust"
3. Verify Bundle Identifier is unique

### Data Not Persisting

1. Check DataManager initialization
2. Verify encryption key created
3. Check UserDefaults writes
4. Enable breakpoints in save methods

### VoiceOver Not Working

1. Check accessibility labels exist
2. Verify elements aren't `.accessibilityHidden()`
3. Test with VoiceOver Practice mode
4. Check accessibility traits are correct

## Next Steps

After successful setup:

1. **Customize**
   - Change app name/branding
   - Modify color scheme
   - Add your own features

2. **Test Thoroughly**
   - All features
   - All devices (iPhone, iPad)
   - Accessibility
   - Data persistence

3. **Get Feedback**
   - TestFlight beta testing
   - User testing with teens
   - Accessibility testing

4. **Prepare for Submission**
   - App Store screenshots
   - Description and keywords
   - Privacy policy
   - Support URL

## Resources

- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)
- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)

## Getting Help

If you encounter issues:

1. Check error messages in Xcode console
2. Review build logs
3. Search Apple Developer Forums
4. Check Stack Overflow
5. Review PROJECT_SUMMARY.md for architecture details

## Success Checklist

Before considering setup complete:

- [ ] Project builds without errors
- [ ] App runs on simulator
- [ ] App runs on physical device
- [ ] All 5 tabs functional
- [ ] Phone calls work (on device)
- [ ] Data persists after restart
- [ ] VoiceOver navigation works
- [ ] No crashes during normal use
- [ ] Settings and data export work

---

**Congratulations!** You've successfully set up StressMind. You're ready to help teens manage stress! 🎉

For questions about specific features, see:
- **README.md**: Feature documentation
- **COMPLIANCE.md**: Privacy and compliance
- **PROJECT_SUMMARY.md**: Technical architecture
