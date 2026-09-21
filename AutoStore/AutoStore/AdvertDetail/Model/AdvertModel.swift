import Foundation

nonisolated struct AdvertModel: Sendable {
    struct Review: Sendable {
        let id: Int
        let author: String
        let text: String
    }

    struct Recommendation: Sendable {
        let id: Int
        let title: String
        let price: String
    }

    let id: Int
    let title: String
    let price: String
    let year: Int
    let mileage: String
    let transmission: String
    let dealerName: String
    let dealerAddress: String
    let imageURLs: [URL]
    let reviews: [Review]
    let recommendations: [Recommendation]
}
