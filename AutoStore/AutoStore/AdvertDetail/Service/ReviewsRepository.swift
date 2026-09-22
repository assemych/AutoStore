protocol ReviewsRepositoryProtocol: AnyObject {
    func fetchReviews(advertId: Int, page: Int, pageSize: Int) async throws -> ReviewsPageModel
}

final class ReviewsRepository: ReviewsRepositoryProtocol {
    private let service: ReviewsServiceProtocol

    init(service: ReviewsServiceProtocol) {
        self.service = service
    }

    func fetchReviews(advertId: Int, page: Int, pageSize: Int) async throws -> ReviewsPageModel {
        let response = try await service.fetchReviews(advertId: advertId, page: page, pageSize: pageSize)

        return ReviewsPageModel(
            rating: response.rating,
            totalCount: response.totalCount,
            reviews: response.reviews.map {
                ReviewsPageModel.ReviewModel(id: $0.id, author: $0.author, text: $0.text)
            },
            page: response.page,
            hasNextPage: response.hasNextPage
        )
    }
}
