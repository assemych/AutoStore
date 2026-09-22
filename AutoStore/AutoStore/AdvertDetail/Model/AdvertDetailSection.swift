//
//  AdvertDetailSection.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 14.09.2026.
//

import Foundation

nonisolated struct AdvertDetailSection: Sendable, Hashable {
    let id: ID
    let footer: Footer?
    let items: [AdvertDetailItem]

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    nonisolated enum ID: Sendable, Hashable {
        case gallery
        case title
        case characteristics
        case buyButton
        case reviews
        case recommendations
        case dealer
    }

    nonisolated enum Footer: Sendable {
        case gallery(GalleryPageControlViewData)
    }
}
