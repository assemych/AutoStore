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
