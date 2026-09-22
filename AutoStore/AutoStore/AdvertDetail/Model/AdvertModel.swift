import Foundation

nonisolated struct AdvertModel: Sendable {
    let id: Int
    let title: String
    let price: String
    let year: Int
    let mileage: String
    let transmission: String
    let dealerName: String
    let dealerAddress: String
    let imageURLs: [URL]
}
