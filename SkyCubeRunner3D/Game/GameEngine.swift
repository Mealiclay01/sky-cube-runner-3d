import Combine
import Foundation
import SceneKit

@MainActor
final class GameEngine: NSObject, ObservableObject {
    @Published var state = GameState()
    let settings: SettingsStore
    let scene: SCNScene
    let achievementStore = AchievementStore()

    private let scoreManager = ScoreManager()
    private let difficultyManager = DifficultyManager()
    private let audioManager = AudioManager()
    private let hapticsManager = HapticsManager()

    private let playerNode: SCNNode
    private let cameraNode: SCNNode
    private let lanes: [Float] = [-2.2, 0, 2.2]
    private var laneIndex = 1
    private var lastUpdateTime: TimeInterval?
    private var runStartTime: TimeInterval?
    private var bonusPoints = 0
    private var isDailyRun = false
    private var currentChallenge: DailyChallenge?
    private var rng = SeededGenerator(seed: 0)

    private let spawner: Spawner
    private var ghostRecorder = GhostRecorder()
    private var lastGhostFrames: [GhostFrame] = []
    private var ghostNode: SCNNode?

    private weak var sceneView: SCNView?
    private var fpsFrameCount = 0
    private var fpsLastTime: TimeInterval = 0
    private var cancellables = Set<AnyCancellable>()

    init(settings: SettingsStore) {
        self.settings = settings
        let scene = GameSceneFactory.makeScene()
        let player = GameSceneFactory.makePlayer()
        let camera = GameSceneFactory.makeCamera()
        self.scene = scene
        self.playerNode = player
        self.cameraNode = camera

        let pool = ObjectPool(create: GameSceneFactory.makeObstacle)
        self.spawner = Spawner(lanes: lanes, parent: scene.rootNode, pool: pool)
        super.init()
        state.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)

        scene.rootNode.addChildNode(GameSceneFactory.makeFloor())
        scene.rootNode.addChildNode(player)
        scene.rootNode.addChildNode(camera)
        scene.rootNode.addChildNode(GameSceneFactory.makeLight())
        scene.physicsWorld.contactDelegate = self
    }

    func attachSceneView(_ view: SCNView) {
        sceneView = view
    }

    func startRun(dailyChallenge: DailyChallenge?) {
        state.isGameOver = false
        state.isRunning = true
        state.distance = 0
        state.score = 0
        state.speed = difficultyManager.baseSpeed
        state.runSummary = nil
        state.showTutorial = settings.showTutorial
        bonusPoints = 0
        laneIndex = 1
        playerNode.position.x = lanes[laneIndex]
        spawner.reset()
        ghostRecorder.reset()
        runStartTime = nil
        lastUpdateTime = nil
        isDailyRun = dailyChallenge != nil
        currentChallenge = dailyChallenge
        state.activeDailyChallenge = dailyChallenge
        audioManager.setMusic(enabled: settings.musicEnabled)
        let seed = dailyChallenge?.seed ?? UInt64.random(in: 0...UInt64.max)
        rng = SeededGenerator(seed: seed)

        if !lastGhostFrames.isEmpty {
            if ghostNode == nil {
                ghostNode = ghostRecorder.ghostNode()
            }
            if let ghostNode {
                scene.rootNode.addChildNode(ghostNode)
            }
        }
    }

    func restartRun() {
        startRun(dailyChallenge: currentChallenge)
    }

    func stopRun() {
        state.isRunning = false
        audioManager.setMusic(enabled: false)
        ghostNode?.removeFromParentNode()
    }

    func shiftPlayerLane(direction: Int) {
        laneIndex = min(max(laneIndex + direction, 0), lanes.count - 1)
        playerNode.position.x = lanes[laneIndex]
        audioManager.play(effect: "jump", enabled: settings.audioEnabled)
        hapticsManager.impact(style: .light, enabled: settings.hapticsEnabled)
    }

    private func updateGame(time: TimeInterval, delta: TimeInterval) {
        guard state.isRunning, !state.isGameOver else { return }
        if runStartTime == nil {
            runStartTime = time
        }
        let elapsed = time - (runStartTime ?? time)
        let speed = difficultyManager.speed(forElapsed: elapsed)
        state.speed = speed
        state.distance += Double(speed * Float(delta))
        spawner.update(currentTime: elapsed, spawnInterval: difficultyManager.spawnInterval(forElapsed: elapsed), rng: &rng)

        for node in spawner.activeNodes {
            node.position.z += speed * Float(delta)
        }
        spawner.recycleIfNeeded(zLimit: 12)

        state.score = scoreManager.score(forDistance: state.distance, elapsed: elapsed, bonus: bonusPoints)
        ghostRecorder.record(time: elapsed, position: SIMD3<Float>(playerNode.position.x, playerNode.position.y, playerNode.position.z))
        updateGhost(at: elapsed)
        updateDebug(time: time)
    }

    private func updateGhost(at elapsed: TimeInterval) {
        guard let ghostNode, let frame = lastGhostFrames.first(where: { $0.time >= elapsed }) else { return }
        ghostNode.position = SCNVector3(frame.position.x, frame.position.y, frame.position.z)
    }

    private func updateDebug(time: TimeInterval) {
        fpsFrameCount += 1
        if fpsLastTime == 0 {
            fpsLastTime = time
        }
        let delta = time - fpsLastTime
        if delta >= 1 {
            let fps = Double(fpsFrameCount) / delta
            fpsFrameCount = 0
            fpsLastTime = time
            state.debugInfo = DebugInfo(
                fps: fps,
                nodeCount: scene.rootNode.childNodes(recursive: true).count,
                speed: state.speed,
                poolSize: spawner.poolCount
            )
        }
    }

    private func endRun() {
        state.isRunning = false
        state.isGameOver = true
        ghostNode?.removeFromParentNode()
        lastGhostFrames = ghostRecorder.frames

        let elapsed = (lastUpdateTime ?? 0) - (runStartTime ?? 0)
        let isNewBest = state.updateBestScore(with: state.score)
        let unlocked = achievementStore.evaluate(score: state.score)

        var dailyRank: Int?
        if isDailyRun, let challenge = currentChallenge {
            let leaderboard = DailyChallenge.record(score: state.score, for: challenge.dateString)
            if let index = leaderboard.firstIndex(of: state.score) {
                dailyRank = index + 1
            }
        }

        state.runSummary = RunSummary(
            finalScore: state.score,
            distance: state.distance,
            elapsedTime: elapsed,
            isNewBest: isNewBest,
            unlockedAchievements: unlocked,
            dailyRank: dailyRank
        )
    }
}

extension GameEngine: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        let previous = lastUpdateTime ?? time
        let delta = time - previous
        lastUpdateTime = time
        updateGame(time: time, delta: delta)
    }
}

extension GameEngine: SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        let mask = (contact.nodeA.physicsBody?.categoryBitMask ?? 0)
            | (contact.nodeB.physicsBody?.categoryBitMask ?? 0)
        if mask & CollisionCategory.player != 0 && mask & CollisionCategory.obstacle != 0 {
            audioManager.play(effect: "hit", enabled: settings.audioEnabled)
            hapticsManager.impact(style: .heavy, enabled: settings.hapticsEnabled)
            endRun()
        }
    }
}
