import Foundation

protocol AdvertDetailViewDataFactoryProtocol: AnyObject {
    func makeViewData(
        from advert: AdvertModel,
        reviewsPage: ReviewsPageModel,
        recommendations: [RecommendationModel]
    ) -> AdvertDetailViewData
    func updatingPaymentState(in viewData: AdvertDetailViewData, isLoading: Bool) -> AdvertDetailViewData
    func updatingReviewsLoading(in viewData: AdvertDetailViewData, isLoading: Bool) -> AdvertDetailViewData
    func appendingReviews(to viewData: AdvertDetailViewData, page: ReviewsPageModel) -> AdvertDetailViewData
}

final class AdvertDetailViewDataFactory: AdvertDetailViewDataFactoryProtocol {
    func makeViewData(
        from advert: AdvertModel,
        reviewsPage: ReviewsPageModel,
        recommendations: [RecommendationModel]
    ) -> AdvertDetailViewData {
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

        sections.append(makeReviewsSection(from: reviewsPage))

        if !recommendations.isEmpty {
            sections.append(.init(
                id: .recommendations,
                footer: nil,
                items: recommendations.map { recommendation in
                    item(content: .recommendation(.init(
                        advertID: recommendation.advertID,
                        title: recommendation.title,
                        price: recommendation.price,
                        imageURL: recommendation.imageURL
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

    func updatingReviewsLoading(
        in viewData: AdvertDetailViewData,
        isLoading: Bool
    ) -> AdvertDetailViewData {
        let sections = viewData.sections.map { section in
            guard section.id == .reviews else { return section }

            let items = section.items.map { item in
                guard case .reviewsLoadMore = item.content else { return item }

                return AdvertDetailItem(
                    id: item.id,
                    content: .reviewsLoadMore(.init(
                        title: isLoading ? "Загрузка…" : "Показать ещё",
                        isLoading: isLoading
                    ))
                )
            }

            return AdvertDetailSection(id: section.id, footer: section.footer, items: items)
        }

        return AdvertDetailViewData(sections: sections)
    }

    func appendingReviews(
        to viewData: AdvertDetailViewData,
        page: ReviewsPageModel
    ) -> AdvertDetailViewData {
        let sections = viewData.sections.map { section in
            guard section.id == .reviews else { return section }

            let loadMoreItem = section.items.first { item in
                if case .reviewsLoadMore = item.content { return true }
                return false
            }
            var items = section.items.filter { item in
                if case .reviewsLoadMore = item.content { return false }
                return true
            }
            items.append(contentsOf: makeReviewItems(page.reviews))

            if page.hasNextPage {
                items.append(AdvertDetailItem(
                    id: loadMoreItem?.id ?? UUID(),
                    content: .reviewsLoadMore(.init(title: "Показать ещё", isLoading: false))
                ))
            }

            return AdvertDetailSection(id: section.id, footer: section.footer, items: items)
        }

        return AdvertDetailViewData(sections: sections)
    }

    private func makeReviewsSection(from page: ReviewsPageModel) -> AdvertDetailSection {
        var items = [item(content: .text(.init(
            title: String(format: "Рейтинг %.1f ★", page.rating),
            subtitle: "Отзывов: \(page.totalCount)",
            style: .rating
        )))]
        items.append(contentsOf: makeReviewItems(page.reviews))

        if page.hasNextPage {
            items.append(item(content: .reviewsLoadMore(.init(
                title: "Показать ещё",
                isLoading: false
            ))))
        }

        return AdvertDetailSection(id: .reviews, footer: nil, items: items)
    }

    private func makeReviewItems(_ reviews: [ReviewsPageModel.ReviewModel]) -> [AdvertDetailItem] {
        reviews.map { review in
            item(content: .text(.init(
                title: review.author,
                subtitle: review.text,
                style: .review
            )))
        }
    }

    private func item(content: AdvertDetailItem.Content) -> AdvertDetailItem {
        AdvertDetailItem(id: UUID(), content: content)
    }
}
