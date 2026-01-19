import SwiftUI

struct GameOverView: View {
    @ObservedObject var engine: GameEngine
    let exitAction: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.6).ignoresSafeArea()

            GlassmorphismContainer {
                VStack(spacing: 16) {
                    Text("Game Over")
                        .font(.title.bold())

                    if let summary = engine.state.runSummary {
                        RunSummaryView(summary: summary)
                    }

                    HStack(spacing: 16) {
                        Button("Retry") {
                            engine.restartRun()
                        }
                        .buttonStyle(.borderedProminent)

                        Button("Exit") {
                            exitAction()
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .frame(maxWidth: 320)
            }
        }
    }
}
