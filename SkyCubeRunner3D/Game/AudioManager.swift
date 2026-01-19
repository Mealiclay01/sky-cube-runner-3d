import AVFoundation
import Foundation

final class AudioManager {
    private var players: [String: AVAudioPlayer] = [:]
    private var musicPlayer: AVAudioPlayer?

    func play(effect name: String, enabled: Bool) {
        guard enabled else { return }
        if let player = players[name] {
            player.currentTime = 0
            player.play()
            return
        }
        guard let url = Bundle.main.url(forResource: name, withExtension: "wav") else { return }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
            players[name] = player
        } catch {
            return
        }
    }

    func setMusic(enabled: Bool) {
        if enabled {
            playMusicIfNeeded()
        } else {
            musicPlayer?.stop()
        }
    }

    private func playMusicIfNeeded() {
        if let musicPlayer {
            musicPlayer.play()
            return
        }
        guard let url = Bundle.main.url(forResource: "collect", withExtension: "wav") else { return }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = -1
            player.volume = 0.3
            player.prepareToPlay()
            player.play()
            musicPlayer = player
        } catch {
            return
        }
    }
}
