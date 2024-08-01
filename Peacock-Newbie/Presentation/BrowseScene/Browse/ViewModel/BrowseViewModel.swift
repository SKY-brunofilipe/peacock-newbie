//
//  BrowseViewModel.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 29/07/2024.
//

import Foundation

protocol BrowseViewModelInput {
    func viewDidLoad()
}

protocol BrowseViewModelOutput {
    var items: Observable<[BrowseItem]> { get }
    var error: Observable<String> { get }
}

typealias BrowseViewModel = BrowseViewModelInput & BrowseViewModelOutput


final class BrowseViewModelImpl: BrowseViewModel {
    private let loadBrowserUseCase: LoadBrowseUseCase
    
    // MARK: - OUTPUT
    let items: Observable<[BrowseItem]> = Observable([])
    let error: Observable<String> = Observable("")
    
    init(loadBrowserUseCase: LoadBrowseUseCase) {
        self.loadBrowserUseCase = loadBrowserUseCase
    }
    
    private func loadRails(rails: [CollectionRail]) {
        items.value = rails.map(BrowseItem.init)
        print(items.value)
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
}

