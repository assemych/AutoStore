//
//  MainViewDataFactoryProtocol.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 08.09.2026.
//

import Foundation

protocol MainViewDataFactoryProtocol: AnyObject {
    func createViewData(with fechedDealers: [DealerResponse]) -> MainViewData
}
