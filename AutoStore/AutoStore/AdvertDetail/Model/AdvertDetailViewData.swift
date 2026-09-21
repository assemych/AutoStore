//
//  AdvertDetailViewData.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 14.09.2026.
//

struct AdvertDetailViewData {
    let sections: [AdvertDetailSection]
}

enum AdvertDetailViewState {
    case loading
    case content(AdvertDetailViewData)
    case empty(message: String)
    case error(message: String)
}
