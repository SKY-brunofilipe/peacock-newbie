//
//  BrowseRepositoryImpl.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 29/07/2024.
//

import Foundation
import Combine


final class BrowseRepositoryImpl: BrowseRepository {
    func fetch(completion: @escaping (Result<Section, Error>) -> Void) -> Void {
        API.getHomeSection() { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.toDomain().data.group))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
