import Foundation
import SceneKit

final class Spawner {
    private let pool: ObjectPool
    private(set) var activeNodes: [SCNNode] = []
    private var lastSpawnTime: TimeInterval = 0
    private let lanes: [Float]
    private weak var parent: SCNNode?

    init(lanes: [Float], parent: SCNNode, pool: ObjectPool) {
        self.lanes = lanes
        self.parent = parent
        self.pool = pool
    }

    func reset() {
        activeNodes.forEach { pool.release($0) }
        activeNodes.removeAll()
        lastSpawnTime = 0
    }

    func update(currentTime: TimeInterval, spawnInterval: TimeInterval, rng: inout SeededGenerator) {
        if currentTime - lastSpawnTime >= spawnInterval {
            spawnObstacle(using: &rng)
            lastSpawnTime = currentTime
        }
    }

    func recycleIfNeeded(zLimit: Float) {
        activeNodes.removeAll { node in
            if node.position.z > zLimit {
                pool.release(node)
                return true
            }
            return false
        }
    }

    private func spawnObstacle(using rng: inout SeededGenerator) {
        guard let parent else { return }
        let node = pool.acquire()
        let lane = lanes.randomElement(using: &rng) ?? 0
        node.position = SCNVector3(lane, 0.5, -60)
        parent.addChildNode(node)
        activeNodes.append(node)
    }

    var poolCount: Int {
        pool.count
    }
}
