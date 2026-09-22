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

@MainActor
final class MainPresenter: MainViewOutputProtocol {
    weak var view: MainListViewInputProtocol?
    var output: MainPresenterOutput?

    private let service: CarServiceProtocol
    private let viewDataFactory: MainViewDataFactoryProtocol
    private var loadTask: Task<Void, Never>?

    init(service: CarServiceProtocol, viewDataFactory: MainViewDataFactoryProtocol) {
        self.service = service
        self.viewDataFactory = viewDataFactory
    }

    func viewDidLoad() {
        loadContent()
    }

    func retry() {
        loadContent()
    }

    func viewDidDisappear() {
        loadTask?.cancel()
        loadTask = nil
    }

    func itemTapped(_ item: ListSectionData.Item) {
        guard case let .horizontalItemCell(cellData) = item.content else { return }
        
        output?(.showAdvert(id: cellData.advertID))
    }

    func loadMoreIfNeeded(with item: ListSectionData.Item) {}

    private func loadContent() {
        loadTask?.cancel()
        view?.render(state: .loading)

        loadTask = Task { [weak self] in
            guard let self else { return }

            do {
                let dealers = try await service.fetchDealers()
                try Task.checkCancellation()
                
                let viewData = viewDataFactory.createViewData(with: dealers)
                
                if viewData.sections.isEmpty {
                    view?.render(state: .empty(message: "Автомобили пока не найдены"))
                } else {
                    view?.render(state: .content(viewData))
                }
            } catch is CancellationError {
                return
            } catch {
                view?.render(state: .error(message: "Не удалось загрузить автомобили"))
            }
        }
    }
}
