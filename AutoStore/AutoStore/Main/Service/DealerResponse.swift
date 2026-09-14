//
//  DealerResponse.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 06.09.2026.
//

import Foundation

struct DealerResponse: Codable {
    let id: Int
    let name: String
    let cars: [CarResponse]
}
