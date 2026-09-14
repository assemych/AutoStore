//
//  LoaderCell.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 17.05.2026.
//

import UIKit
import SnapKit

final class LoaderCell: UICollectionViewCell {
    private let loaderView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
        
        return activityIndicator
    }()
    private let title: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    private let subtitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with cellData: LoaderCellData) {
        title.text = cellData.title
        subtitle.text = cellData.subtitle
    }
}

// MARK: - Setup
private extension LoaderCell {
    private func setupSubviews() {
        [loaderView, title, subtitle].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        loaderView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        title.snp.makeConstraints { make in
            make.top.equalTo(loaderView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        subtitle.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
