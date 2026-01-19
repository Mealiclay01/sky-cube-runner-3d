import Foundation

struct Achievement: Identifiable, Hashable {
    let id: String
    let title: String
    let detail: String
    let scoreThreshold: Int
}

@MainActor
final class AchievementStore: ObservableObject {
    @Published private(set) var unlocked: Set<String>

    let allAchievements: [Achievement] = [
        Achievement(id: "rookie", title: "Rookie Runner", detail: "Reach 500 points.", scoreThreshold: 500),
        Achievement(id: "skyline", title: "Skyline Streak", detail: "Reach 1500 points.", scoreThreshold: 1500),
        Achievement(id: "stratos", title: "Stratos Master", detail: "Reach 3000 points.", scoreThreshold: 3000)
    ]

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        let stored = defaults.array(forKey: Keys.unlocked) as? [String] ?? []
        unlocked = Set(stored)
    }

    func evaluate(score: Int) -> [Achievement] {
        var newlyUnlocked: [Achievement] = []
        for achievement in allAchievements where score >= achievement.scoreThreshold {
            if !unlocked.contains(achievement.id) {
                unlocked.insert(achievement.id)
                newlyUnlocked.append(achievement)
            }
        }
        if !newlyUnlocked.isEmpty {
            defaults.set(Array(unlocked), forKey: Keys.unlocked)
        }
        return newlyUnlocked
    }

    func isUnlocked(_ achievement: Achievement) -> Bool {
        unlocked.contains(achievement.id)
    }

    private enum Keys {
        static let unlocked = "achievements.unlocked"
    }
}
