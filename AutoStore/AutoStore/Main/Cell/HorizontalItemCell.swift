//
//  HorizontalItemCell.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 09.08.2026.
//

import UIKit
import Kingfisher
import SnapKit

final class HorizontalItemCell: UICollectionViewCell {
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .preferredFont(forTextStyle: .headline)

        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        
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
    
    func configure(with cellData: ItemCellData) {
        label.text = cellData.title
        
        guard let url = cellData.imageUrl else {
            imageView.image = nil
            return
        }
        
        let size = CGSize(width: 204 * traitCollection.displayScale, height: 122 * traitCollection.displayScale)
        
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "photo"),
            options: [
                .processor(DownsamplingImageProcessor(size: size)),
                .scaleFactor(traitCollection.displayScale),
                .transition(.fade(0.2))
            ]
        )
    }
}

private extension HorizontalItemCell {
    func setupSubviews() {
        containerView.addSubview(imageView)
        containerView.addSubview(label)
        contentView.addSubview(containerView)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(122)
            make.width.equalTo(204)
        }
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.trailing.leading.bottom.equalToSuperview()
        }
    }
}
