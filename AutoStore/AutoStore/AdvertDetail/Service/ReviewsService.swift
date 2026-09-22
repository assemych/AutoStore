import Foundation

protocol ReviewsServiceProtocol: AnyObject {
    func fetchReviews(advertId: Int, page: Int, pageSize: Int) async throws -> ReviewsPageResponse
}

final class ReviewsService: ReviewsServiceProtocol {
    private let reviews: [ReviewsPageResponse.Review] = [
        .init(id: 1, author: "Алексей", text: "Комфортный автомобиль для города и трассы."),
        .init(id: 2, author: "Дина", text: "Просторный салон и понятное управление."),
        .init(id: 3, author: "Марат", text: "Хорошая шумоизоляция и мягкая подвеска."),
        .init(id: 4, author: "Айжан", text: "Экономичный расход для автомобиля этого класса."),
        .init(id: 5, author: "Тимур", text: "Удобные сиденья, в дальней дороге не устаёшь."),
        .init(id: 6, author: "Елена", text: "Понравились комплектация и качество отделки."),
        .init(id: 7, author: "Руслан", text: "Надёжный автомобиль, полностью оправдал ожидания.")
    ]

    func fetchReviews(advertId: Int, page: Int, pageSize: Int) async throws -> ReviewsPageResponse {
        try await Task.sleep(for: .milliseconds(500))

        let startIndex = min((page - 1) * pageSize, reviews.count)
        let endIndex = min(startIndex + pageSize, reviews.count)

        return ReviewsPageResponse(
            rating: 4.8,
            totalCount: reviews.count,
            reviews: Array(reviews[startIndex..<endIndex]),
            page: page,
            hasNextPage: endIndex < reviews.count
        )
    }
}
