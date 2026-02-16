# StressMind - Complete Requirements Document

**Last Updated**: 2026-02-16
**Version**: 1.0
**Status**: Pre-Launch Development

---

## Executive Summary

StressMind is a free, privacy-focused iOS app designed to help early teens (13-15 years) manage stress and access mental health crisis resources. The app must launch within 1-2 months for public App Store release.

---

## 1. Product Requirements

### 1.1 Target Audience
- **Primary**: Ages 13-15 (early teens, middle school age)
- **Secondary**: Parents/guardians (optional sharing features)
- **Tertiary**: School counselors, therapists (can recommend app)

### 1.2 Core Features (Must Have)

#### Crisis Support
- ✅ **988 Panic Button**: One-tap access, <1 second response time
- ✅ **Crisis Text Line**: SMS integration to 741741
- ✅ **Teen Line**: Peer support (310) 855-4673
- ✅ **Trevor Project**: LGBTQ+ support 1-866-488-7386
- ✅ **Emergency 911**: Clear warnings, confirmation dialog

#### Mood Tracking
- ✅ **Daily Mood Logging**: 7 mood types with emojis
- ✅ **Notes & Tags**: Help identify patterns
- ✅ **History View**: Recent moods visualization
- ✅ **Encrypted Storage**: AES-256 local only

#### Coping Skills
- ✅ **Evidence-Based Techniques**: 9+ clinically-validated methods
- ✅ **Step-by-Step Instructions**: Clear, actionable guidance
- ✅ **Progress Tracking**: Check off completed steps
- ✅ **Categories**: Grounding, Distraction, Relaxation, Cognitive

#### Guided Meditations
- ✅ **Text-Based Guidance**: 8+ meditation sessions
- ✅ **Multiple Durations**: 5-20 minute options
- ✅ **Timer & Progress**: Visual feedback during session
- ✅ **Categories**: Breathing, Relaxation, Mindfulness, Sleep

#### Emergency Contacts
- ✅ **Personal Contacts**: Add trusted people
- ✅ **One-Tap Calling**: Quick access during crisis
- ✅ **Encrypted Storage**: Privacy protected
- ✅ **Crisis Hotlines**: Pre-populated, always available

### 1.3 New Features (From Requirements)

#### Parental Sharing (Optional)
- 🆕 **Opt-In System**: Teen controls what parents see
- 🆕 **Shareable Summary**: Export mood trends (no notes)
- 🆕 **Emergency Alert**: Option to notify parent of mood concerns
- 🆕 **Privacy Controls**: Teen can revoke access anytime

### 1.4 Features Explicitly Excluded (v1.0)
- ❌ Backend server or cloud sync
- ❌ User accounts or authentication
- ❌ In-app purchases or subscriptions
- ❌ Social features or community
- ❌ Audio recordings (text-only meditations)
- ❌ Push notifications (may add later with permission)
- ❌ iPad optimization (iPhone-focused)
- ❌ Network analytics or tracking

---

## 2. Technical Requirements

### 2.1 Platform & Compatibility

**Platform**
- iOS 15.0 minimum (September 2021 devices)
- iPhone only (no iPad optimization required)
- Portrait orientation primary, landscape supported

**Device Support**
- iPhone 8 and newer (A11 Bionic+)
- iPhone SE (2nd generation) and newer
- Must run smoothly on 3GB RAM devices

**Accessibility**
- VoiceOver full support (WCAG 2.1 Level AA)
- Dynamic Type (text scaling)
- Voice Control compatibility
- High contrast mode support

### 2.2 Architecture

**Design Pattern**
- MVVM (Model-View-ViewModel)
- SwiftUI for all UI
- Combine for reactive programming
- No third-party dependencies

