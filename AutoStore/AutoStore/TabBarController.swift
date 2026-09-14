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
