import SwiftUI
import AVKit

struct PlayerView: View {
    
    @ObservedObject var videoPlayerViewModel: VideoPlayerViewModel
    let post: [Post]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<post.count, id: \.self) { i in
                ZStack {
                    VideoPlayer(player: self.videoPlayerViewModel.currentPlayer)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    //                        .offset(y: -5)
                }
            }
        }
        .onAppear {
            if !self.post.isEmpty {
                self.videoPlayerViewModel.playVideo(withURL: URL(string: self.post[0].videoLink)!)
                self.videoPlayerViewModel.currentPlayer?.actionAtItemEnd = .none
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.videoPlayerViewModel.currentPlayer?.currentItem, queue: .main) { (_) in
                    self.videoPlayerViewModel.isPlaying = false
                }
            }
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        let videoPlayerViewModel = VideoPlayerViewModel()
        PlayerView(videoPlayerViewModel: videoPlayerViewModel, post: Post.dummyData)
    }
}
