//
//  RailsListViewController.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 30/07/2024.
//

import Foundation
import UIKit

final class RailsListViewController: UICollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, BrowseItemViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, BrowseItemViewModel>
    
    private let viewModel: BrowseViewModel
    private var dataSource: DataSource!
    
    init(viewModel: BrowseViewModel) {
        self.viewModel = viewModel
        // Create a layout object
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }

    @available(*, unavailable)
    required internal init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        collectionView.backgroundColor = .white
        
        let cellRegistration = UICollectionView.CellRegistration { (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: BrowseItemViewModel) in
            let rail = self.viewModel.items.value[indexPath.item]
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = rail.title
            contentConfiguration.secondaryText = rail.type.rawValue
            cell.contentConfiguration = contentConfiguration
        }
        
        
        dataSource = UICollectionViewDiffableDataSource<Int, BrowseItemViewModel>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: BrowseItemViewModel) -> UICollectionViewCell? in

            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(self.viewModel.items.value)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    func reload() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.applySnapshot()
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, BrowseItemViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(self.viewModel.items.value)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
