//
//  BrowseSceneDIContainer.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 30/07/2024.
//

import Foundation
import UIKit

final class BrowseSceneDIContainer: BrowseFlowCoordinatorDependencies {
    // MARK: - Use Cases
    func makeLoadBrowseUseCase() -> LoadBrowseUseCase {
        LoadBrowseUseCaseImpl(
            browseRepository: makeBrowseRepository()
        )
    }
    
    // MARK: - Repositories
    func makeBrowseRepository() -> BrowseRepository {
        BrowseRepositoryImpl()
    }
    
    // MARK: - VIew Controllers
    func makeBrowseViewController(actions: BrowseViewModelActions) -> BrowseViewController {
        BrowseViewController(
            viewModel: makeBrowseViewModel(actions: actions)
        )
    }

    func makePDPViewController(asset: Asset) -> PDPViewController {
        return PDPViewController(
            viewModel: makePDPViewModel(asset: asset)
        )
    }
    
    // MARK: - View Models
    func makeBrowseViewModel(actions: BrowseViewModelActions) -> BrowseViewModel {
        BrowseViewModelImpl(
            loadBrowserUseCase: makeLoadBrowseUseCase(),
            actions: actions
        )
    }
    
    func makePDPViewModel(asset: Asset) -> PDPViewModel {
        PDPViewModelImpl(asset: asset)
    }
    
    // MARK: - Flow Coordinators
    func makeBrowseFlowCoordinator(navigationController: UINavigationController) -> BrowseFlowCoordinator {
        BrowseFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
}
