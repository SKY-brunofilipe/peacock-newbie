//
//  BrowseFlowCoordinator.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 30/07/2024.
//

import Foundation
import UIKit

protocol BrowseFlowCoordinatorDependencies  {
    func makeBrowseViewController(actions: BrowseViewModelActions) -> BrowseViewController
    func makePDPViewController(asset: Asset) -> PDPViewController
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
        let actions = BrowseViewModelActions(showPDP: showPDP)
        let viewController = dependencies.makeBrowseViewController(actions: actions)
        navigationController?.pushViewController(viewController, animated: false)
        browseVC = viewController
    }
    
    private func showPDP(asset: Asset) {
        let viewController = dependencies.makePDPViewController(asset: asset)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
