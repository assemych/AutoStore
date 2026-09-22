//
//  SectionHeaderView.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 13.09.2026.
//

import Foundation
import UIKit
import SnapKit

final class SectionHeaderView: UICollectionReusableView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor.white
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(viewData: SectionHeaderViewData) {
        titleLabel.text = viewData.title
    }
    
    private func setupSubviews() {
        addSubview(titleLabel)
        addSubview(actionButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.top.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        actionButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }
}
