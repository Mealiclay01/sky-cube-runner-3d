import SceneKit
import SwiftUI
import UIKit

struct GameView: View {
    @EnvironmentObject private var settings: SettingsStore
    @ObservedObject var engine: GameEngine
    let dailyChallenge: DailyChallenge?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            GameSceneView(engine: engine)
                .ignoresSafeArea()
                .gesture(
                    DragGesture(minimumDistance: 24)
                        .onEnded { value in
                            if value.translation.width < -30 {
                                engine.shiftPlayerLane(direction: -1)
                            } else if value.translation.width > 30 {
                                engine.shiftPlayerLane(direction: 1)
                            }
                        }
                )

            HUDView(state: engine.state, highContrast: settings.highContrast)
                .padding(.top, 12)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

            if settings.showDebug {
                DebugOverlayView(info: engine.state.debugInfo)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            }

            if settings.showTutorial && engine.state.showTutorial {
                TutorialOverlayView {
                    engine.state.showTutorial = false
                    settings.showTutorial = false
                }
            }

            if engine.state.isGameOver {
                GameOverView(engine: engine) {
                    dismiss()
                }
            }
        }
        .onAppear {
            engine.startRun(dailyChallenge: dailyChallenge)
        }
        .onDisappear {
            engine.stopRun()
        }
    }
}

struct GameSceneView: UIViewRepresentable {
    @ObservedObject var engine: GameEngine

    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.scene = engine.scene
        view.delegate = engine
        view.isPlaying = true
        view.preferredFramesPerSecond = 60
        view.backgroundColor = UIColor.black
        view.rendersContinuously = true
        engine.attachSceneView(view)
        return view
    }

    func updateUIView(_ uiView: SCNView, context: Context) {
        uiView.scene = engine.scene
    }
}
