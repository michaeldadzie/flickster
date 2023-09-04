import Foundation


enum ResultState {
    case loading
    case success(content: [Post])
    case failed(error: Error)
}
