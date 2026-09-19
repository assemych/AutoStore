//
//  AdvertDetailCollectionViewDataSource.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 14.09.2026.
//

import Foundation
import UIKit

final class AdvertDetailCollectionViewDataSource: UICollectionViewDiffableDataSource<AdvertDetailSection, AdvertDetailSection.ItemType> {
    typealias Snapshot = NSDiffableDataSourceSnapshot<AdvertDetailSection, AdvertDetailSection.ItemType>
    
    private weak var collectionView: UICollectionView?
        
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        super.init(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .galery(let cellData):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "GalleryCell",
                    for: indexPath
                ) as? GalleryCell
                
                cell?.configure(with: cellData)
                
                return cell
            case .title:
                return UICollectionViewCell()
            case .charecteristic:
                return UICollectionViewCell()
            case .buyButton:
                return UICollectionViewCell()
            case .reviews:
                return UICollectionViewCell()
            case .recommendations:
                return UICollectionViewCell()
            case .dealers:
                return UICollectionViewCell()
            }
            
        }
        
        registerCells(collectionView: collectionView)
        registerSupplementaryViews(collectionView: collectionView)
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let section = sectionIdentifier(for: indexPath.section) else {
            preconditionFailure("Unsupported supplementary view or missing section")
        }
        
        switch section.footerType {
        case let .gallery(viewData):
            guard let galleryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "GalleryPageControlView",
                for: indexPath
            ) as? GalleryPageControlView else {
                preconditionFailure("Failed to dequeue GalleryPageControlView")
            }
            
            galleryView.configure(with: viewData)
            
            return galleryView
        }
    }
    
    func update(with viewData: AdvertDetailViewData) {
        let sections = viewData.sections
        
        var snapshot = Snapshot()
        snapshot.appendSections(sections.map { $0 })
        sections.forEach { section in
            snapshot.appendItems(section.items, toSection: section)
        }
        apply(snapshot, animatingDifferences: true)
    }
    
    func numberOfGalleryItems() -> Int {
        let snapshot = snapshot()

        guard let gallerySection = snapshot.sectionIdentifiers.first(where: { $0.type == .galery }) else {
            return 0
        }

        return snapshot.numberOfItems(inSection: gallerySection)
    }
    
    func updateGalleryPage(_ page: Int) {
        let snapshot = snapshot()
        
        guard let gallerySection = snapshot.sectionIdentifiers.first(where: { $0.type == .galery }),
              let sectionIndex = snapshot.indexOfSection(gallerySection) else {
            return
        }
        
        let pagesCount = snapshot.numberOfItems(inSection: gallerySection)
        
        guard pagesCount > 0 else { return }
        
        let validPage = min(max(page, 0), pagesCount - 1)
        let indexPath = IndexPath(item: 0, section: sectionIndex)
        
        guard let galleryView = collectionView?.supplementaryView(
            forElementKind: UICollectionView.elementKindSectionFooter,
            at: indexPath
        ) as? GalleryPageControlView else {
            return
        }
        
        galleryView.setCurrentPage(validPage)
    }
}

private extension AdvertDetailCollectionViewDataSource {
    private func registerCells(collectionView: UICollectionView) {
        collectionView.register(GalleryCell.self, forCellWithReuseIdentifier: "GalleryCell")
    }
    private func registerSupplementaryViews(collectionView: UICollectionView) {
        collectionView.register(
            GalleryPageControlView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: "GalleryPageControlView"
        )
    }
}
