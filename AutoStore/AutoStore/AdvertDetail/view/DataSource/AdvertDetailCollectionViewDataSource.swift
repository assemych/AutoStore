import UIKit

@MainActor
final class AdvertDetailCollectionViewDataSource: UICollectionViewDiffableDataSource<AdvertDetailSection, AdvertDetailItem> {
    typealias Snapshot = NSDiffableDataSourceSnapshot<AdvertDetailSection, AdvertDetailItem>

    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, item in
            switch item.content {
            case let .gallery(data):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "GalleryCell",
                    for: indexPath
                ) as? GalleryCell
                cell?.configure(with: data)
                
                return cell
            case let .text(data):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "AdvertDetailTextCell",
                    for: indexPath
                ) as? AdvertDetailTextCell
                cell?.configure(with: data)
                
                return cell
            case let .buyButton(data):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "AdvertDetailButtonCell",
                    for: indexPath
                ) as? AdvertDetailButtonCell
                cell?.configure(with: data)
                
                return cell
            }
        }

        collectionView.register(GalleryCell.self, forCellWithReuseIdentifier: "GalleryCell")
        collectionView.register(AdvertDetailTextCell.self, forCellWithReuseIdentifier: "AdvertDetailTextCell")
        collectionView.register(AdvertDetailButtonCell.self, forCellWithReuseIdentifier: "AdvertDetailButtonCell")
        collectionView.register(
            GalleryPageControlView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: "GalleryPageControlView"
        )
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let section = sectionIdentifier(for: indexPath.section),
              case let .gallery(viewData)? = section.footer,
              let galleryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "GalleryPageControlView",
                for: indexPath
              ) as? GalleryPageControlView else {
            preconditionFailure("Invalid gallery footer configuration")
        }

        galleryView.configure(with: viewData)
        
        return galleryView
    }

    func update(with viewData: AdvertDetailViewData) {
        let previousItemsByID = Dictionary(
            uniqueKeysWithValues: snapshot().itemIdentifiers.map { ($0.id, $0) }
        )
        let sections = viewData.sections

        var newSnapshot = Snapshot()
        newSnapshot.appendSections(sections)
        sections.forEach { section in
            newSnapshot.appendItems(section.items, toSection: section)
        }

        let changedItems = sections
            .flatMap(\.items)
            .filter { newItem in
                guard let previousItem = previousItemsByID[newItem.id] else {
                    return false
                }

                return previousItem.content != newItem.content
            }
        newSnapshot.reconfigureItems(changedItems)

        apply(newSnapshot, animatingDifferences: !previousItemsByID.isEmpty)
    }

    func clear() {
        apply(Snapshot(), animatingDifferences: false)
    }

}
