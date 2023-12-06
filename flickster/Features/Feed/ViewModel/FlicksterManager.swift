import AVKit
import SwiftUI
import Combine

class FlicksterManager: ObservableObject {
    @Published var isPlaying: Bool = false
    @Published var player: AVPlayer
    
    init() {
        player = AVPlayer()
    }


    func loadVideo(for post: Post) {
        let AVPlayer = AVPlayer(url: URL(string: post.videoLink)!)
        player = AVPlayer
    }

    func playVideo(id: Int) {
        player.play()
    }

    func pauseVideo(id: Int) {
        player.pause()
    }
    
}
