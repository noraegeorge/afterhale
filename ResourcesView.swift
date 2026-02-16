import SwiftUI

struct ResourcesView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.green.opacity(0.2), Color.blue.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        Text("Resources & Tips")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .padding(.top)

                        // Crisis Resources
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Crisis Support")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.red)

                            ResourceCard(
                                title: "988 Suicide & Crisis Lifeline",
                                description: "24/7 free and confidential support for people in distress",
                                contact: "Call or text 988",
                                icon: "phone.fill",
                                color: .red
                            )

                            ResourceCard(
                                title: "Crisis Text Line",
                                description: "Text with a crisis counselor",
                                contact: "Text HOME to 741741",
                                icon: "message.fill",
                                color: .blue
                            )

                            ResourceCard(
                                title: "Teen Line",
                                description: "Teens helping teens (6pm-10pm PT)",
                                contact: "Call (310) 855-4673 or Text TEEN to 839863",
                                icon: "person.2.fill",
                                color: .green
                            )
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)

                        // Mental Health Tips
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Coping Strategies")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)

                            TipCard(
                                icon: "wind",
                                title: "Practice Deep Breathing",
                                description: "Use our breathing exercise to calm your mind",
                                color: .blue
                            )

                            TipCard(
                                icon: "figure.walk",
                                title: "Get Moving",
                                description: "Physical activity can boost your mood",
                                color: .green
                            )

                            TipCard(
                                icon: "bubble.left.and.bubble.right.fill",
                                title: "Talk to Someone",
                                description: "Reach out to a friend, family member, or counselor",
                                color: .orange
                            )

                            TipCard(
                                icon: "moon.zzz.fill",
                                title: "Get Enough Sleep",
                                description: "Aim for 8-10 hours per night",
                                color: .purple
                            )

                            TipCard(
                                icon: "pencil",
                                title: "Journal Your Feelings",
                                description: "Writing can help process emotions",
                                color: .pink
                            )
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)

                        // Warning Signs
                        VStack(alignment: .leading, spacing: 15) {
                            Text("When to Seek Help")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.orange)

                            VStack(alignment: .leading, spacing: 10) {
                                WarningSignRow(text: "Feeling hopeless or trapped")
                                WarningSignRow(text: "Intense mood swings")
                                WarningSignRow(text: "Withdrawing from friends and activities")
                                WarningSignRow(text: "Changes in eating or sleeping habits")
                                WarningSignRow(text: "Increased substance use")
                                WarningSignRow(text: "Thoughts of self-harm")
                            }

                            Text("If you're experiencing these signs, please reach out for help. You deserve support.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding(.top, 5)
                        }
                        .padding()
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(15)

                        // Additional Resources
                        VStack(alignment: .leading, spacing: 15) {
                            Text("More Resources")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)

                            ExternalLinkCard(
                                title: "MentalHealth.gov",
                                description: "Information about mental health",
                                icon: "brain.head.profile"
                            )

                            ExternalLinkCard(
                                title: "National Alliance on Mental Illness (NAMI)",
                                description: "Support and education",
                                icon: "heart.text.square.fill"
                            )

                            ExternalLinkCard(
                                title: "Teen Mental Health",
                                description: "Resources specifically for teens",
                                icon: "person.fill"
                            )
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)

                        Spacer(minLength: 30)
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct ResourceCard: View {
    let title: String
    let description: String
    let contact: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(color)
                .cornerRadius(12)

            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text(contact)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(color)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

struct TipCard: View {
    let icon: String
    let title: String
    let description: String
    let color: Color

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
                .frame(width: 40, height: 40)
                .background(color.opacity(0.2))
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(10)
    }
}

struct WarningSignRow: View {
    let text: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.orange)
                .font(.subheadline)

            Text(text)
                .font(.subheadline)
                .foregroundColor(.primary)

            Spacer()
        }
    }
}

struct ExternalLinkCard: View {
    let title: String
    let description: String
    let icon: String

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.blue)
                .frame(width: 40, height: 40)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Image(systemName: "arrow.up.right.square")
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(10)
    }
}

#Preview {
    ResourcesView()
}
