//
//  BrowseViewController.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 29/07/2024.
//
import UIKit

final class BrowseViewController: UIViewController {
    private var viewModel: BrowseViewModel
    private lazy var railsListViewController = RailsListViewController(
        viewModel: viewModel
    )
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
        
        setupViewLayout()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: BrowseViewModel)  {
        viewModel.items.observe(on: self) { [weak self] _ in self?.updateItems() }
    }
    
    private func setupViewLayout() {
        addChild(railsListViewController)
        view.addSubview(railsListViewController.view)
    }
    
    private func updateItems() {
        railsListViewController.reload()
    }
    
}
