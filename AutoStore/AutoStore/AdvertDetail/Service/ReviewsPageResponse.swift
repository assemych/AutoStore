//
//  ReviewsPageResponse.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 22.09.2026.
//

import Foundation

struct ReviewsPageResponse: Sendable {
    let rating: Double
    let totalCount: Int
    let reviews: [Review]
    let page: Int
    let hasNextPage: Bool
}

extension ReviewsPageResponse {
    struct Review: Sendable {
        let id: Int
        let author: String
        let text: String
    }
}
