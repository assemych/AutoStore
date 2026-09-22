import Foundation

nonisolated struct AdvertModel: Sendable {
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
    let recommendations: [Recommendation]
}
