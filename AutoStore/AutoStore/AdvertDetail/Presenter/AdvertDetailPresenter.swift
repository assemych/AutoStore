import Foundation

typealias AdvertDetailOutput = (AdvertDetailOutputAction) -> Void

@MainActor
protocol AdvertDetailOutputProtocol: AnyObject {
    var view: AdvertDetailViewInputProtocol? { get set }

    func viewDidLoad()
    func retry()
    func viewDidDisappear()
    func buyButtonTapped()
}

@MainActor
final class AdvertDetailPresenter: AdvertDetailOutputProtocol {
    weak var view: AdvertDetailViewInputProtocol?
    var output: AdvertDetailOutput?

    private let advertID: Int
    private let repository: AdvertRepositoryProtocol
    private let paymentRepository: PaymentRepositoryProtocol
    private let viewDataFactory: AdvertDetailViewDataFactoryProtocol
    private var loadTask: Task<Void, Never>?
    private var paymentTask: Task<Void, Never>?
    private var viewData: AdvertDetailViewData?

    init(
        advertID: Int,
        repository: AdvertRepositoryProtocol,
        paymentRepository: PaymentRepositoryProtocol,
        viewDataFactory: AdvertDetailViewDataFactoryProtocol
    ) {
        self.advertID = advertID
        self.repository = repository
        self.paymentRepository = paymentRepository
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
        paymentTask?.cancel()
        paymentTask = nil
    }

    func buyButtonTapped() {
        guard paymentTask == nil else { return }

        updatePaymentState(isLoading: true)
        paymentTask = Task { [weak self] in
            guard let self else { return }
            defer {
                paymentTask = nil
                updatePaymentState(isLoading: false)
            }

            do {
                let payment = try await paymentRepository.preparePayment(advertId: advertID)
                try Task.checkCancellation()
                output?(.showPayment(payment))
            } catch is CancellationError {
                return
            } catch {
                view?.showPurchaseError(message: "Не удалось подготовить платёж")
            }
        }
    }

    private func loadAdvert() {
        loadTask?.cancel()
        view?.render(state: .loading)

        loadTask = Task { [weak self] in
            guard let self else { return }

            do {
                let advertModel = try await repository.fetchAdvert(id: advertID)
                try Task.checkCancellation()
                let viewData = viewDataFactory.makeViewData(from: advertModel)
                self.viewData = viewData
                view?.render(state: .content(viewData))
            } catch is CancellationError {
                return
            } catch {
                view?.render(state: .error(message: "Не удалось загрузить объявление"))
            }
        }
    }

    private func updatePaymentState(isLoading: Bool) {
        guard let viewData else { return }

        let updatedViewData = viewDataFactory.updatingPaymentState(
            in: viewData,
            isLoading: isLoading
        )
        self.viewData = updatedViewData
        view?.render(state: .content(updatedViewData))
    }
}
