import Foundation

protocol AdvertDetailViewDataFactoryProtocol: AnyObject {
    func makeViewData(from advert: AdvertModel) -> AdvertDetailViewData
    func updatingPaymentState(
        in viewData: AdvertDetailViewData,
        isLoading: Bool
    ) -> AdvertDetailViewData
}

final class AdvertDetailViewDataFactory: AdvertDetailViewDataFactoryProtocol {
    func makeViewData(from advert: AdvertModel) -> AdvertDetailViewData {
        var sections: [AdvertDetailSection] = []

        if !advert.imageURLs.isEmpty {
            let items = advert.imageURLs.map { item(content: .gallery(.init(imageURL: $0))) }
            sections.append(.init(
                id: .gallery,
                footer: .gallery(.init(numberOfPages: items.count, currentPage: 0)),
                items: items
            ))
        }

        sections.append(.init(
            id: .title,
            footer: nil,
            items: [item(content: .text(.init(
                title: advert.title,
                subtitle: advert.price,
                style: .title
            )))]
        ))

        let characteristics: [(String, String)] = [
            ("Год выпуска", String(advert.year)),
            ("Пробег", advert.mileage),
            ("Коробка передач", advert.transmission)
        ]
        sections.append(.init(
            id: .characteristics,
            footer: nil,
            items: characteristics.map { title, value in
                item(content: .text(.init(title: title, subtitle: value, style: .characteristic)))
            }
        ))

        sections.append(.init(
            id: .buyButton,
            footer: nil,
            items: [item(content: .buyButton(.init(
                title: "Связаться с продавцом",
                isLoading: false
            )))]
        ))

        if !advert.reviews.isEmpty {
            sections.append(.init(
                id: .reviews,
                footer: nil,
                items: advert.reviews.map { review in
                    item(content: .text(.init(
                        title: review.author,
                        subtitle: review.text,
                        style: .review
                    )))
                }
            ))
        }

        if !advert.recommendations.isEmpty {
            sections.append(.init(
                id: .recommendations,
                footer: nil,
                items: advert.recommendations.map { recommendation in
                    item(content: .text(.init(
                        title: recommendation.title,
                        subtitle: recommendation.price,
                        style: .recommendation
                    )))
                }
            ))
        }

        sections.append(.init(
            id: .dealer,
            footer: nil,
            items: [item(content: .text(.init(
                title: advert.dealerName,
                subtitle: advert.dealerAddress,
                style: .dealer
            )))]
        ))

        return AdvertDetailViewData(sections: sections)
    }

    func updatingPaymentState(
        in viewData: AdvertDetailViewData,
        isLoading: Bool
    ) -> AdvertDetailViewData {
        let sections = viewData.sections.map { section in
            guard section.id == .buyButton else { return section }

            let items = section.items.map { item in
                guard case .buyButton = item.content else { return item }

                return AdvertDetailItem(
                    id: item.id,
                    content: .buyButton(.init(
                        title: isLoading ? "Подготовка платежа…" : "Связаться с продавцом",
                        isLoading: isLoading
                    ))
                )
            }

            return AdvertDetailSection(id: section.id, footer: section.footer, items: items)
        }

        return AdvertDetailViewData(sections: sections)
    }

    private func item(content: AdvertDetailItem.Content) -> AdvertDetailItem {
        AdvertDetailItem(id: UUID(), content: content)
    }
}
