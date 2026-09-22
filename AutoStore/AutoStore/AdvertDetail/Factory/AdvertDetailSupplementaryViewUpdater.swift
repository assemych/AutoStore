//
//  AdvertDetailSupplementaryViewUpdater.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 18.09.2026.
//

import Foundation
import UIKit

@MainActor
protocol AdvertDetailSupplementaryViewUpdaterProtocol {
    func update(_ update: AdvertDetailSupplementaryUpdate, in collectionView: UICollectionView)
}

@MainActor
final class AdvertDetailSupplementaryViewUpdater: AdvertDetailSupplementaryViewUpdaterProtocol {
    func update(_ update: AdvertDetailSupplementaryUpdate, in collectionView: UICollectionView) {
        switch update {
        case let .galleryPage(page):
            updateGalleryPage(
                page,
                in: collectionView
            )
        }
    }
}


private extension AdvertDetailSupplementaryViewUpdater {
    func updateGalleryPage(_ page: Int, in collectionView: UICollectionView) {
        let pageControlView = collectionView
            .visibleSupplementaryViews(
                ofKind: UICollectionView.elementKindSectionFooter
            )
            .compactMap { $0 as? GalleryPageControlView }
            .first
        
        pageControlView?.setCurrentPage(page)
    }
}
