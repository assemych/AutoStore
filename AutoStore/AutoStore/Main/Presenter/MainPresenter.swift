//
//  MainPresenter.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 06.09.2026.
//

import Foundation

enum MainPresenterOutputAction {
    case showAdvert(id: Int)
}

typealias MainPresenterOutput = (MainPresenterOutputAction) -> Void

final class MainPresenter: MainViewOutputProtocol {
    weak var view: MainListViewInputProtocol?
    var output: MainPresenterOutput?
    
    private var viewData = MainViewData(sections: [])
    
    private let service: CarServiceProtocol
    private let viewDataFactory: MainViewDataFactoryProtocol
    
    init(service: CarServiceProtocol, viewDataFactory: MainViewDataFactoryProtocol) {
        self.service = service
        self.viewDataFactory = viewDataFactory
    }

    func viewDidLoad() {
        Task {
            do {
                let fetchedDealers = try await service.fetchDealers()
                viewData = viewDataFactory.createViewData(with: fetchedDealers)
                
                view?.reloadData(with: viewData)
            } catch {
                // показ ошибки
//                view?.showAlert(title: "Ошибка", message: "Ошибка загрузки: \(error)")
            }
        }
    }
    
    func itemTapped(_ item: ListSectionData.Item) {
        guard case let .horizontalItemCell(cellData) = item else {
            return
        }

        output?(.showAdvert(id: cellData.id))
    }
    
    func loadMoreIfNeeded(with item: ListSectionData.Item) {}
}
