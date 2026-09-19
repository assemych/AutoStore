//
//  AdvertDetailViewController.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 14.09.2026.
//

import Foundation
import UIKit
import SnapKit

@MainActor
protocol AdvertDetailViewInputProtocol: AnyObject {
    func update(with viewData: AdvertDetailViewData)
}

final class AdvertDetailViewController: UIViewController, AdvertDetailViewInputProtocol {
    private lazy var collectionViewDataSource = AdvertDetailCollectionViewDataSource(collectionView: collectionView)
    
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
    
    private let collectionViewFactory: AdvertDetailCollectionViewLayoutFactoryProtocol
    private let supplementaryViewUpdater: AdvertDetailSupplementaryViewUpdaterProtocol
    private let presenter: AdvertDetailOutputProtocol
    
    init(
        presenter: AdvertDetailOutputProtocol,
        collectionViewFactory: AdvertDetailCollectionViewLayoutFactoryProtocol,
        supplementaryViewUpdater: AdvertDetailSupplementaryViewUpdaterProtocol
    ) {
        self.presenter = presenter
        self.collectionViewFactory = collectionViewFactory
        self.supplementaryViewUpdater = supplementaryViewUpdater
        
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
    
    func update(with viewData: AdvertDetailViewData) {
        collectionViewDataSource.update(with: viewData)
    }
}

// MARK: - Setup
private extension AdvertDetailViewController {
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
        collectionView.collectionViewLayout = createLayout()
    }
}

private extension AdvertDetailViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            guard let section = self?.collectionViewDataSource.sectionIdentifier(for: sectionIndex) else {
                return nil
            }
            
            switch section.type {
            case .galery:
                return self?.collectionViewFactory.makeGallerySection(environment: environment) { [weak self] page in
                    guard let self else { return }
                    
                    supplementaryViewUpdater.update(.galleryPage(page), in: collectionView)
                }
            case .title:
                return nil
            case .charecteristic:
                return nil
            case .buyButton:
                return nil
            case .reviews:
                return nil
            case .recommendations:
                return nil
            case .dealers:
                return nil
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension AdvertDetailViewController: UICollectionViewDelegate {}
