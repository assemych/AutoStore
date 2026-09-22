import UIKit
import SnapKit

final class RecommendationCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    private let titleLabel = UILabel()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        return label
    }()
    private lazy var stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, priceLabel])
    private var imageTask: Task<Void, Never>?

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 12
        stackView.axis = .vertical
        stackView.spacing = 6
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 2
        priceLabel.font = .preferredFont(forTextStyle: .subheadline)
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        imageView.snp.makeConstraints {
            $0.height.equalTo(100)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageTask?.cancel()
        imageTask = nil
        imageView.image = nil
    }

    func configure(with data: RecommendationCellData) {
        titleLabel.text = data.title
        priceLabel.text = data.price
        imageView.image = UIImage(systemName: "car.fill")

        guard let imageURL = data.imageURL else { return }
        imageTask?.cancel()
        imageTask = Task { [weak self] in
            guard let (imageData, _) = try? await URLSession.shared.data(from: imageURL),
                  !Task.isCancelled,
                  let image = UIImage(data: imageData) else {
                return
            }
            self?.imageView.image = image
        }
    }
}
