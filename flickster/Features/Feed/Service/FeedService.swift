//import Combine
import Foundation

protocol BaseFeedService {
    func request(from endpoint: FeedAPI) async throws -> PostModel
}

//protocol BaseFeedService {
//    func request(from endpoint: FeedAPI) -> AnyPublisher<PostModel, APIError>
//}

struct FeedService: BaseFeedService {
    func request(from endpoint: FeedAPI) async throws -> PostModel {
        let urlRequest = endpoint.urlRequest
        let (data, response) = try await URLSession.shared.data(for: urlRequest, delegate: nil)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknown
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.errorCode(httpResponse.statusCode)
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dataDecodingStrategy = .base64
        
        do {
            return try jsonDecoder.decode(PostModel.self, from: data)
        } catch {
            print("DEBUG: Decoding error -> \(error)")
            throw APIError.decodingError
        }
    }
}



//struct FeedService: BaseFeedService {
//    func request(from endpoint: FeedAPI) -> AnyPublisher<PostModel, APIError> {
//        return URLSession
//            .shared
//            .dataTaskPublisher(for: endpoint.urlRequest)
//            .receive(on: DispatchQueue.main)
//            .mapError {_ in APIError.unknown }
//            .flatMap { data, response -> AnyPublisher<PostModel, APIError> in
//                guard let response = response as? HTTPURLResponse else {
//                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
//                }
//                
//                if (200...299).contains(response.statusCode) {
//                    let jsonDecoder = JSONDecoder()
//                    jsonDecoder.dataDecodingStrategy = .base64
//                    return Just(data)
//                        .decode(type: PostModel.self, decoder: jsonDecoder)
//                        .mapError { error in
//                            print("Decoding error: \(error)")
//                            return APIError.decodingError }
//                        .eraseToAnyPublisher()
//                } else {
//                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
//                }
//            }
//            .eraseToAnyPublisher()
//    }
//}
