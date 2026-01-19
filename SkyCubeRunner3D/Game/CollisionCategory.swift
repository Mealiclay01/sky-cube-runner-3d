import Foundation

enum CollisionCategory {
    static let player = 1 << 0
    static let obstacle = 1 << 1
    static let ground = 1 << 2
    static let ghost = 1 << 3
}
