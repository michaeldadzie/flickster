import AVKit
//import Combine

protocol BaseFeedViewModel {
    func getPosts() async
    var isLoading: Bool { get }
}

class FeedViewModel: ObservableObject, BaseFeedViewModel {
    @Published var posts = [Post]()
    @Published var isPlaying: Bool = false
    @Published var scrollPosition: Int?
    
    private var currentPage = 78
    private let service: FeedService
    //private var cancellables = Set<AnyCancellable>()
    
    var isLoading: Bool {
        state == .loading
    }
    
    @Published private(set) var state: ResultState = .loading
    
    init(service: FeedService) {
        print("DEBUG: service")
        self.service = service
    }
    
    @MainActor
    func getPosts() async {
        self.state = .loading
        do {
            let response = try await service.request(from: .getPosts(page: currentPage))
            self.posts = response.posts.map { post in
                var mutablePost = post
                if let url = URL(string: post.videoLink) {
                    let player = AVQueuePlayer(url: url)
                    let playerItem = AVPlayerItem(url: url)
                    mutablePost.looper = AVPlayerLooper(player: player, templateItem: playerItem)
                    mutablePost.player = player
                }
                print("DEBUG: \(mutablePost.firstName)")
                return mutablePost
            }
            self.state = .success(content: self.posts)
            self.initPlayer()
        } catch {
            print("DEBUG: \(error)")
            self.state = .failed(error: error as? APIError ?? APIError.unknown)
        }
    }
    
//    @MainActor
//    func getPosts() async {
//        self.state = .loading
//        print("DEBUG: loading")
//        let cancellable = service
//            .request(from: .getPosts(page: currentPage))
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] res in
//                switch res {
//                case .finished:
//                    self?.state = .success(content: self?.posts ?? [])
//                case .failure(let error):
//                    self?.state = .failed(error: error)
//                }
//            } receiveValue: { [weak self] response in
//                let updatedPosts = response.posts.map { post -> Post in
//                    var mutablePost = post
//                    if let url = URL(string: post.videoLink) {
//                        let player = AVQueuePlayer(url: url)
//                        let playerItem = AVPlayerItem(url: url)
//                        mutablePost.looper = AVPlayerLooper(player: player, templateItem: playerItem)
//                        mutablePost.player = AVQueuePlayer(url: url)
//                    }
//                    print("DEBUG: \(mutablePost.firstName)")
//                    return mutablePost
//                }
//                self?.posts = updatedPosts
//                self?.state = .success(content: updatedPosts)
//                self?.initPlayer()
//            }
//        self.cancellables.insert(cancellable)
//    }
    
    func initPlayer() {
        print("DEBUG: init player")
        guard scrollPosition == nil, let firstPost = posts.first else { return }
        
        if firstPost.player != nil {
            firstPost.player?.play()
        }
    }
    
    func play(index: Int) {
        guard scrollPosition == nil else { return }
        posts[index].player?.play()
    }
    
    func pause(index: Int) {
        guard scrollPosition == nil else { return }
        posts[index].player?.pause()
    }
    
    @MainActor
    func onChanged(previousID: Int?, currentID: Int?) {
        if let previousID = previousID, let previousPost = posts.first(where: { $0.id == previousID }),
           let previousPlayer = previousPost.player, let prevoiusLooper = previousPost.looper {
            previousPlayer.seek(to: .zero)
            previousPlayer.pause()
            prevoiusLooper.disableLooping()
        }
        
        if let currentID = currentID, let currentPost = posts.first(where: { $0.id == currentID }), let currentPlayer = currentPost.player {
            currentPlayer.play()
        }
    }
}
