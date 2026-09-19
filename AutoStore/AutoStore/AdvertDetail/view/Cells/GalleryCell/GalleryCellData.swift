//
//  GalleryCellData.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 15.09.2026.
//

import Foundation

struct GalleryCellData: Hashable {
    let uuid: UUID
    let imageURL: URL
    
    // MARK: - Initializer
    init(
        uuid: UUID = UUID(),
        imageURL: URL
    ) {
        self.uuid = uuid
        self.imageURL = imageURL
    }
    
    // MARK: - Hashable
    static func == (lhs: GalleryCellData, rhs: GalleryCellData) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
