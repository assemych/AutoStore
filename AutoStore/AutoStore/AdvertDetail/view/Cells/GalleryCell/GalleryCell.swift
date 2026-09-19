//
//  GalleryCell.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 15.09.2026.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit

final class GalleryCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
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

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.kf.cancelDownloadTask()
        imageView.image = nil
    }
    
    func configure(with cellData: GalleryCellData) {
        imageView.kf.setImage(
            with: cellData.imageURL,
            placeholder: UIImage(systemName: "car.fill")
        )
    }
}

private extension GalleryCell {
    private func setupSubviews() {
        contentView.addSubview(imageView)
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
