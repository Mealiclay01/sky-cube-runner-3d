import Foundation
import SceneKit

final class ObjectPool {
    private var available: [SCNNode] = []
    private let create: () -> SCNNode

    init(create: @escaping () -> SCNNode) {
        self.create = create
    }

    func acquire() -> SCNNode {
        if let node = available.popLast() {
            node.isHidden = false
            return node
        }
        return create()
    }

    func release(_ node: SCNNode) {
        node.removeFromParentNode()
        node.isHidden = true
        available.append(node)
    }

    var count: Int {
        available.count
    }
}
