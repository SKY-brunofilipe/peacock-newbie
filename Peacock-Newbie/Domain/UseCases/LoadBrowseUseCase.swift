//
//  LoadBrowseUseCase.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 29/07/2024.
//

import Foundation
import Combine

protocol LoadBrowseUseCase {
    func execute(completion: @escaping (Result<Section, Error>) -> Void) -> Void
}

final class LoadBrowseUseCaseImpl: LoadBrowseUseCase {
    private let browseRepository: BrowseRepository
    
    init(browseRepository: BrowseRepository) {
        self.browseRepository = browseRepository
    }
    
    func execute(completion: @escaping (Result<Section, Error>) -> Void) -> Void {
        return browseRepository.fetch() { result in
            completion(result)
        }
    }
}
