//
//  RecommendationCellData.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 22.09.2026.
//

import Foundation

nonisolated struct RecommendationCellData: Sendable, Equatable {
    let advertID: Int
    let title: String
    let price: String
    let imageURL: URL?
}
