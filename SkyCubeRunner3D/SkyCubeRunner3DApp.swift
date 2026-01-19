import SwiftUI

@main
struct SkyCubeRunner3DApp: App {
    @StateObject private var settings: SettingsStore
    @StateObject private var engine: GameEngine

    init() {
        let store = SettingsStore()
        _settings = StateObject(wrappedValue: store)
        _engine = StateObject(wrappedValue: GameEngine(settings: store))
    }

    var body: some Scene {
        WindowGroup {
            ContentView(engine: engine)
                .environmentObject(settings)
                .preferredColorScheme(.dark)
        }
    }
}
