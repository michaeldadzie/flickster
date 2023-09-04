import Combine
import Foundation

protocol FeedViewModel {
    func getPosts()
}

class FeedViewModelImpl: ObservableObject, FeedViewModel {
    
    private let service: FeedService
    
    private(set) var posts = [Post]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: ResultState = .loading
    
    init(service: FeedService) {
        self.service = service
    }
    
    func getPosts() {
        
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
    
}
