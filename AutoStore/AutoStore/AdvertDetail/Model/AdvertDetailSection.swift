//
//  AdvertDetailSection.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 14.09.2026.
//

nonisolated
struct AdvertDetailSection: Hashable {
    let type: SectionType
    let footerType: FooterType
    let items: [ItemType]
}

extension AdvertDetailSection {
    nonisolated enum ItemType: Sendable, Hashable {
        case galery(GalleryCellData)
        case title
        case charecteristic
        case buyButton
        case reviews
        case recommendations
        case dealers
    }
}

extension AdvertDetailSection {
    nonisolated enum SectionType: Sendable, Hashable {
        case galery
        case title
        case charecteristic
        case buyButton
        case reviews
        case recommendations
        case dealers
    }
    
    nonisolated enum FooterType: Hashable {
        case gallery(GalleryPageControlViewData)
    }
}
