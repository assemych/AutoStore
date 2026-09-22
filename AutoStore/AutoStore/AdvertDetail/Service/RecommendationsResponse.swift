import Foundation

struct RecommendationResponse: Sendable {
    let advertID: Int
    let title: String
    let price: String
    let imageURL: URL?
}
