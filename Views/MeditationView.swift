import SwiftUI

struct MeditationView: View {
    let meditations: [Meditation] = [
        Meditation(title: "4-7-8 Breathing", duration: "5 min", description: "A powerful breathing technique to reduce anxiety", icon: "wind", category: .breathing),
        Meditation(title: "Box Breathing", duration: "5 min", description: "Equal breathing for balance and calm", icon: "square", category: .breathing),
        Meditation(title: "Body Scan", duration: "10 min", description: "Progressive relaxation through your body", icon: "figure.stand", category: .relaxation),
        Meditation(title: "Guided Relaxation", duration: "15 min", description: "Release tension and find peace", icon: "sparkles", category: .relaxation),
        Meditation(title: "Mindful Observation", duration: "7 min", description: "Practice being present in the moment", icon: "eye", category: .mindfulness),
        Meditation(title: "Loving Kindness", duration: "10 min", description: "Cultivate compassion for yourself and others", icon: "heart.fill", category: .mindfulness),
        Meditation(title: "Sleep Preparation", duration: "20 min", description: "Wind down for restful sleep", icon: "moon.stars.fill", category: .sleep),
        Meditation(title: "Bedtime Story", duration: "15 min", description: "Calming narrative to ease into sleep", icon: "book.fill", category: .sleep)
    ]

    @State private var selectedCategory: Meditation.Category? = nil

    var filteredMeditations: [Meditation] {
        if let category = selectedCategory {
            return meditations.filter { $0.category == category }
        }
        return meditations
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.indigo.opacity(0.3), Color.purple.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        // Header
                        Text("Guided Meditations")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .accessibilityAddTraits(.isHeader)

                        Text("Find calm and clarity")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        // Category Filter
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                CategoryButton(title: "All", isSelected: selectedCategory == nil) {
                                    selectedCategory = nil
                                }

                                CategoryButton(title: "Breathing", isSelected: selectedCategory == .breathing) {
                                    selectedCategory = .breathing
                                }

                                CategoryButton(title: "Relaxation", isSelected: selectedCategory == .relaxation) {
                                    selectedCategory = .relaxation
                                }

                                CategoryButton(title: "Mindfulness", isSelected: selectedCategory == .mindfulness) {
                                    selectedCategory = .mindfulness
                                }

                                CategoryButton(title: "Sleep", isSelected: selectedCategory == .sleep) {
                                    selectedCategory = .sleep
                                }
                            }
                        }
                        .accessibilityElement(children: .contain)
                        .accessibilityLabel("Category filters")

                        // Meditations List
                        VStack(spacing: 15) {
                            ForEach(filteredMeditations) { meditation in
                                NavigationLink(destination: MeditationDetailView(meditation: meditation)) {
                                    MeditationCard(meditation: meditation)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(isSelected ? Color.purple : Color.white)
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
        }
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

struct MeditationCard: View {
    let meditation: Meditation

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: meditation.icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.purple, Color.indigo]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(15)

            VStack(alignment: .leading, spacing: 5) {
                Text(meditation.title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(meditation.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)

                HStack {
                    Image(systemName: "clock")
                        .font(.caption)
                    Text(meditation.duration)
                        .font(.caption)

                    Spacer()

                    Text(meditation.category.rawValue)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.purple.opacity(0.2))
                        .cornerRadius(8)
                }
                .foregroundColor(.secondary)
            }

            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 10)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(meditation.title), \(meditation.duration), \(meditation.description)")
        .accessibilityHint("Double tap to start meditation")
    }
}

struct MeditationDetailView: View {
    let meditation: Meditation
    @State private var isPlaying = false
    @State private var progress: Double = 0
    @State private var timer: Timer?
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.indigo.opacity(0.4), Color.purple.opacity(0.3)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 40) {
                Spacer()

                // Icon
                Image(systemName: meditation.icon)
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                    .frame(width: 150, height: 150)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.purple, Color.indigo]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(30)
                    .shadow(color: Color.purple.opacity(0.5), radius: 20)

                // Title and Description
                VStack(spacing: 10) {
                    Text(meditation.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .accessibilityAddTraits(.isHeader)

                    Text(meditation.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                // Progress Bar
                VStack(spacing: 10) {
                    ProgressView(value: progress, total: 1.0)
                        .tint(.purple)
                        .scaleEffect(y: 2)
                        .accessibilityLabel("Progress: \(Int(progress * 100))%")

                    Text(meditation.duration)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 40)

                // Play/Pause Button
                Button(action: togglePlayPause) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.2), radius: 10)
                }
                .accessibilityLabel(isPlaying ? "Pause" : "Play")

                // Instructions
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Instructions")
                            .font(.headline)
                            .accessibilityAddTraits(.isHeader)

                        Text(getInstructions())
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(15)
                }
                .frame(maxHeight: 200)
                .padding(.horizontal)

                Spacer()
            }
        }
        .navigationTitle(meditation.title)
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            timer?.invalidate()
        }
    }

    private func togglePlayPause() {
        if isPlaying {
            timer?.invalidate()
            timer = nil
        } else {
            startMeditation()
        }
        isPlaying.toggle()
    }

    private func startMeditation() {
        let durationInSeconds: Double = parseDuration(meditation.duration)
        let interval = 0.1
        let totalSteps = durationInSeconds / interval

        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            if progress < 1.0 {
                progress += 1.0 / totalSteps
            } else {
                timer?.invalidate()
                timer = nil
                isPlaying = false
                progress = 0
            }
        }
    }

    private func parseDuration(_ duration: String) -> Double {
        let numbers = duration.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return Double(numbers) ?? 5.0
    }

    private func getInstructions() -> String {
        switch meditation.category {
        case .breathing:
            return "Find a comfortable position. Follow the guided breathing pattern. Breathe in slowly through your nose, hold, then exhale through your mouth. Focus on the rhythm of your breath."
        case .relaxation:
            return "Sit or lie down comfortably. Close your eyes and follow the guided relaxation. Release tension from each part of your body as instructed."
        case .mindfulness:
            return "Sit comfortably with your eyes closed. Focus on the present moment. Notice your thoughts without judgment and gently bring your attention back to your breath."
        case .sleep:
            return "Lie down in bed. Get comfortable and close your eyes. Follow the guided meditation to release the day's tension and prepare for restful sleep."
        }
    }
}

#Preview {
    MeditationView()
}
