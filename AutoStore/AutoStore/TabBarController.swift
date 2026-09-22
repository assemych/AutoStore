//
//  TabBarController.swift
//  AutoStore
//
//  Created by Assem Mukhamadi on 06.09.2026.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

//MARK: - Setup
private extension TabBarController {
    private func setup() {
        let dataSource: [TabBarItem] = [.cars, .dealers]
        
        viewControllers = dataSource.map {
            switch $0 {
                case .cars:
                let presenter = MainPresenter(
                    service: CarService(),
                    viewDataFactory: MainViewDataFactory()
                )
                let vc = MainViewController(presenter: presenter)
                presenter.view = vc
                presenter.output = { [weak self] action in
                    self?.handle(action)
                }
                return UINavigationController(rootViewController: vc)
            case .dealers:
                return UINavigationController(rootViewController: UIViewController())
            }
        }
        
        viewControllers?.enumerated().forEach {
            $1.tabBarItem.title = dataSource[$0].title
            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
            $1.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: .zero, bottom: -5, right: .zero)
        }
    }
    
    private func handle(_ action: MainPresenterOutputAction) {
        switch action {
        case let .showAdvert(id):
            openAdvertDetail(id: id)
        }
    }

    private func openAdvertDetail(id: Int) {
        guard let navigationController = selectedViewController as? UINavigationController else {
            return
        }

        let viewController = AdvertDetailModuleFactory.make(advertID: id) { [weak self] action in
            self?.handle(action)
        }
        navigationController.pushViewController(viewController, animated: true)
    }

    private func handle(_ action: AdvertDetailOutputAction) {
        switch action {
        case let .showPayment(payment):
            openPayment(payment)
        case let .showAdvert(id):
            openAdvertDetail(id: id)
        }
    }

    private func openPayment(_ payment: PaymentModel) {
        guard let navigationController = selectedViewController as? UINavigationController else {
            return
        }

        let viewController = PaymentModuleFactory.make(payment: payment)
        navigationController.pushViewController(viewController, animated: true)
    }
}

private extension TabBarController {
    private enum TabBarItem: Int {
        case cars
        case dealers
        
        var title: String {
            switch self {
            case .cars:
                return "Cars"
            case .dealers:
                return "Dealers"
            }
        }
        
        var iconName: String {
            switch self {
            case .cars:
                return "car"
            case .dealers:
                return "person"
            }
        }
    }
}
