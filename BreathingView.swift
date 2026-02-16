import SwiftUI

struct BreathingView: View {
    @State private var isBreathing = false
    @State private var scale: CGFloat = 1.0
    @State private var breathText = "Tap to start"
    @State private var cycleCount = 0

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 40) {
                    Text("Breathing Exercise")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)

                    Text("Take a moment to breathe")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Spacer()

                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 200, height: 200)
                            .scaleEffect(scale)
                            .animation(.easeInOut(duration: 4).repeatForever(autoreverses: true), value: scale)

                        Text(breathText)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .onTapGesture {
                        toggleBreathing()
                    }

                    Text("Cycles completed: \(cycleCount)")
                        .font(.headline)
                        .foregroundColor(.secondary)

                    Spacer()

                    VStack(alignment: .leading, spacing: 15) {
                        Text("How it works:")
                            .font(.headline)
                            .foregroundColor(.primary)

                        HStack(alignment: .top, spacing: 10) {
                            Text("1.")
                                .fontWeight(.semibold)
                            Text("Breathe in slowly as the circle grows (4 seconds)")
                        }
                        .font(.subheadline)

                        HStack(alignment: .top, spacing: 10) {
                            Text("2.")
                                .fontWeight(.semibold)
                            Text("Breathe out slowly as the circle shrinks (4 seconds)")
                        }
                        .font(.subheadline)

                        HStack(alignment: .top, spacing: 10) {
                            Text("3.")
                                .fontWeight(.semibold)
                            Text("Repeat for a few minutes to feel calmer")
                        }
                        .font(.subheadline)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)

                    if isBreathing {
                        Button("Stop") {
                            toggleBreathing()
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 15)
                        .background(Color.red)
                        .cornerRadius(25)
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }

    private func toggleBreathing() {
        if isBreathing {
            isBreathing = false
            scale = 1.0
            breathText = "Tap to start"
        } else {
            isBreathing = true
            startBreathingCycle()
        }
    }

    private func startBreathingCycle() {
        guard isBreathing else { return }

        breathText = "Breathe in..."
        scale = 1.5

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            guard self.isBreathing else { return }
            self.breathText = "Breathe out..."
            self.scale = 1.0

            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                guard self.isBreathing else { return }
                self.cycleCount += 1
                self.startBreathingCycle()
            }
        }
    }
}

#Preview {
    BreathingView()
}
