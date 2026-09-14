//
//  MainViewController.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 06.09.2026.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private lazy var collectionViewDataSource = MainListCollectionViewDataSource(collectionView: collectionView)
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .darkGray
        
        return collectionView
    }()
    
    private let presenter: MainViewOutputProtocol
        
    init(presenter: MainViewOutputProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        setupSubviews()
        setupConstraints()
        setupCollectionView()
        presenter.viewDidLoad()
    }
}

extension MainViewController: MainListViewInputProtocol {
    func reloadData(with viewData: MainViewData) {
        collectionViewDataSource.update(with: viewData)
    }
}

// MARK: - Setup
private extension MainViewController {
    private func setupSubviews() {
        view.addSubview(collectionView)
    }
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()

        }
    }
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.collectionViewLayout = createCollectionLayout()
    }
    
    private func createCollectionLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout {
            [weak self] sectionIndex,
            environment -> NSCollectionLayoutSection? in
            guard let self, let section = collectionViewDataSource.section(at: sectionIndex) else { return nil }
            
            switch section.type {
            case .horizontalList:
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                let containerGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.2)),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: containerGroup)
                section.orthogonalScrollingBehavior = .continuous
                
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(44)
                )
                
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                
                section.boundarySupplementaryItems = [header]

                return section
            case .loader:
                return nil
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {}
