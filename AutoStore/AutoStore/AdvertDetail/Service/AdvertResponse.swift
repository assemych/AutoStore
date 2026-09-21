import Foundation

struct AdvertResponse: Sendable {
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
    let brand: String
    let model: String
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
        ],
        reviews: [
            .init(id: 1, author: "Алексей", text: "Комфортный автомобиль для города и трассы."),
            .init(id: 2, author: "Дина", text: "Просторный салон и понятное управление.")
        ],
        recommendations: [
            .init(id: 201, title: "Toyota Camry 2.0", price: "16 500 000 ₸"),
            .init(id: 202, title: "Toyota RAV4", price: "21 300 000 ₸")
        ]
    )
}
