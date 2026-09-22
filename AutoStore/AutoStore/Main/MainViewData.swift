//
//  MainViewData.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 26.03.2026.
//

import Foundation

nonisolated
enum MainSectionType: Sendable, Hashable {
    case loader
    case horizontalList
}

struct MainViewData: Hashable {
    let sections: [ListSectionData]
}

enum MainViewState {
    case loading
    case content(MainViewData)
    case empty(message: String)
    case error(message: String)
}
