import SwiftUI

struct AchievementsView: View {
    @ObservedObject var store: AchievementStore

    var body: some View {
        List {
            ForEach(store.allAchievements) { achievement in
                HStack {
                    VStack(alignment: .leading) {
                        Text(achievement.title)
                            .font(.headline)
                        Text(achievement.detail)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Image(systemName: store.isUnlocked(achievement) ? "checkmark.seal.fill" : "lock.fill")
                        .foregroundStyle(store.isUnlocked(achievement) ? .green : .gray)
                }
            }
        }
        .navigationTitle("Achievements")
    }
}
