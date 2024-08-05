//
//  CollectionRail.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 29/07/2024.
//

import Foundation

enum RailType: String, CaseIterable {
    case catalogueCollection = "CATALOGUE/COLLECTION"
    case catalogueLink = "CATALOGUE/LINK"
}

struct CollectionRail {
    typealias Identifier = String
    let id: Identifier
    let type: RailType
    let title: String
    let renderHint: RenderHint
    let items: [Asset]?
}
