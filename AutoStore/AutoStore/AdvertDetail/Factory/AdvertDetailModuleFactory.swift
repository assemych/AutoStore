//
//  AdvertDetailModuleFactory.swift
//  AutoStore
//
//  Created by Codex on 19.09.2026.
//

import UIKit

@MainActor
enum AdvertDetailModuleFactory {
    static func make(
        advertID: Int,
        output: AdvertDetailOutput? = nil
    ) -> UIViewController {
        let presenter = AdvertDetailPresenter(
            advertID: advertID,
            repository: AdvertDetailRepository(
                paymentRepository: PaymentRepository(
                    idGeneratorService: PaymentIDGeneratorService(),
                    paymentDataService: PaymentDataService()
                ),
                advertRepository: AdvertRepository(
                    service: AdvertService(),
                    mapper: AdvertMapper()
                ),
                reviewsService: ReviewsService(),
                recommendationsService: RecommendationsService()
            ),
            viewDataFactory: AdvertDetailViewDataFactory()
        )
        let viewController = AdvertDetailViewController(
            presenter: presenter,
            collectionViewFactory: AdvertDetailCollectionViewLayoutFactory(),
            supplementaryViewUpdater: AdvertDetailSupplementaryViewUpdater()
        )
        presenter.view = viewController
        presenter.output = output

        return viewController
    }
}
