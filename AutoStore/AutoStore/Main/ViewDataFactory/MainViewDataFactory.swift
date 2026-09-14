//
//  MainViewDataFactory.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 08.09.2026.
//

import Foundation

final class MainViewDataFactory: MainViewDataFactoryProtocol {
    func createViewData(with fechedDealers: [DealerResponse]) -> MainViewData {
        let sections: [ListSectionData] = fechedDealers.map {
            let items = createItems(from: $0.cars)
            return .init(type: .horizontalList, headerTitle: $0.name, items: items)
        }
        
        let viewData = MainViewData(sections: sections)
        
        return viewData
    }
    
    private func createItems(from cars: [CarResponse]) -> [ListSectionData.Item] {
        let items: [ListSectionData.Item] = cars.map {
            .horizontalItemCell(.init(title: $0.name, imageUrl: URL(string: $0.imageUrl)))
        }
        
        return items
    }
}
