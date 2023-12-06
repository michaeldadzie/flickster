import Combine
import Foundation

protocol FeedViewModel {
    func getPosts()
    var isLoading: Bool { get }
}

class FeedViewModelImpl: ObservableObject, FeedViewModel {
    
    private let service: FeedService
    
    private(set) var posts = [Post]()
    private var cancellables = Set<AnyCancellable>()
    
    var isLoading: Bool {
        state == .loading
    }
    
    @Published private(set) var state: ResultState = .loading
    @Published var videoPlayerViewModel = VideoPlayerViewModel()
    
    
    init(service: FeedService) {
        self.service = service
    }
    
    func getPosts() {
        
        self.state = .loading
        
        let cancellable = service
            .request(from: .getPosts)
            .sink { res in
                switch res {
                case .finished:
                    self.state = .success(content:  self.posts)
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { response in
                self.posts = response.posts
            }
        
        self.cancellables.insert(cancellable)
    }
    
    func playVideo(post: Post) {
        guard let url = URL(string: post.videoLink) else {
            return
        }
        
        videoPlayerViewModel.playVideo(withURL: url)
    }
    
    func pauseVideo() {
        videoPlayerViewModel.pauseVideo()
    }
    
    func stopVideo() {
        videoPlayerViewModel.stopVideo()
    }
    
}