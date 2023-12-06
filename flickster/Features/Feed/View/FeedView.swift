import SwiftUI

struct FeedView: View {
    
    @StateObject var feedView = FeedViewModelImpl(service: FeedServiceImpl())
    @StateObject var videoView = VideoPlayerViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                switch feedView.state {
                case .loading:
                    ZStack { }
                case .failed(error: let error):
                    Text(error.localizedDescription)
                default:
                    ZStack {
                        PlayerScrollView(videoPlayerViewModel: videoView, post: feedView.posts)
                    }
                }
            }
            .onTapGesture {
                if (videoView.isPlaying) {
                    videoView.pauseVideo()
                } else {
                    videoView.currentPlayer?.play()
                }
            }
            .ignoresSafeArea(.all)
            .background(.black)
            .onAppear(perform: feedView.getPosts)
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
