protocol AdvertRepositoryProtocol: AnyObject {
    func fetchAdvert(id: Int) async throws -> AdvertModel
}

final class AdvertRepository: AdvertRepositoryProtocol {
    private let service: AdvertServiceProtocol
    private let mapper: AdvertMapperProtocol

    init(service: AdvertServiceProtocol, mapper: AdvertMapperProtocol) {
        self.service = service
        self.mapper = mapper
    }

    func fetchAdvert(id: Int) async throws -> AdvertModel {
        let response = try await service.fetchAdvert(id: id)
        return mapper.map(response)
    }
}
