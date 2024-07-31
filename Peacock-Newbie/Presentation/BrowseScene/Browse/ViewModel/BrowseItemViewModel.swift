//
//  BrowseItemViewModel.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 30/07/2024.
//

import Foundation

struct BrowseItemViewModel: Equatable, Hashable {
    let title: String
    let type: RailType
    let id: String
}

extension BrowseItemViewModel {
    init(rail: CollectionRail) {
        self.title = rail.title
        self.type = rail.type
        self.id = rail.id
    }
}
