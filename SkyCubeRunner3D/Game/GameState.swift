import Foundation

struct DebugInfo {
    var fps: Double = 0
    var nodeCount: Int = 0
    var speed: Float = 0
    var poolSize: Int = 0
}

@MainActor
final class GameState: ObservableObject {
    @Published var isRunning = false
    @Published var isGameOver = false
    @Published var score = 0
    @Published var bestScore = UserDefaults.standard.integer(forKey: "bestScore")
    @Published var distance: Double = 0
    @Published var speed: Float = 0
    @Published var runSummary: RunSummary?
    @Published var debugInfo = DebugInfo()
    @Published var showTutorial = true
    @Published var activeDailyChallenge: DailyChallenge?

    func updateBestScore(with score: Int) -> Bool {
        guard score > bestScore else { return false }
        bestScore = score
        UserDefaults.standard.set(score, forKey: "bestScore")
        return true
    }
}
