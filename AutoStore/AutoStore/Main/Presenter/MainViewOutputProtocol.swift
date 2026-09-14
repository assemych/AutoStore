//
//  MainViewOutputProtocol.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 06.09.2026.
//

import Foundation

protocol MainViewOutputProtocol: AnyObject {
    var view: MainListViewInputProtocol? { get set }

    func viewDidLoad()
    func loadMoreIfNeeded(with item: ListSectionData.Item)
}

protocol MainListViewInputProtocol: AnyObject {
    func reloadData(with viewData: MainViewData)
}
