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
    
    // MARK: - Views
    func makeBrowseViewController() -> BrowseViewController {
        BrowseViewController(
            viewModel: makeBrowseViewModel()
        )
    }
    
    // MARK: - View Models
    func makeBrowseViewModel() -> BrowseViewModel {
        BrowseViewModelImpl(
            loadBrowserUseCase: makeLoadBrowseUseCase()
        )
    }
    
    // MARK: - Flow Coordinators
    func makeBrowseFlowCoordinator(navigationController: UINavigationController) -> BrowseFlowCoordinator {
        BrowseFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
}
