import Foundation

struct PaymentIDResponse: Sendable {
    let id: String
}

protocol PaymentIDGeneratorServiceProtocol: AnyObject {
    func generatePaymentId(advertId: Int) async throws -> PaymentIDResponse
}

final class PaymentIDGeneratorService: PaymentIDGeneratorServiceProtocol {
    func generatePaymentId(advertId: Int) async throws -> PaymentIDResponse {
        try await Task.sleep(for: .milliseconds(400))
        
        return PaymentIDResponse(id: "PAY-\(advertId)-\(UUID().uuidString.prefix(8))")
    }
}
