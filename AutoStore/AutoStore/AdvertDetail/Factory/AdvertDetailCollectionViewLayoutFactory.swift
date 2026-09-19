//
//  AdvertDetailCollectionViewLayoutFactory.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 15.09.2026.
//

import Foundation
import UIKit

protocol AdvertDetailCollectionViewLayoutFactoryProtocol: AnyObject {
    func makeGallerySection(
        environment: NSCollectionLayoutEnvironment,
        onPageChanged: @escaping (Int) -> Void
) -> NSCollectionLayoutSection
}


final class AdvertDetailCollectionViewLayoutFactory: AdvertDetailCollectionViewLayoutFactoryProtocol {
    func makeGallerySection(
        environment: NSCollectionLayoutEnvironment,
        onPageChanged: @escaping (Int) -> Void
    ) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(280)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let pageControlSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(24)
        )
        
        let pageControl = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: pageControlSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        
        section.boundarySupplementaryItems = [pageControl]
        
        var currentPage = 0
        section.visibleItemsInvalidationHandler = { _, offset, environment in
            let pageWidth = environment.container.effectiveContentSize.width
            
            guard pageWidth > 0 else {
                return
            }
            
            let page = Int(round(offset.x / pageWidth))
            guard page != currentPage else {
                return
            }

            currentPage = page
            onPageChanged(page)
        }
        
        return section
    }
}
