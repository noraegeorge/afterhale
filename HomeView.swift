import SwiftUI

struct HomeView: View {
    @State private var showingCallAlert = false
    @State private var showingEmergencyAlert = false
    @State private var showingSettings = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple.opacity(0.3), Color.blue.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 25) {
                        // Header with Settings Button
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("StressMind")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.purple)

                                Text("You're not alone. We're here to help.")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            Button(action: { showingSettings = true }) {
                                Image(systemName: "gearshape.fill")
                                    .font(.title2)
                                    .foregroundColor(.secondary)
                            }
                            .accessibilityLabel("Settings")
                        }
                        .padding(.top, 20)

                        // Panic Button
                        VStack(spacing: 15) {
                            Text("Need immediate help?")
                                .font(.headline)
                                .foregroundColor(.primary)

                            Button(action: {
                                showingCallAlert = true
                            }) {
                                VStack(spacing: 12) {
                                    Image(systemName: "phone.circle.fill")
                                        .font(.system(size: 60))
                                        .foregroundColor(.white)

                                    Text("Call Crisis Hotline")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)

                                    Text("988 - Available 24/7")
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.9))
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 30)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.red, Color.pink]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .cornerRadius(20)
                                .shadow(color: Color.red.opacity(0.4), radius: 10, x: 0, y: 5)
                            }
                            .alert("Call Crisis Hotline", isPresented: $showingCallAlert) {
                                Button("Call 988", role: .none) {
                                    if let url = URL(string: "tel://988") {
                                        UIApplication.shared.open(url)
                                    }
                                }
                                Button("Cancel", role: .cancel) {}
                            } message: {
                                Text("This will call the 988 Suicide & Crisis Lifeline. Free and confidential support is available 24/7.")
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)

                        // Quick Actions
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Quick Actions")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)

                            QuickActionButton(
                                title: "Crisis Text Line",
                                subtitle: "Text HOME to 741741",
                                icon: "message.fill",
                                color: .blue
                            ) {
                                if let url = URL(string: "sms://741741&body=HOME") {
                                    UIApplication.shared.open(url)
                                }
                            }

                            QuickActionButton(
                                title: "Teen Line",
                                subtitle: "Call (310) 855-4673 or Text TEEN to 839863",
                                icon: "person.2.fill",
                                color: .green
                            ) {
                                if let url = URL(string: "tel://3108554673") {
                                    UIApplication.shared.open(url)
                                }
                            }

                            QuickActionButton(
                                title: "Trevor Project (LGBTQ+)",
                                subtitle: "Call 1-866-488-7386",
                                icon: "heart.fill",
                                color: .orange
                            ) {
                                if let url = URL(string: "tel://18664887386") {
                                    UIApplication.shared.open(url)
                                }
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)

                        // Emergency Note
                        VStack(spacing: 10) {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.red)
                                Text("In case of emergency, call 911")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                            }

                            Button("Call 911") {
                                showingEmergencyAlert = true
                            }
                            .foregroundColor(.red)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        }
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(15)
                        .alert("Call 911", isPresented: $showingEmergencyAlert) {
                            Button("Call Now", role: .destructive) {
                                if let url = URL(string: "tel://911") {
                                    UIApplication.shared.open(url)
                                }
                            }
                            Button("Cancel", role: .cancel) {}
                        } message: {
                            Text("This will call emergency services (911). Only use in life-threatening emergencies.")
                        }

                        Spacer(minLength: 30)
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
        }
    }
}

struct QuickActionButton: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 15) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(color)
                    .cornerRadius(12)

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
        }
    }
}

#Preview {
    HomeView()
}
