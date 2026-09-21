//
//  MainViewOutputProtocol.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 06.09.2026.
//

import Foundation

@MainActor
protocol MainViewOutputProtocol: AnyObject {
    var view: MainListViewInputProtocol? { get set }

    func viewDidLoad()
    func retry()
    func viewDidDisappear()
    func loadMoreIfNeeded(with item: ListSectionData.Item)
    func itemTapped(_ item: ListSectionData.Item)
}

@MainActor
protocol MainListViewInputProtocol: AnyObject {
    func render(state: MainViewState)
}
