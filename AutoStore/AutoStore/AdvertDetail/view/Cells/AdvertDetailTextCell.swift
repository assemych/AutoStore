//
//  GalleryPageControlView.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 15.09.2026.
//

import UIKit
import SnapKit

final class AdvertDetailTextCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private lazy var stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])

    override init(frame: CGRect) {
        super.init(frame: frame)

        stackView.axis = .vertical
        stackView.spacing = 4
        titleLabel.numberOfLines = 0
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = .secondaryLabel
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 12
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { $0.edges.equalToSuperview().inset(16) }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    func configure(with data: AdvertDetailTextCellData) {
        titleLabel.text = data.title
        subtitleLabel.text = data.subtitle
        subtitleLabel.isHidden = data.subtitle == nil

        switch data.style {
        case .title:
            titleLabel.font = .preferredFont(forTextStyle: .title2)
            titleLabel.textColor = .label
        case .characteristic:
            titleLabel.font = .preferredFont(forTextStyle: .headline)
            titleLabel.textColor = .label
        case .rating:
            titleLabel.font = .preferredFont(forTextStyle: .title2)
            titleLabel.textColor = .label
        case .review, .recommendation, .dealer:
            titleLabel.font = .preferredFont(forTextStyle: .headline)
            titleLabel.textColor = .label
        }
    }
}
