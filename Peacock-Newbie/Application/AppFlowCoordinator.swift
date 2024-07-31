//
//  AppFlowCoordinator.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 30/07/2024.
//

import Foundation
import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(
        navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let browseSceneDIContainer = appDIContainer.makeBrowseSceneDIContainer()
        let flow = browseSceneDIContainer.makeBrowseFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
