import XCTest
@testable import SkyCubeRunner3D

final class DifficultyManagerTests: XCTestCase {
    func testDifficultyScaling() {
        let manager = DifficultyManager()
        let initialSpeed = manager.speed(forElapsed: 0)
        let laterSpeed = manager.speed(forElapsed: 60)
        XCTAssertLessThan(initialSpeed, laterSpeed)

        let initialInterval = manager.spawnInterval(forElapsed: 0)
        let laterInterval = manager.spawnInterval(forElapsed: 60)
        XCTAssertGreaterThan(initialInterval, laterInterval)
    }
}
