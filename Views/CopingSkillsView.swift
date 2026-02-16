import SwiftUI

struct CopingSkillsView: View {
    let copingSkills: [CopingSkill] = [
        CopingSkill(
            title: "5-4-3-2-1 Grounding",
            description: "Use your senses to stay present",
            instructions: [
                "Name 5 things you can see",
                "Name 4 things you can touch",
                "Name 3 things you can hear",
                "Name 2 things you can smell",
                "Name 1 thing you can taste"
            ],
            icon: "hand.raised.fill",
            color: .blue,
            category: .grounding
        ),
        CopingSkill(
            title: "STOP Technique",
            description: "Pause and regain control",
            instructions: [
                "S - Stop what you're doing",
                "T - Take a few deep breaths",
                "O - Observe your thoughts and feelings",
                "P - Proceed with awareness"
            ],
            icon: "hand.raised.circle.fill",
            color: .red,
            category: .grounding
        ),
        CopingSkill(
            title: "Progressive Muscle Relaxation",
            description: "Release physical tension",
            instructions: [
                "Start with your toes, tense them for 5 seconds",
                "Release and notice the relaxation",
                "Move up through each muscle group",
                "End with your face and head",
                "Notice the overall relaxation"
            ],
            icon: "figure.mind.and.body",
            color: .purple,
            category: .relaxation
        ),
        CopingSkill(
            title: "Ice Cube Technique",
            description: "Physical sensation to ground yourself",
            instructions: [
                "Hold an ice cube in your hand",
                "Focus on the cold sensation",
                "Notice how it changes over time",
                "Pay attention only to the physical feeling",
                "Continue until the ice melts"
            ],
            icon: "snowflake",
            color: .cyan,
            category: .grounding
        ),
        CopingSkill(
            title: "Thought Challenging",
            description: "Question negative thoughts",
            instructions: [
                "Identify the negative thought",
                "Ask: Is this thought true?",
                "Ask: What evidence supports/contradicts it?",
                "Consider alternative perspectives",
                "Replace with a balanced thought"
            ],
            icon: "brain.head.profile",
            color: .orange,
            category: .cognitive
        ),
        CopingSkill(
            title: "Distraction Playlist",
            description: "Shift focus with activities",
            instructions: [
                "Listen to your favorite music",
                "Call or text a friend",
                "Play a game on your phone",
                "Watch a funny video",
                "Read a book or article"
            ],
            icon: "music.note.list",
            color: .pink,
            category: .distraction
        ),
        CopingSkill(
            title: "Safe Place Visualization",
            description: "Imagine a calming environment",
            instructions: [
                "Close your eyes and breathe deeply",
                "Picture a place where you feel safe",
                "Notice details: colors, sounds, temperature",
                "Imagine yourself in that place",
                "Stay here as long as you need"
            ],
            icon: "cloud.sun.fill",
            color: .green,
            category: .relaxation
        ),
        CopingSkill(
            title: "Positive Affirmations",
            description: "Build self-compassion",
            instructions: [
                "I am doing my best",
                "This feeling will pass",
                "I am stronger than I think",
                "I deserve kindness and respect",
                "I can handle this challenge"
            ],
            icon: "heart.text.square.fill",
            color: .pink,
            category: .cognitive
        ),
        CopingSkill(
            title: "Butterfly Hug",
            description: "Self-soothing technique",
            instructions: [
                "Cross your arms over your chest",
                "Place hands on opposite shoulders",
                "Gently tap alternating shoulders",
                "Continue for 30 seconds to a minute",
                "Breathe slowly while tapping"
            ],
            icon: "figure.arms.open",
            color: .purple,
            category: .relaxation
        )
    ]

    @State private var selectedCategory: CopingSkill.Category? = nil
    @State private var searchText = ""

