import UIKit

final class HapticsManager {
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle, enabled: Bool) {
        guard enabled else { return }
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}
