import Combine
import Foundation

protocol FeedViewModel {
    func getPosts()
    var isLoading: Bool { get }
}

class FeedViewModelImpl: ObservableObject, FeedViewModel {
    
    @Published var posts = [Post]()
    
    private let service: FeedService
    private var cancellables = Set<AnyCancellable>()
    
    var isLoading: Bool {
        state == .loading
    }
    
    @Published private(set) var state: ResultState = .loading
    
    
    init(service: FeedService) {
        self.service = service
    }
    
    func getPosts() {
        
        print("DEBUG: fetching posts")
        
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
                // print(self.posts)
                // print(response.posts)
                // print(response.page)
            }
        
        self.cancellables.insert(cancellable)
    }
    
}
