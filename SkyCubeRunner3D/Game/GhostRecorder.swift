import Foundation
import SceneKit
import UIKit

struct GhostFrame {
    let time: TimeInterval
    let position: SIMD3<Float>
}

final class GhostRecorder {
    private(set) var frames: [GhostFrame] = []

    func reset() {
        frames.removeAll()
    }

    func record(time: TimeInterval, position: SIMD3<Float>) {
        frames.append(GhostFrame(time: time, position: position))
    }

    func ghostNode() -> SCNNode {
        let sphere = SCNSphere(radius: 0.45)
        sphere.firstMaterial?.diffuse.contents = UIColor.systemPurple.withAlphaComponent(0.6)
        let node = SCNNode(geometry: sphere)
        node.physicsBody = SCNPhysicsBody.kinematic()
        node.physicsBody?.categoryBitMask = CollisionCategory.ghost
        node.opacity = 0.6
        return node
    }

    func position(at time: TimeInterval) -> SIMD3<Float>? {
        guard let last = frames.last, time <= last.time else { return nil }
        if let frame = frames.first(where: { $0.time >= time }) {
            return frame.position
        }
        return nil
    }
}
