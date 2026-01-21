import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject private var settings: SettingsStore
    @ObservedObject var engine: GameEngine
    @State private var dailyChallenge = DailyChallenge.today()

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.black, Color.blue.opacity(0.6)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Text("Sky Cube Runner 3D")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                GlassmorphismContainer {
                    VStack(spacing: 16) {
                        NavigationLink("Start Run") {
                            GameView(engine: engine, dailyChallenge: nil)
                        }
                        .buttonStyle(.borderedProminent)

                        NavigationLink("Daily Challenge") {
                            DailyChallengeView(engine: engine, challenge: dailyChallenge)
                        }
                        .buttonStyle(.bordered)

                        NavigationLink("Achievements") {
                            AchievementsView(store: engine.achievementStore)
                        }
                        .buttonStyle(.bordered)

                        NavigationLink("Settings") {
                            SettingsView()
                        }
                        .buttonStyle(.bordered)

                        NavigationLink("How To Play") {
                            HowToPlayView()
                        }
                        .buttonStyle(.bordered)

                        NavigationLink("Credits") {
                            CreditsView()
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .frame(maxWidth: 320)

                Text("Best Score: \(engine.state.bestScore)")
                    .font(.headline)
                    .foregroundStyle(settings.highContrast ? .yellow : .cyan)
            }
            .padding()
        }
        .onAppear {
            dailyChallenge = DailyChallenge.today()
        }
    }
}
