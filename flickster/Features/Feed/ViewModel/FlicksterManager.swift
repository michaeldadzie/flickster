import AVKit
import SwiftUI
import Combine

class FlicksterManager: ObservableObject {
    @Published var isPlaying: Bool = false
    @Published var player: AVQueuePlayer
    @Published var scrollPosition: Int?
    @Published var posts: [Post] = []
    
    private var cancellables = Set<AnyCancellable>()
    private var playerItems: [Int: AVPlayerItem] = [:]
    private var controllers: [URL: AVQueuePlayer] = [:]
    
    init(viewModel: FeedViewModelImpl) async {
        player = AVQueuePlayer()
        
        viewModel.$posts
            .sink { [weak self] feedPosts in
                self?.posts = feedPosts
                print(viewModel.posts)
            }
            .store(in: &cancellables)
        
        if viewModel.posts.isEmpty {
            await viewModel.getPosts()
        }
        
    }
    
//    func initializeVideoPlayer() {
//        guard !posts.isEmpty else { return }
//        
//        scrollPosition = 0
//        isPlaying = true
//        print("DEBUG: Init")
//        initController(index: scrollPosition!)
//        
//        if posts.count > 1 {
//            initController(index: scrollPosition! + 1)
//        }
//        
//        playController(index: scrollPosition!)
//    }
//    
//    private func initController(index: Int) {
//        guard posts.indices.contains(index) else { return }
//        let videoLink = posts[index].videoLink
//        guard let url = URL(string: videoLink) else { return }
//        
//        let playerItem = AVPlayerItem(url: url)
//        controllers[url] = AVQueuePlayer(playerItem: playerItem)
//        
//        player.addObserver(self as! NSObject, forKeyPath: "status", options: [.new, .old], context: nil)
//    }
//    
//    func avPlayer(index: Int) -> AVPlayer? {
//        let videoLink = posts[index].videoLink
//        guard let url = URL(string: videoLink) else {
//            return nil
//        }
//        return controllers[url]
//    }
//    
//    
//    private func playController(index: Int) {
//        let videoLink = posts[index].videoLink
//        
//        guard posts.indices.contains(index),
//              let url = URL(string: videoLink),
//              let player = controllers[url] else { return }
//        
//        // Add observer for player item
//        NotificationCenter.default.addObserver(
//            self, selector: #selector(
//                playerItemDidReachEnd(notification:)),
//            name: .AVPlayerItemDidPlayToEndTime,
//            object: player.currentItem
//        )
//        
//        if isPlaying {
//            self.player = player
//            player.play()
//            player.actionAtItemEnd = .none
//        } else {
//            player.pause()
//        }
//    }
//    
//    @objc private func playerItemDidReachEnd(notification: Notification) {
//        if let playerItem = notification.object as? AVPlayerItem {
//            playerItem.seek(to: CMTime.zero, completionHandler: nil)
//        }
//    }
//    
//    func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == "status" {
//            if let player = object as? AVPlayer {
//                switch player.status {
//                case .readyToPlay:
//                    break
//                case .failed:
//                    break
//                default:
//                    break
//                }
//            }
//        }
//    }
//    
//    // Don't forget to remove observers when they are no longer needed
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//        
//        for player in controllers.values {
//            player.removeObserver(self as! NSObject, forKeyPath: "status")
//        }
//    }
//    
//    private func stopController(index: Int) {
//        let videoLink = posts[index].videoLink
//        guard let url = URL(string: videoLink) else { return }
//        controllers[url]?.pause()
//        // Optionally seek to the start of the video
//        // controllers[url]?.seek(to: CMTime.zero, completionHandler: nil)
//    }
//    
//    private func removeController(index: Int) {
//        let videoLink = posts[index].videoLink
//        guard let url = URL(string: videoLink) else { return }
//        controllers.removeValue(forKey: url)
//    }
//    
//    private func nextVideo() {
//        guard let currentIndex = scrollPosition, currentIndex < posts.count - 1 else { return }
//        
//        stopController(index: currentIndex)
//        if currentIndex - 1 >= 0 {
//            removeController(index: currentIndex - 1)
//        }
//        
//        scrollPosition = currentIndex + 1
//        playController(index: scrollPosition!)
//        if scrollPosition! < posts.count - 1 {
//            initController(index: scrollPosition! + 1)
//        }
//    }
//    
//    private func previousVideo() {
//        guard let currentIndex = scrollPosition, currentIndex > 0 else { return }
//        
//        stopController(index: currentIndex)
//        if currentIndex + 1 < posts.count {
//            removeController(index: currentIndex + 1)
//        }
//        
//        scrollPosition = currentIndex - 1
//        playController(index: scrollPosition!)
//        if scrollPosition! > 0 {
//            initController(index: scrollPosition! - 1)
//        }
//    }
//    
//    func onPageChanged(newIndex: Int?) {
//        if let currentIndex = scrollPosition, currentIndex != newIndex {
//            isPlaying = true
//            if currentIndex > newIndex! {
//                previousVideo()
//            } else {
//                nextVideo()
//            }
//        }
//    }
    
    
}
