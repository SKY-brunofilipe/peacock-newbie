//
//  Section.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 29/07/2024.
//

import Foundation

struct Section {
    typealias Identifier = String
    let rails: [CollectionRail]
    let id: Identifier
    let title: String
    let type: String
}
