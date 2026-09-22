protocol PaymentRepositoryProtocol: AnyObject {
    func preparePayment(advertId: Int) async throws -> PaymentModel
}

final class PaymentRepository: PaymentRepositoryProtocol {
    private let idGeneratorService: PaymentIDGeneratorServiceProtocol
    private let paymentDataService: PaymentDataServiceProtocol

    init(
        idGeneratorService: PaymentIDGeneratorServiceProtocol,
        paymentDataService: PaymentDataServiceProtocol
    ) {
        self.idGeneratorService = idGeneratorService
        self.paymentDataService = paymentDataService
    }

    func preparePayment(advertId: Int) async throws -> PaymentModel {
        let idResponse = try await idGeneratorService.generatePaymentId(advertId: advertId)
        let dataResponse = try await paymentDataService.fetchPaymentData(paymentID: idResponse.id)
        
        return PaymentModel(id: idResponse.id, amount: dataResponse.amount, type: dataResponse.paymentType)
    }
}
