//
//  ListSectionData.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 26.04.2026.
//

import Foundation

nonisolated struct ListSectionData: Sendable, Hashable {
    let id: UUID
    let type: MainSectionType
    let headerTitle: String?
    let items: [Item]

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ListSectionData {
    nonisolated struct Item: Sendable, Hashable {
        let id: UUID
        let content: Content

        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(
                id
            )
        }

        nonisolated enum Content: Sendable {
            case loaderCell(LoaderCellData)
            case horizontalItemCell(ItemCellData)
        }
    }
}
