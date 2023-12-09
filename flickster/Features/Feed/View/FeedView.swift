import AVKit
import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModelImpl(service: FeedServiceImpl())
    @StateObject var manager = FlicksterManager(viewModel: FeedViewModelImpl(service: FeedServiceImpl()))
    // @State private var player = AVPlayer()
    @State private var hasLoadedPosts = false
    
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
        .scrollPosition(id: $manager.scrollPosition)
        .scrollTargetBehavior(.paging)
        .ignoresSafeArea()
        .onChange(of: manager.scrollPosition) { previousIndex, currentIndex in
            // print(currentIndex!)
            manager.onChanged(previousID: previousIndex, currentID: currentIndex)
        }
        .task(priority: .background, { loadPostsIfNeeded() })
    }
    
    private func loadPostsIfNeeded() {
        guard !hasLoadedPosts else {
            return
        }
        
        viewModel.getPosts()
        hasLoadedPosts = true
    }
    
    private func initPlayer() {
        guard manager.scrollPosition == nil, let post = viewModel.posts.first,
              manager.player.currentItem == nil else {return }
        
        print("DEBUG: Init")
        let item = AVPlayerItem(url: URL(string: post.videoLink)!)
        manager.player.replaceCurrentItem(with: item)
    }
    
//    func onChanged(postId: Int?) {
//        guard let currentIndex = viewModel.posts.first(where: {  $0.id == postId }) else { return }
//        
//        manager.player.replaceCurrentItem(with: nil) // wipes out previous player, figure out a way pause for 3 indexs before replacing
//        let playerItem = AVPlayerItem(url: URL(string: currentIndex.videoLink)!)
//        manager.player.replaceCurrentItem(with: playerItem)
//    }
}

#Preview {
    FeedView()
}
