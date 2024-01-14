import AVKit
import Combine

protocol FeedViewModel {
    func getPosts() async
    var isLoading: Bool { get }
}

class FeedViewModelImpl: ObservableObject, FeedViewModel {
    @Published var posts = [Post]()
    @Published var isPlaying: Bool = false
    //@Published var player: AVQueuePlayer
    @Published var scrollPosition: Int?
    
    private var currentPage = 74
    private let service: FeedService
    private var cancellables = Set<AnyCancellable>()
    
    var isLoading: Bool {
        state == .loading
    }
    
    @Published private(set) var state: ResultState = .loading
    
    init(service: FeedService) {
        //player = AVQueuePlayer()
        self.service = service
    }
    
    @MainActor
    func getPosts() async {
        self.state = .loading
        
        let cancellable = service
            .request(from: .getPosts(page: currentPage))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] res in
                switch res {
                case .finished:
                    self?.state = .success(content: self?.posts ?? [])
                case .failure(let error):
                    self?.state = .failed(error: error)
                }
            } receiveValue: { [weak self] response in
                let updatedPosts = response.posts.map { post -> Post in
                    var mutablePost = post
                    if let url = URL(string: post.videoLink) {
                        mutablePost.player = AVQueuePlayer(url: url)
                    }
                    
                    return mutablePost
                }
                self?.posts = updatedPosts
                self?.state = .success(content: updatedPosts)
                self?.initPlayer()
                /*
                 self?.posts = response.posts
                 self?.state = .success(content: response.posts)
                 */
            }
        
        self.cancellables.insert(cancellable)
    }
    
    func initPlayer() {
        guard scrollPosition == nil, !posts.isEmpty else { return }
        
        if posts[0].player != nil, let url = URL(string: posts[0].videoLink) {
            posts[0].player = AVQueuePlayer(url: url)
            posts[0].player?.play()
        }
    }
    
    //    func initPlayer() {
    //        /*guard scrollPosition == nil, let post = posts.first,
    //              player.currentItem == nil else {return }
    //
    //        print("DEBUG: Init Video Player")
    //        let item = AVPlayerItem(url: URL(string: post.videoLink)!)
    //        player.replaceCurrentItem(with: item)*/
    //    }
    
    func onChanged(previousID: Int?, currentID: Int?) {
        if let previousID = previousID, let previousPost = posts.first(where: { $0.id == previousID }), let previousPlayer = previousPost.player {
            previousPlayer.pause()
        }
        
        if let currentID = currentID, let currentPost = posts.first(where: { $0.id == currentID }), let currentPlayer = currentPost.player {
            currentPlayer.play()
        }
        
        /*player.pause()
         isPlaying = false
         
         print("DEBUG: Changing Index \(currentID ?? 0)")
         guard let currentPost = posts.first(where: { $0.id == currentID }) else { return }
         //guard let previousPost = posts.first(where:   { $0.id == previousID }) else { return }
         
         DispatchQueue.main.async { [weak self] in
         guard let self = self else { return }
         //let previousItem = AVPlayerItem(url: URL(string: previousPost.videoLink)!)
         self.player.replaceCurrentItem(with: nil) // nil
         let currentItem = AVPlayerItem(url: URL(string: currentPost.videoLink)!)
         self.player.replaceCurrentItem(with: currentItem)
         self.player.play()
         self.isPlaying = true
         
         }*/
    }
}
