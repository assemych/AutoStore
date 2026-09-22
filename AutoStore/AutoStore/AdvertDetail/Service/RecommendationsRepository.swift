protocol RecommendationsRepositoryProtocol: AnyObject {
    func fetchRecommendations(advertId: Int) async throws -> [RecommendationModel]
}

final class RecommendationsRepository: RecommendationsRepositoryProtocol {
    private let service: RecommendationsServiceProtocol

    init(service: RecommendationsServiceProtocol) {
        self.service = service
    }

    func fetchRecommendations(advertId: Int) async throws -> [RecommendationModel] {
        let response = try await service.fetchRecommendations(advertId: advertId)

        return response.map {
            RecommendationModel(
                advertID: $0.advertID,
                title: $0.title,
                price: $0.price,
                imageURL: $0.imageURL
            )
        }
    }
}
