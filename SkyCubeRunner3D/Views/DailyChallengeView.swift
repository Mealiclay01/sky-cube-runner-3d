import SwiftUI

struct DailyChallengeView: View {
    @ObservedObject var engine: GameEngine
    let challenge: DailyChallenge

    var body: some View {
        VStack(spacing: 24) {
            GlassmorphismContainer {
                VStack(spacing: 8) {
                    Text("Daily Challenge")
                        .font(.title2.bold())
                    Text(challenge.dateString)
                    Text("Seed: \(challenge.seed)")
                        .font(.caption)
                }
                .foregroundStyle(.white)
            }

            GlassmorphismContainer {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Leaderboard")
                        .font(.headline)
                    ForEach(Array(challenge.leaderboard.enumerated()), id: \.offset) { index, score in
                        Text("#\(index + 1) — \(score)")
                            .font(.subheadline)
                    }
                    if challenge.leaderboard.isEmpty {
                        Text("No runs yet. Be the first!")
                            .font(.caption)
                    }
                }
                .foregroundStyle(.white)
            }

            NavigationLink("Play Daily Run") {
                GameView(engine: engine, dailyChallenge: challenge)
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
        .navigationTitle("Daily Challenge")
        .background(
            LinearGradient(colors: [Color.black, Color.blue.opacity(0.6)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
    }
}
