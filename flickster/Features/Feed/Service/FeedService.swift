import Combine
import Foundation

protocol FeedService {
    func request(from endpoint: FeedAPI) -> AnyPublisher<PostModel, APIError>
}

struct FeedServiceImpl: FeedService {
    func request(from endpoint: FeedAPI) -> AnyPublisher<PostModel, APIError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError {_ in APIError.unknown }
            .flatMap { data, response -> AnyPublisher<PostModel, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dataDecodingStrategy = .base64
                    return Just(data)
                        .decode(type: PostModel.self, decoder: jsonDecoder)
                        .mapError { error in
                            print("Decoding error: \(error)")
                            return APIError.decodingError }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
