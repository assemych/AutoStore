import Foundation

typealias AdvertDetailOutput = (AdvertDetailOutputAction) -> Void

@MainActor
protocol AdvertDetailOutputProtocol: AnyObject {
    var view: AdvertDetailViewInputProtocol? { get set }

    func viewDidLoad()
    func retry()
    func viewDidDisappear()
    func buyButtonTapped()
    func reviewsLoadMoreTapped()
}

@MainActor
final class AdvertDetailPresenter: AdvertDetailOutputProtocol {
    weak var view: AdvertDetailViewInputProtocol?
    var output: AdvertDetailOutput?

    private let advertID: Int
    private let repository: AdvertRepositoryProtocol
    private let paymentRepository: PaymentRepositoryProtocol
    private let reviewsRepository: ReviewsRepositoryProtocol
    private let viewDataFactory: AdvertDetailViewDataFactoryProtocol
    private var loadTask: Task<Void, Never>?
    private var paymentTask: Task<Void, Never>?
    private var reviewsTask: Task<Void, Never>?
    private var viewData: AdvertDetailViewData?
    private var currentReviewsPage = 1
    private var hasNextReviewsPage = false

    private let reviewsPageSize = 3

    init(
        advertID: Int,
        repository: AdvertRepositoryProtocol,
        paymentRepository: PaymentRepositoryProtocol,
        reviewsRepository: ReviewsRepositoryProtocol,
        viewDataFactory: AdvertDetailViewDataFactoryProtocol
    ) {
        self.advertID = advertID
        self.repository = repository
        self.paymentRepository = paymentRepository
        self.reviewsRepository = reviewsRepository
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
        reviewsTask?.cancel()
        reviewsTask = nil
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

    func reviewsLoadMoreTapped() {
        guard reviewsTask == nil, hasNextReviewsPage else { return }

        updateReviewsLoading(isLoading: true)
        let nextPage = currentReviewsPage + 1
        
        reviewsTask = Task { [weak self] in
            guard let self else { return }
            defer { reviewsTask = nil }

            do {
                let page = try await reviewsRepository.fetchReviews(
                    advertId: advertID,
                    page: nextPage,
                    pageSize: reviewsPageSize
                )
                try Task.checkCancellation()
                appendReviews(page)
            } catch is CancellationError {
                return
            } catch {
                updateReviewsLoading(isLoading: false)
                view?.showReviewsError(message: "Не удалось загрузить отзывы")
            }
        }
    }

    private func loadAdvert() {
        loadTask?.cancel()
        view?.render(state: .loading)

        loadTask = Task { [weak self] in
            guard let self else { return }

            do {
                async let advertRequest = repository.fetchAdvert(id: advertID)
                async let reviewsRequest = reviewsRepository.fetchReviews(
                    advertId: advertID,
                    page: 1,
                    pageSize: reviewsPageSize
                )
                let (advertModel, reviewsPage) = try await (advertRequest, reviewsRequest)
                try Task.checkCancellation()
                currentReviewsPage = reviewsPage.page
                hasNextReviewsPage = reviewsPage.hasNextPage
                let viewData = viewDataFactory.makeViewData(
                    from: advertModel,
                    reviewsPage: reviewsPage
                )
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

    private func updateReviewsLoading(isLoading: Bool) {
        guard let viewData else { return }

        let updatedViewData = viewDataFactory.updatingReviewsLoading(
            in: viewData,
            isLoading: isLoading
        )
        self.viewData = updatedViewData
        view?.render(state: .content(updatedViewData))
    }

    private func appendReviews(_ page: ReviewsPageModel) {
        guard let viewData else { return }

        currentReviewsPage = page.page
        hasNextReviewsPage = page.hasNextPage
        let updatedViewData = viewDataFactory.appendingReviews(to: viewData, page: page)
        self.viewData = updatedViewData
        
        view?.render(state: .content(updatedViewData))
    }
}
