import Foundation

struct RunSummary {
    let finalScore: Int
    let distance: Double
    let elapsedTime: TimeInterval
    let isNewBest: Bool
    let unlockedAchievements: [Achievement]
    let dailyRank: Int?
}
