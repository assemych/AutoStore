import Foundation

struct PaymentDataResponse: Sendable {
    let amount: Decimal
    let paymentType: String
}

protocol PaymentDataServiceProtocol: AnyObject {
    func fetchPaymentData(paymentID: String) async throws -> PaymentDataResponse
}

final class PaymentDataService: PaymentDataServiceProtocol {
    func fetchPaymentData(paymentID: String) async throws -> PaymentDataResponse {
        try await Task.sleep(for: .milliseconds(400))
        
        return PaymentDataResponse(amount: 18_900_000, paymentType: "Покупка автомобиля")
    }
}
