import Foundation

@MainActor
final class SettingsStore: ObservableObject {
    @Published var audioEnabled: Bool { didSet { persist() } }
    @Published var musicEnabled: Bool { didSet { persist() } }
    @Published var hapticsEnabled: Bool { didSet { persist() } }
    @Published var highContrast: Bool { didSet { persist() } }
    @Published var showDebug: Bool { didSet { persist() } }
    @Published var showTutorial: Bool { didSet { persist() } }

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        audioEnabled = defaults.object(forKey: Keys.audioEnabled) as? Bool ?? true
        musicEnabled = defaults.object(forKey: Keys.musicEnabled) as? Bool ?? true
        hapticsEnabled = defaults.object(forKey: Keys.hapticsEnabled) as? Bool ?? true
        highContrast = defaults.object(forKey: Keys.highContrast) as? Bool ?? false
        showDebug = defaults.object(forKey: Keys.showDebug) as? Bool ?? false
        showTutorial = defaults.object(forKey: Keys.showTutorial) as? Bool ?? true
    }

    private func persist() {
        defaults.set(audioEnabled, forKey: Keys.audioEnabled)
        defaults.set(musicEnabled, forKey: Keys.musicEnabled)
        defaults.set(hapticsEnabled, forKey: Keys.hapticsEnabled)
        defaults.set(highContrast, forKey: Keys.highContrast)
        defaults.set(showDebug, forKey: Keys.showDebug)
        defaults.set(showTutorial, forKey: Keys.showTutorial)
    }

    private enum Keys {
        static let audioEnabled = "settings.audioEnabled"
        static let musicEnabled = "settings.musicEnabled"
        static let hapticsEnabled = "settings.hapticsEnabled"
        static let highContrast = "settings.highContrast"
        static let showDebug = "settings.showDebug"
        static let showTutorial = "settings.showTutorial"
    }
}
