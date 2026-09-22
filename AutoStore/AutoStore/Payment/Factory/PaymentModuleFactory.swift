import UIKit
import Foundation

@MainActor
enum PaymentModuleFactory {
    static func make(payment: PaymentModel) -> UIViewController {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.maximumFractionDigits = 0

        let amount = formatter.string(from: payment.amount as NSDecimalNumber)
            .map { "\($0) ₸" }
            ?? "\(payment.amount) ₸"

        let viewData = PaymentViewData(
            paymentID: payment.id,
            amount: amount,
            paymentType: payment.type
        )

        return PaymentViewController(viewData: viewData)
    }
}
