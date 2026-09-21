//
//  AdvertDetailTextCellData.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 21.09.2026.
//

import Foundation

nonisolated struct AdvertDetailTextCellData: Sendable {
    nonisolated enum Style: Sendable, Hashable {
        case title
        case characteristic
        case review
        case recommendation
        case dealer
    }

    let title: String
    let subtitle: String?
    let style: Style

}
