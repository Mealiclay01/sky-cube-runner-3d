import SceneKit
import UIKit

enum GameSceneFactory {
    static func makeScene() -> SCNScene {
        let scene = SCNScene()
        scene.background.contents = UIImage(named: "SkyTexture") ?? UIColor.black
        return scene
    }

    static func makeFloor() -> SCNNode {
        let floor = SCNFloor()
        floor.firstMaterial?.diffuse.contents = UIImage(named: "GroundTexture")
        floor.firstMaterial?.lightingModel = .physicallyBased
        let node = SCNNode(geometry: floor)
        node.physicsBody = SCNPhysicsBody.static()
        node.physicsBody?.categoryBitMask = CollisionCategory.ground
        node.position = SCNVector3(0, -0.5, 0)
        return node
    }

    static func makePlayer() -> SCNNode {
        let box = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.1)
        box.firstMaterial?.diffuse.contents = UIColor.systemTeal
        let node = SCNNode(geometry: box)
        node.position = SCNVector3(0, 0.5, 6)
        let body = SCNPhysicsBody.kinematic()
        body.categoryBitMask = CollisionCategory.player
        body.contactTestBitMask = CollisionCategory.obstacle
        body.collisionBitMask = CollisionCategory.obstacle
        node.physicsBody = body
        return node
    }

    static func makeObstacle() -> SCNNode {
        let box = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.05)
        box.firstMaterial?.diffuse.contents = UIImage(named: "ObstacleTexture")
        box.firstMaterial?.emission.contents = UIColor.systemPink
        let node = SCNNode(geometry: box)
        let body = SCNPhysicsBody.kinematic()
        body.categoryBitMask = CollisionCategory.obstacle
        body.contactTestBitMask = CollisionCategory.player
        body.collisionBitMask = CollisionCategory.player
        node.physicsBody = body
        return node
    }

    static func makeCamera() -> SCNNode {
        let camera = SCNCamera()
        camera.fieldOfView = 70
        let node = SCNNode()
        node.camera = camera
        node.position = SCNVector3(0, 6, 12)
        node.eulerAngles = SCNVector3(-0.3, 0, 0)
        return node
    }

    static func makeLight() -> SCNNode {
        let light = SCNLight()
        light.type = .directional
        light.intensity = 1200
        let node = SCNNode()
        node.light = light
        node.position = SCNVector3(0, 10, 10)
        node.eulerAngles = SCNVector3(-0.6, 0, 0)
        return node
    }
}
