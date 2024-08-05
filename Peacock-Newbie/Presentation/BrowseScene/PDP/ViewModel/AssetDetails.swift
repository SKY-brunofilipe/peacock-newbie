//
//  AssetDetails.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 05/08/2024.
//

import Foundation

struct AssetDetails {
    let title: String
    let backgroundImage: String
    let titleArtImage: String
    let synopsisLong: String?
    
    init(asset: Asset) {
        self.title = asset.title
        if let titleLandscape = asset.images.first(where: {$0.type == Image.ImageType.landscape}) {
            self.backgroundImage = titleLandscape.url
        } else {
            self.backgroundImage = ""
        }
        if let titleArt = asset.images.first(where: {$0.type == Image.ImageType.titleLogo}) {
            self.titleArtImage = titleArt.url
        } else {
            self.titleArtImage = ""
        }
        self.synopsisLong = asset.synopsisLong
    }
}
