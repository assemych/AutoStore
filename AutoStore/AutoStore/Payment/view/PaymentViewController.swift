import UIKit
import SnapKit

final class PaymentViewController: UIViewController {
    private let viewData: PaymentViewData

    init(viewData: PaymentViewData) {
        self.viewData = viewData
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Платёж"
        view.backgroundColor = .systemBackground

        let stackView = UIStackView(arrangedSubviews: [
            makeLabel(text: "Payment ID: \(viewData.paymentID)"),
            makeLabel(text: "Сумма: \(viewData.amount)"),
            makeLabel(text: "Тип: \(viewData.paymentType)")
        ])
        stackView.axis = .vertical
        stackView.spacing = 12
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }

    private func makeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }
}
