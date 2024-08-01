//
//  RailsListViewController.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 30/07/2024.
//

import Foundation
import UIKit

struct RailSection: Hashable {
    let title: String
    let items: [TileItem]
}

final class RailsListViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<BrowseItem, TileItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<BrowseItem, TileItem>
    
    static let headerElementKind = "header-element-kind"
    static let titleElementKind = "title-element-kind"
    
    private let viewModel: BrowseViewModel
    private var dataSource: DataSource!
    private var currentSnapshot: Snapshot!
    var collectionView: UICollectionView! = nil
    
    
    
    init(viewModel: BrowseViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required internal init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
    }
}

extension RailsListViewController {
    func createLayout() -> UICollectionViewLayout {
        let sectionProvider = {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                 heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupFractionalWidth = CGFloat(layoutEnvironment.container.effectiveContentSize.width > 500 ?
                0.425 : 0.85)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupFractionalWidth),
                                                  heightDimension: .absolute(250))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 20
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
            
            let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0))
            let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: titleSize,
                elementKind: RailsListViewController.titleElementKind,
                alignment: .top
            )
            section.boundarySupplementaryItems = [titleSupplementary]
            
            return section
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
    func configureHierarchy() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration
        <TileCell, TileItem> { (cell, indexPath, item) in
            cell.titleLabel.text = item.title
        }
        
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: TileItem) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<RailTitleSupplementaryView>(elementKind: RailsListViewController.titleElementKind) {
            (supplementaryView, string, indexPath) in
            if let snapshot = self.currentSnapshot {
                let rail =  snapshot.sectionIdentifiers[indexPath.section]
                supplementaryView.label.text = rail.title
            }
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }
    }
    
    private func applySnapshot() {
        self.viewModel.items.value.forEach {
            let rail = $0
            currentSnapshot.appendSections([rail])
            currentSnapshot.appendItems(rail.items ?? [])
        }
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
}

extension RailsListViewController {
    func reload() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.applySnapshot()
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
}