**Data Storage**
- Local only (no network requests except tel://, sms://)
- UserDefaults for encrypted data blobs
- iOS Keychain for encryption keys
- No CoreData (overkill for current needs)

**Encryption**
- AES-256-GCM (authenticated encryption)
- CryptoKit framework
- Unique key per installation
- Key never leaves device

### 2.3 Performance Requirements

**Critical Performance Metrics**
- ✅ **App Launch**: <2 seconds cold start
- ✅ **Panic Button Response**: <1 second from tap to alert
- ✅ **Tab Switching**: <200ms animation
- ✅ **List Scrolling**: 60fps minimum
- ✅ **Battery Usage**: <2% per hour active use
- ✅ **Memory Footprint**: <100MB typical usage

**Optimization Targets**
- Lazy loading for long lists
- Image caching (SF Symbols only)
- Efficient data persistence (batch operations)
- Background task minimization

### 2.4 Security Requirements

**Data Protection**
- AES-256-GCM encryption for all personal data
- Secure key storage (iOS Keychain)
- No data transmission (airplane mode compatible)
- Secure deletion (overwrite on delete)

**Code Security**
- No hardcoded secrets
- Input validation on all forms
- Confirmation dialogs for destructive actions
- Sandboxed app environment

### 2.5 Technology Stack

**Languages & Frameworks**
- Swift 5.9+
- SwiftUI (iOS 15+)
- CryptoKit (encryption)
- Foundation (core utilities)

**Development Tools**
- Xcode 14.0+ (14.3 recommended)
- SwiftLint (enforced style guide)
- Git (version control)
- GitHub/GitLab (repository hosting)

**Testing Frameworks**
- XCTest (unit tests)
- XCUITest (UI automation)
- Manual accessibility testing

---

## 3. Engineering Principles

### 3.1 Code Quality Standards

**Documentation**
- All public methods documented with Swift doc comments
- Complex logic explained with inline comments
- README for each major feature/module
- Architecture decision records (ADRs)

**Style Guide**
- SwiftLint enforced (default rules)
- Apple Swift Style Guide compliance
- Consistent naming conventions
- Max function length: 50 lines
- Max file length: 400 lines

**Code Review**
- All changes via pull requests
- Minimum 1 reviewer approval
- CI checks must pass
- No direct commits to main branch

### 3.2 Testing Standards

**Unit Tests** (Required)
- All business logic covered
- DataManager encryption/decryption
- Data persistence operations
- Edge cases and error handling
- Target: 70%+ code coverage

**UI Tests** (Required)
- Critical user flows
- Panic button functionality
- Form submissions
- Navigation flows
- Tab switching

**Manual Testing** (Required)
- VoiceOver navigation
- Physical device testing
- Crisis hotline calls (safe numbers)
- Data persistence verification
- Performance profiling

**Clinical Review** (Required)
- Advisory board of mental health professionals
- Review all crisis resources
- Validate coping skills content
- Check meditation instructions
- Approve warning signs and disclaimers

### 3.3 Git Workflow

**Branch Strategy**
- `main`: Production-ready code
- `develop`: Integration branch
- `feature/*`: New features
- `bugfix/*`: Bug fixes
- `hotfix/*`: Emergency fixes

**Commit Standards**
- Conventional Commits format
- Clear, descriptive messages
- Atomic commits (one logical change)
- Sign commits (verified)

**Pull Request Process**
1. Create feature branch from `develop`
2. Implement feature with tests
3. Run SwiftLint and fix issues
4. Submit PR with description
5. Pass CI checks
6. Code review approval
7. Merge to `develop`
8. Delete feature branch

### 3.4 Continuous Integration

**Automated Checks**
- SwiftLint violations (fail on warning)
- Unit test execution (must pass all)
- Build verification (debug + release)
- Code coverage report (tracked)

**CI Platform Options**
- GitHub Actions (recommended)
- Xcode Cloud
- Bitrise
- CircleCI

---

## 4. Hard Constraints

### 4.1 Non-Negotiable Requirements

**Free Forever**
- ✅ No purchase price
- ✅ No in-app purchases
- ✅ No subscriptions
- ✅ No ads or monetization
- **Rationale**: Mental health support should be accessible to all

**100% Offline**
- ✅ No network requests except tel:// and sms://
- ✅ Works in airplane mode
- ✅ No analytics or tracking
- ✅ No cloud sync or backup
- **Rationale**: Privacy-first, works anywhere

**iPhone Only**
- ✅ No iPad optimization required
- ✅ iPhone layouts only
- ✅ Portrait-first design
- **Rationale**: Focus resources, teens primarily use phones

**No User Accounts**
- ✅ No email collection
- ✅ No username/password
- ✅ No authentication
- ✅ No profile data
- **Rationale**: Maximum privacy, minimum friction

### 4.2 Timeline Constraints

**Launch Target**: 1-2 months from now

**Week 1-2**: Development
- Complete parental sharing feature
- Add unit tests
- Implement SwiftLint
- Documentation updates

**Week 3-4**: Testing & Review
- Manual testing (QA)
- Accessibility audit
- Clinical advisory board review
- Performance optimization

**Week 5-6**: App Store Preparation
- Screenshots (all device sizes)
- App preview video
- App Store description
- Keywords/ASO optimization
- Privacy policy finalization

**Week 7-8**: Submission & Launch
- App Store submission
- Review responses
- Launch marketing materials
- Post-launch monitoring

### 4.3 Budget Constraints

**Development**: Self-funded or minimal budget
**Apple Developer**: $99/year (required)
**Clinical Review**: Pro bono advisory board
**No paid services**: No cloud hosting, analytics, or third-party tools

---

## 5. Compliance Requirements

### 5.1 Legal Compliance

**HIPAA (Health Insurance Portability and Accountability Act)**
- ✅ Encrypted data storage (AES-256)
- ✅ No data transmission
- ✅ User data export
- ✅ User data deletion
- ✅ Secure key management

**COPPA (Children's Online Privacy Protection Act)**
- ✅ No data collection (13+ years)
- ✅ No tracking or cookies
- ✅ No third-party sharing
- ✅ Clear privacy policy
- ✅ Parental notification option

**WCAG 2.1 Level AA (Web Content Accessibility Guidelines)**
- ✅ VoiceOver screen reader support
- ✅ Dynamic Type (text scaling)
- ✅ Color contrast ratios >4.5:1
- ✅ Touch targets >44x44 points
- ✅ Keyboard navigation
- ✅ Focus indicators

### 5.2 App Store Requirements

**Age Rating**: 12+ (Medical/Treatment Information)

**Content Guidelines**
- No graphic content
- Age-appropriate language
- Professional resources only
- Clear disclaimers

**Privacy Nutrition Labels**
- Data Not Collected: All categories
- Data Not Used for Tracking: Yes
- Data Not Linked to User: N/A

**Review Considerations**
- Not a medical device
- Provides information access only
- Links to verified crisis resources
- Clear emergency disclaimers

---

## 6. Content Requirements

### 6.1 Language & Readability

**Target Reading Level**: 8th-9th grade (current implementation)
- Clear, conversational tone
- Short sentences and paragraphs
- Define mental health terms
- Avoid medical jargon
- Supportive, non-judgmental language

**Voice & Tone**
- Empathetic and supportive
- Direct but gentle
- Teen-friendly (not childish)
- Hopeful and empowering
- Non-patronizing

### 6.2 Crisis Resources

**Required Information**
- Hotline name
- Phone number
- Hours of operation
- What to expect (call/text)
- Why to use it

**Quality Standards**
- Verified legitimate services
- Active phone numbers
- Current operating hours
- Accurate descriptions

### 6.3 Coping Skills Content

**Validation Requirements**
- Evidence-based techniques only
- Reviewed by mental health professionals
- Clear, step-by-step instructions
- Age-appropriate language
- No pseudo-science

**Categories Must Include**
- Grounding exercises (5-4-3-2-1, etc.)
- Breathing techniques
- Cognitive strategies
- Relaxation methods
- Distraction techniques

---

## 7. App Store Optimization (ASO)

### 7.1 Keywords Strategy

**Primary Keywords**
- teen stress relief
- anxiety help for teens
- mental health teens
- stress management app
- crisis hotline access

**Secondary Keywords**
- breathing exercises teens
- coping skills anxiety
- teen mental wellness
- mood tracker teens
- mindfulness for teens

### 7.2 App Store Listing

**App Name**: StressMind - Teen Stress Relief

**Subtitle**: Mental Health Support & Crisis Help

**Description** (Key Points)
- Free, private, and safe mental health support
- 988 crisis hotline quick access
- Mood journal with encryption
- Evidence-based coping skills
- Guided meditations
- No ads, no accounts, no data collection

**Promotional Text**
- Updated regularly with new features
- 100% free forever, no hidden costs
- Your privacy is our priority

### 7.3 Marketing Materials

**Required Assets**
- App icon (1024x1024)
- iPhone screenshots (6.5", 6.7", 5.5")
- App preview video (15-30 seconds)
- Press kit (logo, description, screenshots)

**Screenshot Themes**
1. Panic button / Crisis support
2. Mood journal entry
3. Coping skills library
4. Meditation session
5. Privacy & encryption

**App Preview Video**
- 15-20 seconds
- Show panic button access
- Demonstrate mood logging
- Show coping skill example
- End with "Free, Private, Safe"

---

## 8. Clinical Review Requirements

### 8.1 Advisory Board Composition

**Recommended Members** (3-5 people)
- Licensed clinical psychologist or therapist (teen specialization)
- School counselor or social worker
- Crisis intervention specialist
- Teen peer advocate (17-19 years)
- Pediatrician or child psychiatrist (optional)

### 8.2 Review Scope

**Content Review**
- All crisis hotline descriptions
- Coping skills instructions
- Meditation guidance
- Warning signs checklist
- Disclaimers and safety information

**Feature Review**
- Panic button flow and timing
- Mood tracking categories
- Emergency contact functionality
- Settings and privacy controls

**Safety Review**
- Age-appropriateness
- Risk assessment (self-harm, suicide)
- Escalation pathways (when to call 911)
- Mandatory reporting considerations

### 8.3 Sign-Off Requirements

**Written Approval**
- Content accuracy
- Safety considerations
- Age-appropriateness
- Clinical validity

**Ongoing Consultation**
- Available for post-launch questions
- Annual content review
- Update approvals

---

## 9. Success Metrics

### 9.1 Launch Metrics

**Week 1**
- App Store approval within 7 days
- Zero critical bugs
- 4.0+ star rating (if reviews)
- 100+ downloads

**Month 1**
- 1,000+ downloads
- 4.2+ star rating
- <1% crash rate
- Zero privacy complaints

### 9.2 Quality Metrics

**Performance**
- App launch <2s (95th percentile)
- Panic button <1s (100%)
- Zero memory leaks
- 60fps scrolling

**Accessibility**
- VoiceOver completion rate >90%
- Zero accessibility complaints
- WCAG 2.1 AA audit pass

**Reliability**
- Crash rate <0.5%
- Data persistence 100%
- Encryption success 100%

---

## 10. Risk Management

### 10.1 Technical Risks

**Risk**: App Store rejection
- **Mitigation**: Follow guidelines strictly, professional review
- **Contingency**: Address feedback quickly, resubmit

**Risk**: Performance issues on older devices
- **Mitigation**: Test on iPhone 8, profile performance
- **Contingency**: Optimize or raise minimum iOS version

**Risk**: Encryption bugs or data loss
- **Mitigation**: Extensive testing, backup strategy
- **Contingency**: Data export feature, clear warnings

### 10.2 Legal Risks

**Risk**: HIPAA/COPPA compliance concerns
- **Mitigation**: Legal review, strict privacy policy
- **Contingency**: Privacy counsel consultation

**Risk**: Liability for crisis outcomes
- **Mitigation**: Clear disclaimers, information-only approach
- **Contingency**: Liability insurance, legal counsel

### 10.3 Content Risks

**Risk**: Inappropriate content for age group
- **Mitigation**: Clinical review, parent feedback
- **Contingency**: Content adjustment, age rating change

**Risk**: Outdated crisis hotline information
- **Mitigation**: Quarterly verification, user reports
- **Contingency**: Emergency update process

---

## 11. Post-Launch Plan

### 11.1 Monitoring (First 30 Days)

**Daily Checks**
- App Store rating/reviews
- Crash reports (Xcode Organizer)
- User feedback emails
- Social media mentions

**Weekly Reviews**
- Download trends
- Performance metrics
- Feature usage (if safe telemetry added)
- Support requests

### 11.2 Update Cadence

**Bug Fixes**: Within 48 hours for critical issues
**Minor Updates**: Monthly (new coping skills, meditations)
**Major Updates**: Quarterly (new features)
**Content Updates**: As needed (hotline changes)

### 11.3 Version 1.1 Planning (3 months)

**Potential Features**
- Audio-guided meditations
- Mood trend analytics
- More coping skills
- Spanish language support
- Widget for quick access

---

## 12. Open Questions & Decisions Needed

### 12.1 Before Development Completion

- [ ] Advisory board members identified and committed?
- [ ] Privacy policy drafted and reviewed?
- [ ] App Store account created and configured?
- [ ] Marketing materials prepared?

### 12.2 Before Launch

- [ ] Clinical review completed and approved?
- [ ] All unit tests written and passing?
- [ ] Accessibility audit completed?
- [ ] Beta testing completed (TestFlight)?
- [ ] App Store listing ready?

### 12.3 Post-Launch

- [ ] Support email monitored?
- [ ] Update schedule defined?
- [ ] Advisory board ongoing engagement?
- [ ] User feedback mechanism?

---

## Appendix A: User Stories

**As a teen in crisis**, I want immediate access to a crisis hotline so I can get help quickly.

**As a stressed teen**, I want to track my mood daily so I can understand my emotional patterns.

**As an anxious teen**, I want guided coping techniques so I can calm down when overwhelmed.

**As a teen with insomnia**, I want bedtime meditations so I can fall asleep more easily.

**As a teen needing support**, I want to call trusted contacts so I don't feel alone.

**As a privacy-conscious teen**, I want my data encrypted so no one can see my personal thoughts.

**As a parent**, I want optional visibility into my teen's mood trends (with their permission) so I can support them better.

---

## Appendix B: Resources

**Crisis Hotlines**
- 988 Suicide & Crisis Lifeline: https://988lifeline.org
- Crisis Text Line: https://www.crisistextline.org
- Teen Line: https://teenlineonline.org
- Trevor Project: https://www.thetrevorproject.org

**Mental Health Organizations**
- NAMI (National Alliance on Mental Illness): https://www.nami.org
- JED Foundation: https://jedfoundation.org
- Active Minds: https://www.activeminds.org

**Technical Resources**
- Apple Human Interface Guidelines: https://developer.apple.com/design/
- WCAG 2.1: https://www.w3.org/WAI/WCAG21/quickref/
- HIPAA Compliance: https://www.hhs.gov/hipaa/

---

**Document End**

This requirements document should be reviewed and approved by:
- [ ] Product Owner
- [ ] Technical Lead
- [ ] Clinical Advisory Board Lead
- [ ] Legal Counsel (for privacy/liability)
