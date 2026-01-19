import Foundation

struct DifficultyManager {
    let baseSpeed: Float = 6
    let maxSpeed: Float = 18
    let baseSpawnInterval: TimeInterval = 1.3

    func speed(forElapsed elapsed: TimeInterval) -> Float {
        let progress = min(max(elapsed / 45, 0), 1)
        return baseSpeed + (maxSpeed - baseSpeed) * Float(progress)
    }

    func spawnInterval(forElapsed elapsed: TimeInterval) -> TimeInterval {
        let progress = min(max(elapsed / 60, 0), 1)
        return max(0.55, baseSpawnInterval - (baseSpawnInterval * 0.5 * progress))
    }
}
