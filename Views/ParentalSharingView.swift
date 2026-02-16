import SwiftUI

struct ParentalSharingView: View {
    @StateObject private var sharingManager = ParentalSharingManager.shared
    @State private var showingSetupSheet = false
    @State private var showingShareSheet = false
    @State private var shareContent = ""
    @State private var selectedTimeframe: ParentalSharingManager.Timeframe = .lastTwoWeeks

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.1)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        // Header
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Parent Sharing")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .accessibilityAddTraits(.isHeader)

                            Text("Share your mood summary with a parent or guardian (optional)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()

                        // Privacy Notice
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "lock.shield.fill")
                                    .foregroundColor(.green)
                                Text("Your Privacy")
                                    .font(.headline)
                            }

                            Text("You are always in control:")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            PrivacyPoint(text: "Your notes are NEVER shared")
                            PrivacyPoint(text: "You choose what to share")
                            PrivacyPoint(text: "You can disable this anytime")
                            PrivacyPoint(text: "Sharing is completely optional")
                        }
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(15)

                        // Sharing Status
                        if sharingManager.settings.isEnabled {
                            VStack(alignment: .leading, spacing: 15) {
                                HStack {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                    Text("Sharing Enabled")
                                        .font(.headline)
                                    Spacer()
                                    Button("Disable") {
                                        withAnimation {
                                            sharingManager.disableSharing()
                                        }
                                    }
                                    .foregroundColor(.red)
                                }

                                if !sharingManager.settings.sharedWith.isEmpty {
                                    Text("Sharing with:")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)

                                    ForEach(sharingManager.settings.sharedWith) { contact in
                                        HStack {
                                            Image(systemName: "person.circle.fill")
                                                .foregroundColor(.blue)
                                            VStack(alignment: .leading) {
                                                Text(contact.name)
                                                    .font(.subheadline)
                                                Text(contact.relationship)
                                                    .font(.caption)
                                                    .foregroundColor(.secondary)
                                            }
                                            Spacer()
                                            Text(contact.shareMethod.rawValue)
                                                .font(.caption)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(Color.blue.opacity(0.2))
                                                .cornerRadius(8)
                                        }
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                    }
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.1), radius: 10)
                        } else {
                            VStack(spacing: 15) {
                                Image(systemName: "person.2.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(.secondary)

                                Text("Sharing Disabled")
                                    .font(.headline)
                                    .foregroundColor(.secondary)

                                Text("You can enable sharing to let a parent or guardian see your mood summary")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)

                                Button("Set Up Sharing") {
                                    showingSetupSheet = true
                                }
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                            }
                            .padding(40)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.1), radius: 10)
                        }

                        // Generate Summary Section
                        if sharingManager.settings.isEnabled || true {
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Generate Mood Summary")
                                    .font(.title2)
                                    .fontWeight(.bold)

                                Text("Create a summary to share with someone you trust")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)

                                Picker("Time Range", selection: $selectedTimeframe) {
                                    Text("Last Week").tag(ParentalSharingManager.Timeframe.lastWeek)
                                    Text("Last 2 Weeks").tag(ParentalSharingManager.Timeframe.lastTwoWeeks)
                                    Text("Last Month").tag(ParentalSharingManager.Timeframe.lastMonth)
                                    Text("Last 90 Days").tag(ParentalSharingManager.Timeframe.last90Days)
                                }
                                .pickerStyle(.segmented)

                                Button(action: generateAndShare) {
                                    HStack {
                                        Image(systemName: "square.and.arrow.up")
                                        Text("Generate Summary")
                                    }
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.purple)
                                    .cornerRadius(12)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.1), radius: 10)
                        }

                        // What's Shared Section
                        VStack(alignment: .leading, spacing: 15) {
                            Text("What Gets Shared?")
                                .font(.title2)
                                .fontWeight(.bold)

                            ShareInfoRow(icon: "chart.bar.fill", title: "Mood Breakdown", description: "How often you felt each mood", isShared: true)
                            ShareInfoRow(icon: "tag.fill", title: "Common Tags", description: "Frequent themes (school, friends, etc.)", isShared: true)
                            ShareInfoRow(icon: "arrow.up.right", title: "Trend", description: "Overall mood direction", isShared: true)
                            ShareInfoRow(icon: "note.text", title: "Your Notes", description: "Private thoughts and details", isShared: false)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 10)
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingSetupSheet) {
                ParentalSharingSetupView()
            }
            .sheet(isPresented: $showingShareSheet) {
                ShareSheet(content: shareContent)
            }
        }
    }

    private func generateAndShare() {
        shareContent = sharingManager.generateShareableContent(timeframe: selectedTimeframe)
        showingShareSheet = true
    }
}

struct PrivacyPoint: View {
    let text: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .font(.caption)
            Text(text)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
    }
}

struct ShareInfoRow: View {
    let icon: String
    let title: String
    let description: String
    let isShared: Bool

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(isShared ? .green : .red)
                .frame(width: 40, height: 40)
                .background((isShared ? Color.green : Color.red).opacity(0.2))
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Image(systemName: isShared ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundColor(isShared ? .green : .red)
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(10)
    }
}

struct ParentalSharingSetupView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var sharingManager = ParentalSharingManager.shared

    @State private var contactName = ""
    @State private var relationship = "Parent"
    @State private var shareMethod: ParentalSharingSettings.SharedContact.ShareMethod = .sms

    let relationships = ["Parent", "Guardian", "Counselor", "Trusted Adult"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("You're about to enable mood sharing. You can disable this anytime.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                } header: {
                    Text("Enable Sharing")
                }

                Section {
                    TextField("Name", text: $contactName)

                    Picker("Relationship", selection: $relationship) {
                        ForEach(relationships, id: \.self) { rel in
                            Text(rel).tag(rel)
                        }
                    }

                    Picker("Share Method", selection: $shareMethod) {
                        Text("Text Message").tag(ParentalSharingSettings.SharedContact.ShareMethod.sms)
                        Text("Email").tag(ParentalSharingSettings.SharedContact.ShareMethod.email)
                        Text("In Person").tag(ParentalSharingSettings.SharedContact.ShareMethod.inPerson)
                    }
                } header: {
                    Text("Who Are You Sharing With?")
                }

                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        PrivacyPoint(text: "Your detailed notes are NEVER shared")
                        PrivacyPoint(text: "Only mood trends and tags are shared")
                        PrivacyPoint(text: "You control when summaries are sent")
                        PrivacyPoint(text: "You can stop sharing anytime")
                    }
                } header: {
                    Text("Privacy Reminder")
                }
            }
            .navigationTitle("Set Up Sharing")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Enable") {
                        enableSharing()
                    }
                    .disabled(contactName.isEmpty)
                }
            }
        }
    }

    private func enableSharing() {
        var settings = sharingManager.settings
        settings.isEnabled = true
        settings.shareDate = Date()

        let contact = ParentalSharingSettings.SharedContact(
            name: contactName,
            relationship: relationship,
            shareMethod: shareMethod
        )
        settings.sharedWith = [contact]

        sharingManager.updateSettings(settings)
        dismiss()
    }
}

struct ShareSheet: View {
    let content: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                Text(content)
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textSelection(.enabled)
            }
            .navigationTitle("Mood Summary")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .primaryAction) {
                    ShareLink(item: content) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
        }
    }
}

#Preview {
    ParentalSharingView()
}
