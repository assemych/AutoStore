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
}

extension MainViewController: MainListViewInputProtocol {
    func render(state: MainViewState) {
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
}

// MARK: - Setup
private extension MainViewController {
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

    @objc private func retryTapped() {
        presenter.retry()
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = collectionViewDataSource.section(at: indexPath.section) else { return }
        
        switch section.type {
        case .loader:
            return
        case .horizontalList:
            let item = section.items[indexPath.item]
            presenter.itemTapped(item)
        }
    }
}
