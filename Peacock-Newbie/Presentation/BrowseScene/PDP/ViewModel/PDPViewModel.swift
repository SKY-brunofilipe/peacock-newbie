//
//  PDPViewModel.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 05/08/2024.
//

import Foundation

protocol PDPViewModel {
    var assetDetails: AssetDetails { get }
}

final class PDPViewModelImpl: PDPViewModel {
    // MARK: - OUTPUT
    let assetDetails: AssetDetails
    
    init(asset: Asset) {
        self.assetDetails = AssetDetails(asset: asset)
    }
}
