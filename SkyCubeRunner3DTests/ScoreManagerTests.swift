import XCTest
@testable import SkyCubeRunner3D

final class ScoreManagerTests: XCTestCase {
    func testScoreCalculationAddsDistanceTimeAndBonus() {
        let manager = ScoreManager()
        let score = manager.score(forDistance: 120.4, elapsed: 10, bonus: 50)
        XCTAssertEqual(score, 190)
    }
}
