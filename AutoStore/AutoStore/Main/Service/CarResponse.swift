//
//  CarResponse.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 06.09.2026.
//

import Foundation

struct CarResponse: Codable, Sendable {
    let id: Int
    let name: String
    let imageUrl: String
}
