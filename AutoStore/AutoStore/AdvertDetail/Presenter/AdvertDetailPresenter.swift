//
//  AdvertDetailPresenter.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 18.09.2026.
//

import Foundation

@MainActor
protocol AdvertDetailOutputProtocol: AnyObject {
    var view: AdvertDetailViewInputProtocol? { get set }

    func viewDidLoad()
}

@MainActor
final class AdvertDetailPresenter: AdvertDetailOutputProtocol {
    weak var view: AdvertDetailViewInputProtocol?
    private let advertID: Int
    private let advertService: AdvertServiceProtocol

    init(
        advertID: Int,
        advertService: AdvertServiceProtocol
    ) {
        self.advertID = advertID
        self.advertService = advertService
    }

    func viewDidLoad() {
        Task {
            do {
                let advert = try await advertService.fetchAdvert(id: advertID)
                let galeryItems = advert.imageURLs.map { AdvertDetailSection.ItemType.galery(.init(imageURL: $0)) }
                let viewData = AdvertDetailViewData(
                    sections: [.init(
                        type: .galery,
                        footerType: .gallery(.init(numberOfPages: advert.imageURLs.count, currentPage: 0)),
                        items: galeryItems
                    )]
                )

                view?.update(with: viewData)
            } catch {
//                view?.showError()
            }
        }
    }
}
