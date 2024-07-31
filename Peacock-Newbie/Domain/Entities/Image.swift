//
//  Image.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 29/07/2024.
//

import Foundation

struct Image {
    enum ImageType: String {
        case landscape
        case titleArt169
        case nonTitleArt34
        case titleArt34
        case titleLogo
        case scene34
        case railBackground
        case tile
        case backgroundUnfocus
        case backgroundFocus
        case connectUnfocus
        case connectFocus
        case background
        case icon
        case heroThumbnail = "HERO_THUMBNAIL"
    }

    enum ImageArea: String {
        case heroThumbnail = "HERO_THUMBNAIL"
    }
    
    var type: ImageType
    var url: String
    var area: ImageArea?
}
