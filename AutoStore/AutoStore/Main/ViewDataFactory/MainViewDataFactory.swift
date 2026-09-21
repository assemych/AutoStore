//
//  MainViewDataFactory.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 08.09.2026.
//

import Foundation

final class MainViewDataFactory: MainViewDataFactoryProtocol {
    func createViewData(with fechedDealers: [DealerResponse]) -> MainViewData {
        let sections = fechedDealers.map { dealer in
            ListSectionData(
                id: UUID(),
                type: .horizontalList,
                headerTitle: dealer.name,
                items: dealer.cars.map { car in
                    .init(
                        id: UUID(),
                        content: .horizontalItemCell(.init(
                            advertID: car.id,
                            title: car.name,
                            imageUrl: URL(string: car.imageUrl)
                        ))
                    )
                }
            )
        }

        return MainViewData(sections: sections)
    }
}
