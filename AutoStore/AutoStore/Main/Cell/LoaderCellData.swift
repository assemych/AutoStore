//
//  LoaderCellData.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 17.05.2026.
//

import Foundation

struct LoaderCellData: Hashable  {
    let uuid = UUID()
    let title: String
    let subtitle: String
    
    // MARK: - Hashable
    static func == (lhs: LoaderCellData, rhs: LoaderCellData) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
