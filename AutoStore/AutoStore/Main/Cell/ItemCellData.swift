//
//  ItemCellData.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 26.03.2026.
//

import Foundation

nonisolated
struct ItemCellData: Hashable {
    let uuid = UUID()
    let id: Int
    let title: String
    let imageUrl: URL?
    
    
    // MARK: - Hashable
    static func == (lhs: ItemCellData, rhs: ItemCellData) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
