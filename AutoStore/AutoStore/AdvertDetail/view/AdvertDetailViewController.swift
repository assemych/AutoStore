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
    func render(state: AdvertDetailViewState)
    func showPurchaseError(message: String)
    func showReviewsError(message: String)
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
        collectionView.backgroundColor = .systemBackground
        
        return collectionView
    }()

    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let stateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    private let retryButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Повторить"
        return UIButton(configuration: configuration)
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
        
        view.backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
        setupCollectionView()
        presenter.viewDidLoad()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear()
    }

    func render(state: AdvertDetailViewState) {
        activityIndicator.stopAnimating()
        collectionView.isHidden = true
        stateLabel.isHidden = true
        retryButton.isHidden = true

        switch state {
        case .loading:
            collectionViewDataSource.clear()
            activityIndicator.startAnimating()
        case let .content(viewData):
            collectionView.isHidden = false
            collectionViewDataSource.update(with: viewData)
        case let .empty(message):
            collectionViewDataSource.clear()
            stateLabel.text = message
            stateLabel.isHidden = false
        case let .error(message):
            collectionViewDataSource.clear()
            stateLabel.text = message
            stateLabel.isHidden = false
            retryButton.isHidden = false
        }
    }

    func showPurchaseError(message: String) {
        showError(message: message)
    }

    func showReviewsError(message: String) {
        showError(message: message)
    }

    private func showError(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Setup
private extension AdvertDetailViewController {
    private func setupSubviews() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        view.addSubview(stateLabel)
        view.addSubview(retryButton)
        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
    }
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { $0.center.equalToSuperview() }
        stateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-24)
            $0.leading.trailing.equalToSuperview().inset(32)
        }
        retryButton.snp.makeConstraints {
            $0.top.equalTo(stateLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
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
            
            switch section.id {
            case .gallery:
                return self?.collectionViewFactory.makeGallerySection(environment: environment) { [weak self] page in
                    guard let self else { return }
                    
                    supplementaryViewUpdater.update(.galleryPage(page), in: collectionView)
                }
            case .title:
                return self?.collectionViewFactory.makeContentSection(estimatedHeight: 92)
            case .characteristics:
                return self?.collectionViewFactory.makeContentSection(estimatedHeight: 72)
            case .buyButton:
                return self?.collectionViewFactory.makeContentSection(estimatedHeight: 52)
            case .reviews:
                return self?.collectionViewFactory.makeContentSection(estimatedHeight: 88)
            case .recommendations:
                return self?.collectionViewFactory.makeRecommendationsSection()
            case .dealer:
                return self?.collectionViewFactory.makeContentSection(estimatedHeight: 80)
            }
        }
    }

    @objc private func retryTapped() {
        presenter.retry()
    }
}

// MARK: - UICollectionViewDelegate
extension AdvertDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = collectionViewDataSource.sectionIdentifier(for: indexPath.section),
              let item = collectionViewDataSource.itemIdentifier(for: indexPath) else {
            return
        }

        switch (section.id, item.content) {
        case (.buyButton, .buyButton):
            presenter.buyButtonTapped()
        case (.reviews, .reviewsLoadMore):
            presenter.reviewsLoadMoreTapped()
        case let (.recommendations, .recommendation(data)):
            presenter.recommendationTapped(advertID: data.advertID)
        default:
            break
        }
    }
}
