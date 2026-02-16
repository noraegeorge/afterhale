import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
                .accessibilityLabel("Home tab")

            MoodTrackerView()
                .tabItem {
                    Label("Mood", systemImage: "face.smiling")
                }
                .tag(1)
                .accessibilityLabel("Mood journal tab")

            CopingSkillsView()
                .tabItem {
                    Label("Skills", systemImage: "hand.raised.fill")
                }
                .tag(2)
                .accessibilityLabel("Coping skills tab")

            MeditationView()
                .tabItem {
                    Label("Meditate", systemImage: "sparkles")
                }
                .tag(3)
                .accessibilityLabel("Meditation tab")

            EmergencyContactsView()
                .tabItem {
                    Label("Contacts", systemImage: "person.2.fill")
                }
                .tag(4)
                .accessibilityLabel("Emergency contacts tab")
        }
        .accentColor(.purple)
    }
}

#Preview {
    ContentView()
}
