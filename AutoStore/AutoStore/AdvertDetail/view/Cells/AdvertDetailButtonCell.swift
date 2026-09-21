//
//  GalleryPageControlView.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 15.09.2026.
//

import UIKit
import SnapKit

nonisolated struct AdvertDetailButtonCellData: Sendable {
    let title: String
}

final class AdvertDetailButtonCell: UICollectionViewCell {
    private let button: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .large
        
        return UIButton(configuration: configuration)
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(button)
        button.isUserInteractionEnabled = false
        
        button.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    func configure(with data: AdvertDetailButtonCellData) {
        button.configuration?.title = data.title
    }
}
