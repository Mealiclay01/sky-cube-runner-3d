import Foundation

struct DailyChallenge: Identifiable {
    let date: Date
    let seed: UInt64

    var id: String { dateString }

    var dateString: String {
        Self.dateFormatter.string(from: date)
    }

    var leaderboard: [Int] {
        Self.loadLeaderboard(for: dateString)
    }

    static func today() -> DailyChallenge {
        let date = Date()
        let seed = makeSeed(from: date)
        return DailyChallenge(date: date, seed: seed)
    }

    static func record(score: Int, for dateString: String) -> [Int] {
        var leaderboard = loadLeaderboard(for: dateString)
        leaderboard.append(score)
        leaderboard = leaderboard.sorted(by: >).prefix(5).map { $0 }
        UserDefaults.standard.set(leaderboard, forKey: leaderboardKey(for: dateString))
        return leaderboard
    }

    private static func loadLeaderboard(for dateString: String) -> [Int] {
        UserDefaults.standard.array(forKey: leaderboardKey(for: dateString)) as? [Int] ?? []
    }

    private static func leaderboardKey(for dateString: String) -> String {
        "dailyLeaderboard.\(dateString)"
    }

    private static func makeSeed(from date: Date) -> UInt64 {
        let value = dateFormatter.string(from: date)
        return value.unicodeScalars.reduce(UInt64(0)) { ($0 << 5) &+ UInt64($1.value) }
    }

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

struct SeededGenerator: RandomNumberGenerator {
    private var state: UInt64

    init(seed: UInt64) {
        state = seed == 0 ? 0xBAD5EED : seed
    }

    mutating func next() -> UInt64 {
        state &+= 0x9E3779B97F4A7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58476D1CE4E5B9
        z = (z ^ (z >> 27)) &* 0x94D049BB133111EB
        return z ^ (z >> 31)
    }
}
