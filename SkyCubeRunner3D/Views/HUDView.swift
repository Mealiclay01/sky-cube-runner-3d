import SwiftUI

struct HUDView: View {
    @ObservedObject var state: GameState
    let highContrast: Bool

    var body: some View {
        HStack {
            GlassmorphismContainer {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Score: \(state.score)")
                    Text("Distance: \(Int(state.distance))m")
                    Text("Speed: \(String(format: "%.1f", state.speed))")
                }
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(highContrast ? .yellow : .white)
            }

            Spacer()

            GlassmorphismContainer {
                VStack(alignment: .trailing, spacing: 6) {
                    Text("Best: \(state.bestScore)")
                    if let challenge = state.activeDailyChallenge {
                        Text("Daily Seed: \(challenge.seed)")
                            .font(.caption)
                    }
                }
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(highContrast ? .yellow : .white)
            }
        }
        .padding(.horizontal)
    }
}
