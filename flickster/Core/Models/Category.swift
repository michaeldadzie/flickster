import Foundation

struct Category: Codable {
    let id: Int
    let name: String
    let count: Int
    let description: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id, name, count, description
        case imageURL = "image_url"
    }
}
