//
//  BrowseItemViewModel.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 30/07/2024.
//

import Foundation

struct TileItem: Equatable, Hashable {
    let title: String
}

extension TileItem {
    init(item: Tile) {
        self.title = item.title
    }
}

struct BrowseItem: Equatable, Hashable {
    let title: String
    let type: RailType
    let id: String
    let items: [TileItem]?
}

extension BrowseItem {
    init(rail: CollectionRail) {
        self.title = rail.title
        self.type = rail.type
        self.id = rail.id
        self.items = rail.items?.map(TileItem.init)
    }
}
