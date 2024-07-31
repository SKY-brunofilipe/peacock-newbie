//
//  BrowseRepository.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 29/07/2024.
//

import Foundation
import Combine

// Repository Interfaces
protocol BrowseRepository {
    func fetch(completion: @escaping (Result<Section, Error>) -> Void) -> Void
}
