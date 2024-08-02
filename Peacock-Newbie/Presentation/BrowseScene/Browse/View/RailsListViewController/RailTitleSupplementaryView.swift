//
//  RailTitleSupplementaryView.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 01/08/2024.
//

import UIKit

class RailTitleSupplementaryView: UICollectionReusableView {
    let labelView = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = UIColor(named: "white")
        return label
    }()
    
    static let reuseIdentifier = "rail-title-supplementary-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
    
    private func setupConstraints() {
        addSubview(labelView)

        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            labelView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            labelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            labelView.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            labelView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
        ])
    }
}
