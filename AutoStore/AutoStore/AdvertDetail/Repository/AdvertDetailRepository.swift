//
//  AdvertDetailRepository.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 22.09.2026.
//

import Foundation

protocol AdvertDetailRepositoryProtocol: AnyObject {
    func preparePayment(advertId: Int) async throws -> PaymentModel
    func fetchAdvert(id: Int) async throws -> AdvertModel
    func fetchReviews(advertId: Int, page: Int, pageSize: Int) async throws -> ReviewsPageModel
    func fetchRecommendations(advertId: Int) async throws -> [RecommendationModel]
}

final class AdvertDetailRepository: AdvertDetailRepositoryProtocol {
    private let paymentRepository: PaymentRepositoryProtocol
    private let advertRepository: AdvertRepositoryProtocol
    private let reviewsService: ReviewsServiceProtocol
    private let recommendationsService: RecommendationsServiceProtocol
    
    init(
        paymentRepository: PaymentRepositoryProtocol,
        advertRepository: AdvertRepositoryProtocol,
        reviewsService: ReviewsServiceProtocol,
        recommendationsService: RecommendationsServiceProtocol
    ) {
        self.paymentRepository = paymentRepository
        self.advertRepository = advertRepository
        self.reviewsService = reviewsService
        self.recommendationsService = recommendationsService
    }
    
    func fetchAdvert(id: Int) async throws -> AdvertModel {
        try await advertRepository.fetchAdvert(id: id)
    }
    
    func preparePayment(advertId: Int) async throws -> PaymentModel {
        try await paymentRepository.preparePayment(advertId: advertId)
    }
    
    func fetchReviews(advertId: Int, page: Int, pageSize: Int) async throws -> ReviewsPageModel {
        let response = try await reviewsService.fetchReviews(
            advertId: advertId,
            page: page,
            pageSize: pageSize
        )

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
    
    func fetchRecommendations(advertId: Int) async throws -> [RecommendationModel] {
        let response = try await recommendationsService.fetchRecommendations(advertId: advertId)

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