    var filteredSkills: [CopingSkill] {
        var skills = copingSkills

        if let category = selectedCategory {
            skills = skills.filter { $0.category == category }
        }

        if !searchText.isEmpty {
            skills = skills.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText)
            }
        }

        return skills
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange.opacity(0.2), Color.yellow.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        // Header
                        Text("Coping Skills")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .accessibilityAddTraits(.isHeader)

                        Text("Tools to help you feel better")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        // Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.secondary)
                            TextField("Search skills...", text: $searchText)
                                .accessibilityLabel("Search coping skills")
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)

                        // Category Filter
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                FilterButton(title: "All", isSelected: selectedCategory == nil) {
                                    selectedCategory = nil
                                }

                                FilterButton(title: "Grounding", isSelected: selectedCategory == .grounding) {
                                    selectedCategory = .grounding
                                }

                                FilterButton(title: "Distraction", isSelected: selectedCategory == .distraction) {
                                    selectedCategory = .distraction
                                }

                                FilterButton(title: "Relaxation", isSelected: selectedCategory == .relaxation) {
                                    selectedCategory = .relaxation
                                }

                                FilterButton(title: "Cognitive", isSelected: selectedCategory == .cognitive) {
                                    selectedCategory = .cognitive
                                }
                            }
                        }
                        .accessibilityElement(children: .contain)
                        .accessibilityLabel("Category filters")

                        // Skills Grid
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                            ForEach(filteredSkills) { skill in
                                NavigationLink(destination: CopingSkillDetailView(skill: skill)) {
                                    CopingSkillCard(skill: skill)
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

struct FilterButton: View {
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
                .background(isSelected ? Color.orange : Color.white)
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
        }
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

struct CopingSkillCard: View {
    let skill: CopingSkill

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: skill.icon)
                .font(.system(size: 40))
                .foregroundColor(.white)
                .frame(width: 70, height: 70)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [skill.color, skill.color.opacity(0.7)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(15)

            Text(skill.title)
                .font(.headline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)

            Text(skill.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 10)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(skill.title), \(skill.description)")
        .accessibilityHint("Double tap to view instructions")
    }
}

struct CopingSkillDetailView: View {
    let skill: CopingSkill
    @State private var completedSteps: Set<Int> = []

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [skill.color.opacity(0.3), skill.color.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 25) {
                    // Icon
                    Image(systemName: skill.icon)
                        .font(.system(size: 80))
                        .foregroundColor(.white)
                        .frame(width: 140, height: 140)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [skill.color, skill.color.opacity(0.7)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(30)
                        .shadow(color: skill.color.opacity(0.5), radius: 20)

                    // Title and Description
                    VStack(spacing: 10) {
                        Text(skill.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .accessibilityAddTraits(.isHeader)

                        Text(skill.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)

                        Text(skill.category.rawValue)
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(skill.color.opacity(0.2))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)

                    // Instructions
                    VStack(alignment: .leading, spacing: 15) {
                        Text("How to do it:")
                            .font(.title2)
                            .fontWeight(.bold)
                            .accessibilityAddTraits(.isHeader)

                        ForEach(Array(skill.instructions.enumerated()), id: \.offset) { index, instruction in
                            HStack(alignment: .top, spacing: 15) {
                                Button(action: {
                                    if completedSteps.contains(index) {
                                        completedSteps.remove(index)
                                    } else {
                                        completedSteps.insert(index)
                                    }
                                }) {
                                    Image(systemName: completedSteps.contains(index) ? "checkmark.circle.fill" : "circle")
                                        .font(.title3)
                                        .foregroundColor(completedSteps.contains(index) ? skill.color : .secondary)
                                }
                                .accessibilityLabel(completedSteps.contains(index) ? "Completed" : "Not completed")
                                .accessibilityHint("Double tap to toggle completion")

                                Text(instruction)
                                    .font(.body)
                                    .foregroundColor(.primary)
                                    .strikethrough(completedSteps.contains(index))
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(15)

                    // Reset Button
                    if !completedSteps.isEmpty {
                        Button(action: {
                            completedSteps.removeAll()
                        }) {
                            Text("Reset Steps")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(skill.color)
                                .cornerRadius(12)
                        }
                        .accessibilityLabel("Reset all steps")
                    }

                    // Tips
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "lightbulb.fill")
                                .foregroundColor(.yellow)
                            Text("Tip")
                                .font(.headline)
                        }

                        Text("Practice this technique regularly, even when you're not stressed, so it becomes easier to use when you need it.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color.yellow.opacity(0.1))
                    .cornerRadius(12)

                    Spacer(minLength: 30)
                }
                .padding()
            }
        }
        .navigationTitle(skill.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CopingSkillsView()
}
