//
//  AdvertDetailModuleFactory.swift
//  AutoStore
//
//  Created by Codex on 19.09.2026.
//

import UIKit

@MainActor
enum AdvertDetailModuleFactory {
    static func make(advertID: Int) -> UIViewController {
        let presenter = AdvertDetailPresenter(
            advertID: advertID,
            advertService: AdvertService()
        )
        let viewController = AdvertDetailViewController(
            presenter: presenter,
            collectionViewFactory: AdvertDetailCollectionViewLayoutFactory(),
            supplementaryViewUpdater: AdvertDetailSupplementaryViewUpdater()
        )
        presenter.view = viewController

        return viewController
    }
}
