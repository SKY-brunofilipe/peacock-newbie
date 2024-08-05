//
//  TilesListViewCell.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 31/07/2024.
//

import UIKit
import Foundation
import Kingfisher

final class TileCell: UICollectionViewCell {
    let imageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.layer.borderColor = UIColor(named: "primary")?.cgColor
        return view
    }()
    
    let titleLabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 14)
        view.adjustsFontForContentSizeCategory = true
        view.textColor = UIColor(named: "white")
        return view
    }()
    
    static let reuseIdentifier = "tile-cell-reuse-identifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
}

extension TileCell {
    private func setupConstraints() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        let spacing = CGFloat(10)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10)
        ])
    }
}

extension TileCell {
    func configure(theme: BrowseItemTheme) {
        guard let imageUrl = theme.imageUrl else {
            return
        }
        imageView.kf.setImage(with: URL(string: imageUrl))
        imageView.contentMode = .scaleAspectFit
    }
}
