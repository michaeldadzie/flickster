import AVKit
import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModelImpl(service: FeedServiceImpl())
    @StateObject var manager = FlicksterManager()
    @State private var scrollPosition: Int?
    // @State private var player = AVPlayer()
    @State private var hasLoadedPosts = false
    
    // @StateObject var videoView = VideoPlayerViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.posts) { post in
                    FeedCell(post: post, player: manager.player)
                        .id(post.id)
                        .onAppear {
                            initPlayer()
                        }
                }
            }
            .scrollTargetLayout()
        }
        .onAppear {
            manager.player.play()
        }
        .scrollPosition(id: $scrollPosition)
        .scrollTargetBehavior(.paging)
        .ignoresSafeArea()
        .onChange(of: scrollPosition) { previousIndex, currentIndex in
            print(currentIndex!)
            onChanged(postId: currentIndex)
        }
        .task(priority: .background, { loadPostsIfNeeded() })
         /* NavigationView {
            Group {
                switch viewModel.state {
                case .loading:
                    ZStack {
                        Color(.white)
                        ProgressView()
                    }
                    
                default:
                    ScrollView {}
                }
            }
            .task(priority: .background, { viewModel.getPosts() })
        } */
    }
    
    private func loadPostsIfNeeded() {
        guard !hasLoadedPosts else {
            return
        }
        
        viewModel.getPosts()
        hasLoadedPosts = true
    }
    
    func initPlayer() {
        guard scrollPosition == nil, let post = viewModel.posts.first,
              manager.player.currentItem == nil else { return }
        
        let item = AVPlayerItem(url: URL(string: post.videoLink)!)
        manager.player.replaceCurrentItem(with: item)
    }
    
    func onChanged(postId: Int?) {
        guard let currentIndex = viewModel.posts.first(where: {  $0.id == postId }) else { return }
        
        manager.player.replaceCurrentItem(with: nil) // wipes out previous player, figure out a way pause for 3 indexs before replacing
        let playerItem = AVPlayerItem(url: URL(string: currentIndex.videoLink)!)
        manager.player.replaceCurrentItem(with: playerItem)
    }
}

#Preview {
    FeedView()
}
