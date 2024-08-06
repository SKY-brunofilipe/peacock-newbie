//
//  PDPViewController.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 05/08/2024.
//

import UIKit
import Foundation
import Kingfisher

final class PDPViewController: UIViewController {
    private var viewModel: PDPViewModel
    private lazy var detailsView = DetailsView(
        viewModel: viewModel
    )
   
    init(viewModel: PDPViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required internal init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back-arrow"), for: .normal) // Replace "your_custom_icon" with your image name
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.hidesBackButton = true
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
        
        view.backgroundColor = UIColor(named: "primary-dark")
        view.addSubview(detailsView)
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        
        let spacing = CGFloat(16)
        NSLayoutConstraint.activate([
            detailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: spacing),
            detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailsView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -spacing)
        ])
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

}
    
