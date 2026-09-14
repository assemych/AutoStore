//
//  ListSectionData.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 26.04.2026.
//

nonisolated
struct ListSectionData: Sendable, Hashable {
    let type: MainSectionType
    let headerTitle: String?
    let items: [Item]
}

extension ListSectionData {
    nonisolated
    enum Item: Hashable {
        case loaderCell(LoaderCellData)
        case horizontalItemCell(ItemCellData)
    }
}
