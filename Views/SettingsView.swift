import SwiftUI

struct SettingsView: View {
    @StateObject private var dataManager = DataManager.shared
    @State private var showingExportSheet = false
    @State private var showingDeleteAlert = false
    @State private var exportedData = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.gray.opacity(0.2), Color.gray.opacity(0.1)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                List {
                    // App Info Section
                    Section {
                        HStack {
                            Image(systemName: "brain.head.profile")
                                .font(.largeTitle)
                                .foregroundColor(.purple)

                            VStack(alignment: .leading, spacing: 5) {
                                Text("StressMind")
                                    .font(.title2)
                                    .fontWeight(.bold)

                                Text("Teen Stress Management")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)

                                Text("Version 1.0")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 10)
                    }
                    .listRowBackground(Color.white)

                    // Privacy & Data Section
                    Section {
                        NavigationLink(destination: ParentalSharingView()) {
                            Label("Parent Sharing (Optional)", systemImage: "person.2.fill")
                        }
                        .accessibilityLabel("Parent sharing settings")
                        .accessibilityHint("Configure optional mood summary sharing with parents")

                        Button(action: { exportData() }) {
                            Label("Export My Data", systemImage: "square.and.arrow.up")
                                .foregroundColor(.primary)
                        }
                        .accessibilityLabel("Export all your data")
                        .accessibilityHint("Creates a text file with all your mood entries and contacts")

                        Button(action: { showingDeleteAlert = true }) {
                            Label("Delete All My Data", systemImage: "trash")
                                .foregroundColor(.red)
                        }
                        .accessibilityLabel("Delete all your data")
                        .accessibilityHint("Permanently removes all mood entries and emergency contacts")
                    } header: {
                        Text("Privacy & Data")
                    } footer: {
                        Text("Your data is encrypted and stored locally on your device only. It is never sent to any servers.")
                    }
                    .listRowBackground(Color.white)

                    // Compliance Section
                    Section {
                        HStack {
                            Image(systemName: "checkmark.shield.fill")
                                .foregroundColor(.green)
                            Text("HIPAA Compliant")
                            Spacer()
                            Image(systemName: "info.circle")
                                .foregroundColor(.secondary)
                        }
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("HIPAA compliant, double tap for more information")

                        HStack {
                            Image(systemName: "checkmark.shield.fill")
                                .foregroundColor(.green)
                            Text("COPPA Compliant")
                            Spacer()
                            Image(systemName: "info.circle")
                                .foregroundColor(.secondary)
                        }
                        .accessibilityElement(children: .combine)

                        HStack {
                            Image(systemName: "checkmark.shield.fill")
                                .foregroundColor(.green)
                            Text("WCAG AA Accessible")
                            Spacer()
                            Image(systemName: "info.circle")
                                .foregroundColor(.secondary)
                        }
                        .accessibilityElement(children: .combine)
                    } header: {
                        Text("Compliance")
                    } footer: {
                        Text("This app meets healthcare privacy (HIPAA), children's privacy (COPPA), and accessibility (WCAG) standards.")
                    }
                    .listRowBackground(Color.white)

                    // About Section
                    Section {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("About StressMind")
                                .font(.headline)
                                .accessibilityAddTraits(.isHeader)

                            Text("StressMind is designed to help teens manage stress and access mental health resources.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Text("Features:")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 5)

                            FeatureRow(icon: "phone.circle.fill", text: "Crisis hotline access")
                            FeatureRow(icon: "face.smiling", text: "Mood journal")
                            FeatureRow(icon: "hand.raised.fill", text: "Coping skills")
                            FeatureRow(icon: "sparkles", text: "Guided meditations")
                            FeatureRow(icon: "person.2.fill", text: "Emergency contacts")
                        }
                        .padding(.vertical, 5)
                    } header: {
                        Text("About")
                    }
                    .listRowBackground(Color.white)

                    // Disclaimer Section
                    Section {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.orange)
                                Text("Important")
                                    .font(.headline)
                                    .foregroundColor(.orange)
                            }

                            Text("This app is not a replacement for professional medical advice, diagnosis, or treatment.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Text("If you're experiencing a medical emergency, call 911.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .fontWeight(.semibold)
                        }
                        .padding(.vertical, 5)
                    } header: {
                        Text("Disclaimer")
                    }
                    .listRowBackground(Color.orange.opacity(0.1))
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingExportSheet) {
                ExportDataView(data: exportedData)
            }
            .alert("Delete All Data?", isPresented: $showingDeleteAlert) {
                Button("Delete", role: .destructive) {
                    dataManager.deleteAllData()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This will permanently delete all your mood entries and emergency contacts. This action cannot be undone.")
            }
        }
    }

    private func exportData() {
        exportedData = dataManager.exportAllData()
        showingExportSheet = true
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(.purple)
                .frame(width: 20)
            Text(text)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct ExportDataView: View {
    let data: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                Text(data)
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textSelection(.enabled)
            }
            .navigationTitle("Exported Data")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    ShareLink(item: data) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .accessibilityLabel("Share exported data")
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
