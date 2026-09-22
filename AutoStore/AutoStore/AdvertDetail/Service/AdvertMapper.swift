protocol AdvertMapperProtocol: AnyObject {
    func map(_ response: AdvertResponse) -> AdvertModel
}

final class AdvertMapper: AdvertMapperProtocol {
    func map(_ response: AdvertResponse) -> AdvertModel {
        AdvertModel(
            id: response.id,
            title: "\(response.brand) \(response.model)",
            price: response.price,
            year: response.year,
            mileage: response.mileage,
            transmission: response.transmission,
            dealerName: response.dealerName,
            dealerAddress: response.dealerAddress,
            imageURLs: response.imageURLs
        )
    }
}
