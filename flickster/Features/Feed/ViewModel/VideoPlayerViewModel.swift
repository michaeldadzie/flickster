import AVKit
import SwiftUI
import Combine

class VideoPlayerViewModel: ObservableObject {
    @Published var currentPlayer: AVPlayer?
    @Published var isPlaying: Bool = false

    func playVideo(withURL url: URL) {
        let player = AVPlayer(url: url)
        currentPlayer = player
        player.play()
        isPlaying = true
    }

    func pauseVideo() {
        currentPlayer?.pause()
        isPlaying = false
    }

    func stopVideo() {
        currentPlayer?.pause()
        currentPlayer = nil
        isPlaying = false
    }
}
