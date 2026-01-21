import SwiftUI

struct RunSummaryView: View {
    let summary: RunSummary

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Score: \(summary.finalScore)")
            Text("Distance: \(Int(summary.distance))m")
            Text("Time: \(String(format: "%.1f", summary.elapsedTime))s")
            if summary.isNewBest {
                Text("New Best!")
                    .foregroundStyle(.yellow)
            }
            if !summary.unlockedAchievements.isEmpty {
                Text("Achievements Unlocked:")
                    .font(.subheadline.bold())
                ForEach(summary.unlockedAchievements, id: \.id) { achievement in
                    Text("• \(achievement.title)")
                        .font(.footnote)
                }
            }
            if let dailyRank = summary.dailyRank {
                Text("Daily Rank: #\(dailyRank)")
                    .font(.footnote)
            }
        }
        .font(.subheadline)
        .foregroundStyle(.white)
    }
}
