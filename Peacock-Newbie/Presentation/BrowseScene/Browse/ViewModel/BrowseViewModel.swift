//
//  BrowseViewModel.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 29/07/2024.
//

import Foundation

struct BrowseViewModelActions {
    let showPDP: (Asset) -> Void
}

protocol BrowseViewModelInput {
    func viewDidLoad()
    func didSelectAsset(at sectionIndex: Int, at railIndex: Int)
}

protocol BrowseViewModelOutput {
    var items: Observable<[BrowseItem]> { get }
    var error: Observable<String> { get }
}

typealias BrowseViewModel = BrowseViewModelInput & BrowseViewModelOutput


final class BrowseViewModelImpl: BrowseViewModel {
    private let loadBrowserUseCase: LoadBrowseUseCase
    private let actions: BrowseViewModelActions
    
    private var rails: [CollectionRail] = []
    
    // MARK: - OUTPUT
    let items: Observable<[BrowseItem]> = Observable([])
    let error: Observable<String> = Observable("")
    
    init(loadBrowserUseCase: LoadBrowseUseCase, actions: BrowseViewModelActions) {
        self.loadBrowserUseCase = loadBrowserUseCase
        self.actions = actions
    }
    
    private func loadRails(rails: [CollectionRail]) {
        items.value = rails.map(BrowseItem.init)
        self.rails = rails
    }
    
    private func handle(error: Error) {
        self.error.value = NSLocalizedString("Failed loading browse rails", comment: "")
    }
    
    private func load() {
        loadBrowserUseCase.execute() { result in
            switch result {
                case .success(let section):
                        self.loadRails(rails: section.rails)
                case .failure(let error):
                    self.handle(error: error)
            }
        }
    }
}

extension BrowseViewModelImpl {
    func viewDidLoad() { 
        load()
    }
    
    func didSelectAsset(at sectionIndex: Int, at railIndex: Int) {
        guard let asset = rails[sectionIndex].items?[railIndex] else {
            return
        }
        actions.showPDP(asset)
    }
}

