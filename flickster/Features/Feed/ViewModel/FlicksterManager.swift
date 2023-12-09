import AVKit
import SwiftUI
import Combine

class FlicksterManager: ObservableObject {
    @Published var isPlaying: Bool = false
    @Published var player: AVPlayer
    @Published var scrollPosition: Int?
    @Published var posts: [Post] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: FeedViewModelImpl) {
        player = AVPlayer()
        
        viewModel.$posts
            .sink { [weak self] feedPosts in
                self?.posts = feedPosts
                print(viewModel.posts)
            }
            .store(in: &cancellables)
        
        if viewModel.posts.isEmpty {
            viewModel.getPosts()
        }
    }
    
    func loadVideo(for post: Post) {
        let AVPlayer = AVQueuePlayer(url: URL(string: post.videoLink)!)
        player = AVPlayer
    }
    
    func playVideo(id: Int) {
        player.play()
    }
    
    func pauseVideo(id: Int) {
        player.pause()
    }
    
    func onChanged(previousID: Int?, currentID: Int?) {
        player.pause()
        isPlaying = false
        
        print("DEBUG: Changing Index \(currentID ?? 0)")
        guard let currentPost = posts.first(where: { $0.id == currentID }) else { return }
        //guard let previousPost = posts.first(where: { $0.id == previousID }) else { return }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            //let previousItem = AVPlayerItem(url: URL(string: previousPost.videoLink)!)
            self.player.replaceCurrentItem(with: nil) // nil
            let currentItem = AVPlayerItem(url: URL(string: currentPost.videoLink)!)
            self.player.replaceCurrentItem(with: currentItem)
            self.player.play()
            self.isPlaying = true
            
            /* if let url = URL(string: currentPost.videoLink) {
                let playerItem = AVPlayerItem(url: url)
                let queueItem = AVQueuePlayer(items: [playerItem])
                self.player.replaceCurrentItem(with: playerItem)
                player.play()
                isPlaying = true
                print("DEBUG: Playing Index \(currentPost)")
            } else {
                print("Invalid URL for post \(currentPost)")
            } */
        }
    }
    
}
