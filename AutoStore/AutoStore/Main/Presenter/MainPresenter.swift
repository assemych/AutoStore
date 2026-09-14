//
//  MainPresenter.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 06.09.2026.
//

import Foundation

final class MainPresenter: MainViewOutputProtocol {
    weak var view: MainListViewInputProtocol?
    
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
    
    func loadMoreIfNeeded(with item: ListSectionData.Item) {}
}
