//
//  AdvertService.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 18.09.2026.
//

import Foundation

protocol AdvertServiceProtocol: AnyObject {
    func fetchAdvert(id: Int) async throws -> AdvertResponse
}

final class AdvertService: AdvertServiceProtocol {
    var result: Result<AdvertResponse, Error> = .success(.mock)
    
    func fetchAdvert(id: Int) async throws -> AdvertResponse {
        try await Task.sleep(for: .milliseconds(500))
        
        return try result.get()
    }
}
