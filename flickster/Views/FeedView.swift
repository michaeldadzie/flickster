import SwiftUI

struct FeedView: View {
    
    @StateObject var viewModel = FeedViewModelImpl(service: FeedServiceImpl())
    @StateObject var videoviewModel = VideoPlayerViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .loading:
                    ProgressView()
//                case .failed(error: let error):
//                    Text(error.localizedDescription)
//                case .success(content: viewModel.posts):
//                    List(viewModel.posts) { item in
//                        VideoView(post: item)
//                    }
                default:
                    ZStack {
                        PlayerScrollView(videoPlayerViewModel: videoviewModel, post: viewModel.posts)
                    }
                }
            }
            .ignoresSafeArea(.all)
            .onAppear(perform: viewModel.getPosts)
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
