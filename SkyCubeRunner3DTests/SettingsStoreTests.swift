import XCTest
@testable import SkyCubeRunner3D

@MainActor
final class SettingsStoreTests: XCTestCase {
    func testSettingsPersistAcrossSessions() {
        let suiteName = "SettingsStoreTests"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)

        let store = SettingsStore(defaults: defaults)
        store.audioEnabled = false
        store.musicEnabled = false
        store.hapticsEnabled = false
        store.highContrast = true
        store.showDebug = true
        store.showTutorial = false

        let reloaded = SettingsStore(defaults: defaults)
        XCTAssertFalse(reloaded.audioEnabled)
        XCTAssertFalse(reloaded.musicEnabled)
        XCTAssertFalse(reloaded.hapticsEnabled)
        XCTAssertTrue(reloaded.highContrast)
        XCTAssertTrue(reloaded.showDebug)
        XCTAssertFalse(reloaded.showTutorial)
    }
}
