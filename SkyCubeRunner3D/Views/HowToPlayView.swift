import SwiftUI

struct HowToPlayView: View {
    var body: some View {
        ScrollView {
            GlassmorphismContainer {
                VStack(alignment: .leading, spacing: 12) {
                    Text("How To Play")
                        .font(.title2.bold())
                    Text("Swipe left or right to change lanes. Avoid neon barriers, collect boosts, and keep your momentum high to maximize score.")
                    Text("Daily challenges use a fixed seed so everyone faces the same track. Beat the ghost replay to climb the leaderboard.")
                    Text("Enable the debug overlay in Settings to view FPS and speed telemetry.")
                }
                .foregroundStyle(.white)
            }
            .padding()
        }
        .navigationTitle("How To Play")
        .background(
            LinearGradient(colors: [Color.black, Color.blue.opacity(0.6)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
    }
}
