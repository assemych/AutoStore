//
//  GalleryPageControlView.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 15.09.2026.
//

import Foundation
import UIKit
import SnapKit

final class GalleryPageControlView: UICollectionReusableView {
    private let pageControl: UIPageControl = {
            let pageControl = UIPageControl()
            pageControl.isUserInteractionEnabled = false
            pageControl.currentPageIndicatorTintColor = .black
            pageControl.pageIndicatorTintColor = .lightGray
            return pageControl
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configure(with viewData: GalleryPageControlViewData) {
        pageControl.numberOfPages = viewData.numberOfPages
        pageControl.currentPage = min(
            max(viewData.currentPage, 0),
            max(viewData.numberOfPages - 1, 0)
        )
        pageControl.isHidden = viewData.numberOfPages <= 1
    }
    
    func setCurrentPage(_ page: Int) {
        guard (0..<pageControl.numberOfPages).contains(page) else {
            return
        }

        guard pageControl.currentPage != page else {
            return
        }

        pageControl.currentPage = page
    }
}

private extension GalleryPageControlView {
    private func setupSubview() {
        addSubview(pageControl)
    }
    
    private func setupConstraints() {
        pageControl.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
