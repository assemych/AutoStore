//
//  MainListCollectionViewDataSource.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 06.09.2026.
//

import UIKit

final class MainListCollectionViewDataSource: UICollectionViewDiffableDataSource<ListSectionData, ListSectionData.Item> {
    typealias Snapshot = NSDiffableDataSourceSnapshot<ListSectionData, ListSectionData.Item>

    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case let .loaderCell(cellData):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoaderCell", for: indexPath) as! LoaderCell
                cell.configure(with: cellData)
                
                return cell
            case let .horizontalItemCell(cellData):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalItemCell", for: indexPath) as! HorizontalItemCell
                cell.configure(with: cellData)
                
                return cell
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
        guard kind == UICollectionView.elementKindSectionHeader else {
            preconditionFailure("Unsupported supplementary view kind: \(kind)")
        }

        guard let section = sectionIdentifier(for: indexPath.section) else {
            preconditionFailure(
                """
                Section not found at index \(indexPath.section).
                Snapshot sections: \(snapshot().sectionIdentifiers)
                """
            )
        }

        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "SectionHeaderView",
            for: indexPath
        ) as? SectionHeaderView else {
            preconditionFailure("Failed to dequeue SectionHeaderView")
        }

        headerView.configure(viewData: .init(title: section.headerTitle ?? ""))

        return headerView
    }
    
    func update(with viewData: MainViewData) {
        let sections = viewData.sections
        
        var snapshot = Snapshot()
        snapshot.appendSections(sections.map { $0 })
        sections.forEach { section in
            snapshot.appendItems(section.items, toSection: section)
        }
        apply(snapshot, animatingDifferences: true)
    }
    
    func section(at index: Int) -> ListSectionData? {
        sectionIdentifier(for: index)
    }
    
    private func registerCells(collectionView: UICollectionView) {
        collectionView.register(LoaderCell.self, forCellWithReuseIdentifier: "LoaderCell")
        collectionView.register(HorizontalItemCell.self, forCellWithReuseIdentifier: "HorizontalItemCell")
    }
    private func registerSupplementaryViews(collectionView: UICollectionView) {
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SectionHeaderView"
        )
    }
}

