import Foundation

struct Post: Codable, Identifiable, Equatable {
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let category: Category
    let slug, title, identifier: String
    let commentCount, upvoteCount, shareCount: Int
    let videoLink: String
    let isLocked: Bool
    let createdAt: Int
    let firstName, lastName, username: String
    let upvoted, bookmarked: Bool
    let thumbnailURL: String
    let following: Bool
    let pictureURL: String

    enum CodingKeys: String, CodingKey {
        case id, category, slug, title, identifier
        case commentCount = "comment_count"
        case upvoteCount = "upvote_count"
        case shareCount = "share_count"
        case videoLink = "video_link"
        case isLocked = "is_locked"
        case createdAt = "created_at"
        case firstName = "first_name"
        case lastName = "last_name"
        case username, upvoted, bookmarked
        case thumbnailURL = "thumbnail_url"
        case following
        case pictureURL = "picture_url"
    }
}

struct PostData: Codable {
    let page, recordsPerPage, maxPageSize, pageSize: Int
    let posts: [Post]

    enum CodingKeys: String, CodingKey {
        case page
        case recordsPerPage = "records_per_page"
        case maxPageSize = "max_page_size"
        case pageSize = "page_size"
        case posts
    }
}

extension Post {
    static var dummyData: [Post] {
        [
            .init(
                id: 1097,
                category: Category(
                    id: 108,
                    name: "Holy Vible",
                    count: 27,
                    description: "The best vibes!",
                    imageURL: "https://cdn-assets.socialverseapp.com/categories/4d66f8010a443cd981da1fb57d6db086"
                ),
                slug: "matthew-13-12",
                title: "Matthew 13:12",
                identifier: "cP-WIDC",
                commentCount: 0,
                upvoteCount: 0,
                shareCount: 0,
                videoLink: "https://video-cdn.socialverseapp.com/kinha_00043ceb-bb9d-4053-9d96-9796d8eca513.mp4",
                isLocked: false,
                createdAt: 1693429738000,
                firstName: "Michael",
                lastName: "Dadzie",
                username: "afrobeezy",
                upvoted: false,
                bookmarked: false,
                thumbnailURL: "https://vs.socialverseapp.com/afrobeezy_f77b2cef372a91f3911f0938c7262c9d6de1add3992/afrobeezy_f77b2cef372a91f3911f0938c7262c9d6de1add3992.0000005.jpg",
                following: false,
                pictureURL: "https://cdn-assets.socialverseapp.com/profile/flic-avatar-f921f0e59f17af0389138ffec362a0d5.png"),
            .init(
                id: 1097,
                category: Category(
                    id: 108,
                    name: "Holy Vible",
                    count: 27,
                    description: "The best vibes!",
                    imageURL: "https://cdn-assets.socialverseapp.com/categories/4d66f8010a443cd981da1fb57d6db086"
                ),
                slug: "matthew-13-12",
                title: "Matthew 13:12",
                identifier: "cP-WIDC",
                commentCount: 0,
                upvoteCount: 0,
                shareCount: 0,
                videoLink: "https://video-cdn.socialverseapp.com/Partik_9d6a7bda-798f-4768-a9cc-a2e8d7091d86.mp4",
                isLocked: false,
                createdAt: 1693429738000,
                firstName: "Michael",
                lastName: "Dadzie",
                username: "afrobeezy",
                upvoted: false,
                bookmarked: false,
                thumbnailURL: "https://vs.socialverseapp.com/afrobeezy_f77b2cef372a91f3911f0938c7262c9d6de1add3992/afrobeezy_f77b2cef372a91f3911f0938c7262c9d6de1add3992.0000005.jpg",
                following: false,
                pictureURL: "https://cdn-assets.socialverseapp.com/profile/flic-avatar-f921f0e59f17af0389138ffec362a0d5.png")
        ]
    }
}
