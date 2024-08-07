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

#Preview {
    let asset = Asset(
        type: "ASSET/PROGRAMME",
        id: "id",
        title: "Book Club: The Next Chapter",
        images: [
            Image(
                type: Image.ImageType.landscape,
                url: "https://imageservice.disco.peacocktv.com/uuid/43c0674d-2d60-3b29-b994-2ec02bbe8238/LAND_16_9?language=eng&territory=US&proposition=NBCUOTT&version=f5fd6f1f-d430-3b1b-9142-f03f43c03b05"
            ),
            Image(
                type: Image.ImageType.titleLogo,
                url:  "https://imageservice.disco.peacocktv.com/uuid/43c0674d-2d60-3b29-b994-2ec02bbe8238/TITLE_TREATMENT?language=eng&territory=US&proposition=NBCUOTT&version=f968ae54-722a-3414-bae7-7a13a74c19bf"
            )
        ],
        synopsisLong: "Four women take their book club to Italy for the fun girls' trip they never had. When things go off the rails and secrets are revealed, their relaxing vacation turns into a once-in-a-lifetime, cross-country adventure."
    )
    let viewModel = PDPViewModelImpl(asset: asset)
    let viewController = PDPViewController(viewModel: viewModel)
    return viewController
}
    
