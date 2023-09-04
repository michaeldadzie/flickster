import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
}

enum FeedAPI {
    case getPosts
}


extension FeedAPI: APIBuilder {
    
    var baseUrl: URL {
        switch self {
        case .getPosts:
            return URL(string: "base-url")!
        }
    }
    
    var path: String {
        return "/path"
    }
    
    var urlRequest: URLRequest {
        return URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
    }
    
}
