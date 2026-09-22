import Foundation

struct ReviewsPageModel: Sendable {
    let rating: Double
    let totalCount: Int
    let reviews: [ReviewModel]
    let page: Int
    let hasNextPage: Bool
}


extension ReviewsPageModel {
    struct ReviewModel: Sendable {
        let id: Int
        let author: String
        let text: String
    }
}
