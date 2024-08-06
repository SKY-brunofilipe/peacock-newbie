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

final class RailsListViewController: UIViewController, UICollectionViewDelegate {
    typealias DataSource = UICollectionViewDiffableDataSource<BrowseItem, TileItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<BrowseItem, TileItem>
    
    static let titleElementKind = "title-element-kind"
    
    private let viewModel: BrowseViewModel
    private var currentSnapshot: Snapshot = Snapshot()
    
    private lazy var dataSource: DataSource = makeDataSource()
    private lazy var collectionView: UICollectionView = makeCollectionView()
    
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
        collectionView.delegate = self
    }
    
    func makeDataSource() -> DataSource {
        let cellRegistration = UICollectionView.CellRegistration
        <TileCell, TileItem> { (cell, indexPath, item) in
            let theme: BrowseItemTheme = BrowseItemTheme(imageUrl: item.imageURL, title: item.title)
            cell.configure(theme: theme)
        }
        
        return DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: TileItem) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }
    
    func makeCollectionView() -> UICollectionView {
        return UICollectionView(frame: .zero, collectionViewLayout: createLayout())
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
                                                  heightDimension: .absolute(200))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 20
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
            
            let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
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
        collectionView.backgroundColor = UIColor(named: "primary-dark")
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureDataSource() {
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<RailTitleSupplementaryView>(elementKind: RailsListViewController.titleElementKind) {
            (supplementaryView, string, indexPath) in
            let rail = self.viewModel.items.value[indexPath.section]
            supplementaryView.labelView.text = rail.title
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }
    }
    
    private func applySnapshot() {
        if self.viewModel.items.value.count > 0 {
            self.viewModel.items.value
                .forEach {
                    let rail = $0
                    currentSnapshot.appendSections([rail])
                    currentSnapshot.appendItems(rail.items ?? [])
                }
            dataSource.apply(currentSnapshot, animatingDifferences: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedItem = dataSource.itemIdentifier(for: indexPath) {
            viewModel.didSelectAsset(at: indexPath.section, at: indexPath.row)
        }
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

