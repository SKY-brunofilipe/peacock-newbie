//
//  DetailsView.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 05/08/2024.
//

import Foundation
import UIKit

final class DetailsView: UIView {
    private let viewModel: PDPViewModel
    
    let titleView = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.adjustsFontForContentSizeCategory = true
        view.textColor = UIColor(named: "white")
        return view
    }()
    
    let imageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    let titleArtView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let descriptionView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 16)
        view.isScrollEnabled = false
        view.textColor = UIColor(named: "white")
        view.backgroundColor = .clear
        return view
    }()
    
    
    init(viewModel: PDPViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    required internal init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(imageView)
        self.addSubview(titleArtView)
        self.addSubview(titleView)
        self.addSubview(descriptionView)
        
        titleView.text = viewModel.assetDetails.title
        imageView.kf.setImage(with: URL(string: viewModel.assetDetails.backgroundImage))
        titleArtView.kf.setImage(with: URL(string: viewModel.assetDetails.titleArtImage))
        descriptionView.text = viewModel.assetDetails.synopsisLong ?? ""

        
        let spacing = CGFloat(16)
        NSLayoutConstraint.activate([
               // ImageView constraints
               imageView.topAnchor.constraint(equalTo: self.topAnchor),
               imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
               imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
               imageView.heightAnchor.constraint(equalToConstant: 200),
               
               //TitleArtView constraints
               titleArtView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing),
               titleArtView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
               titleArtView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
               titleArtView.heightAnchor.constraint(equalToConstant: 80),
               
               // TitleView constraints
               titleView.topAnchor.constraint(equalTo: titleArtView.bottomAnchor, constant: spacing),
               titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacing),
               titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacing),
               
               // DescriptionView constraints
               descriptionView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: spacing),
               descriptionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacing),
               descriptionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacing),
               descriptionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -spacing)
       ])
    }
}
