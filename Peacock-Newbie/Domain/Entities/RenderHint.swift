//
//  RenderHint.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 29/07/2024.
//

import Foundation

struct RenderHint {
    enum Template {
        case HIGHLIGHT
        case DEFAULT
        case CONTINUE_WATCHING
        case WATCHLIST
        case GRID
        case LIVE
    }
    var orientation: String?
    var template: Template?
    var groupTemplate: String?
    var hideTitle: Bool?
    var hideLogo: Bool?
    var sort: Bool?
}


