import Foundation

protocol RecommendationsServiceProtocol: AnyObject {
    func fetchRecommendations(advertId: Int) async throws -> [RecommendationResponse]
}

final class RecommendationsService: RecommendationsServiceProtocol {
    func fetchRecommendations(advertId: Int) async throws -> [RecommendationResponse] {
        try await Task.sleep(for: .milliseconds(500))

        return [
            .init(
                advertID: 201,
                title: "Toyota Camry 2.0",
                price: "16 500 000 ₸",
                imageURL: URL(string: "https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb")
            ),
            .init(
                advertID: 202,
                title: "Toyota RAV4",
                price: "21 300 000 ₸",
                imageURL: URL(string: "https://images.unsplash.com/photo-1568844293986-8d0400bd4745")
            ),
            .init(
                advertID: 203,
                title: "Toyota Corolla",
                price: "14 200 000 ₸",
                imageURL: URL(string: "https://images.unsplash.com/photo-1590362891991-f776e747a588")
            )
        ].filter { $0.advertID != advertId }
    }
}
