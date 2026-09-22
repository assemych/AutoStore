import Foundation

struct PaymentModel: Sendable {
    let id: String
    let amount: Decimal
    let type: String
}
