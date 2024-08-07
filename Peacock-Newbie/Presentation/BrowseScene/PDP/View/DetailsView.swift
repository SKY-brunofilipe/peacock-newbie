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
    
    let stackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 10
        view.backgroundColor = UIColor(named: "primary-dark")
        return view
    }()
    
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
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let titleArtView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let emptyView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let titleArtStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .center
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
        titleView.text = viewModel.assetDetails.title
        imageView.kf.setImage(with: URL(string: viewModel.assetDetails.backgroundImage))
        titleArtView.kf.setImage(with: URL(string: viewModel.assetDetails.titleArtImage))
        descriptionView.text = viewModel.assetDetails.synopsisLong ?? ""
        
        stackView.addArrangedSubview(imageView)
        
        titleArtStackView.addArrangedSubview(titleArtView)
        titleArtStackView.addArrangedSubview(emptyView)
        stackView.addArrangedSubview(titleArtStackView)
        
        if viewModel.assetDetails.titleArtImage == "" {
            stackView.addArrangedSubview(titleView)
        }
        stackView.addArrangedSubview(descriptionView)
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: self.topAnchor),
                stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                
                titleArtStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
                titleArtStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
                titleArtStackView.heightAnchor.constraint(equalToConstant: 100),
                
                imageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1/3)
       ])
    }
}
