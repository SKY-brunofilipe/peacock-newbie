//
//  BrowseFlowCoordinator.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 30/07/2024.
//

import Foundation
import UIKit

protocol BrowseFlowCoordinatorDependencies  {
    func makeBrowseViewController() -> BrowseViewController
}

final class BrowseFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: BrowseFlowCoordinatorDependencies
    
    private weak var browseVC: BrowseViewController?
    
    init(navigationController: UINavigationController, dependencies: BrowseFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let viewController = dependencies.makeBrowseViewController()
        navigationController?.pushViewController(viewController, animated: false)
        browseVC = viewController
    }
}
