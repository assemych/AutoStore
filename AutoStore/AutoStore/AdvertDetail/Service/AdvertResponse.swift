import Foundation

struct AdvertResponse: Sendable {
    let id: Int
    let brand: String
    let model: String
    let price: String
    let year: Int
    let mileage: String
    let transmission: String
    let dealerName: String
    let dealerAddress: String
    let imageURLs: [URL]
}

extension AdvertResponse {
    static let mock = AdvertResponse(
        id: 123,
        brand: "Toyota",
        model: "Camry 2.5",
        price: "18 900 000 ₸",
        year: 2024,
        mileage: "12 500 км",
        transmission: "Автомат",
        dealerName: "Toyota Center Almaty",
        dealerAddress: "проспект Суюнбая, 151",
        imageURLs: [
            URL(string: "https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb")!,
            URL(string: "https://images.unsplash.com/photo-1619767886558-efdc259cde1a")!,
            URL(string: "https://images.unsplash.com/photo-1550355291-bbee04a92027")!
        ]
    )
}
