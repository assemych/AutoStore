import Foundation

@MainActor
protocol AdvertDetailOutputProtocol: AnyObject {
    var view: AdvertDetailViewInputProtocol? { get set }

    func viewDidLoad()
    func retry()
    func viewDidDisappear()
}

@MainActor
final class AdvertDetailPresenter: AdvertDetailOutputProtocol {
    weak var view: AdvertDetailViewInputProtocol?

    private let advertID: Int
    private let repository: AdvertRepositoryProtocol
    private let viewDataFactory: AdvertDetailViewDataFactoryProtocol
    private var loadTask: Task<Void, Never>?

    init(
        advertID: Int,
        repository: AdvertRepositoryProtocol,
        viewDataFactory: AdvertDetailViewDataFactoryProtocol
    ) {
        self.advertID = advertID
        self.repository = repository
        self.viewDataFactory = viewDataFactory
    }

    func viewDidLoad() {
        loadAdvert()
    }

    func retry() {
        loadAdvert()
    }

    func viewDidDisappear() {
        loadTask?.cancel()
        loadTask = nil
    }

    private func loadAdvert() {
        loadTask?.cancel()
        view?.render(state: .loading)

        loadTask = Task { [weak self] in
            guard let self else { return }

            do {
                let advert = try await repository.fetchAdvert(id: advertID)
                try Task.checkCancellation()
                let viewData = viewDataFactory.makeViewData(from: advert)
                view?.render(state: .content(viewData))
            } catch is CancellationError {
                return
            } catch {
                view?.render(state: .error(message: "Не удалось загрузить объявление"))
            }
        }
    }
}
