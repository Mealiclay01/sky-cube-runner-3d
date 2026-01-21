import Foundation

struct ScoreManager {
    func score(forDistance distance: Double, elapsed: TimeInterval, bonus: Int) -> Int {
        let distanceScore = Int(distance.rounded(.down))
        let tempoBonus = Int(elapsed) * 2
        return max(distanceScore + tempoBonus + bonus, 0)
    }
}
