//
//  AppDIContainer.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 30/07/2024.
//

import Foundation

final class AppDIContainer {
    func makeBrowseSceneDIContainer() -> BrowseSceneDIContainer {
        return BrowseSceneDIContainer()
    }
}
