//
//  AdvertDetailItem.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 21.09.2026.
//

import Foundation

nonisolated struct AdvertDetailItem: Sendable, Hashable {
    let id: UUID
    let content: Content

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    nonisolated enum Content: Sendable, Equatable {
        case gallery(GalleryCellData)
        case text(AdvertDetailTextCellData)
        case buyButton(AdvertDetailButtonCellData)
        case reviewsLoadMore(AdvertDetailButtonCellData)
    }
}
