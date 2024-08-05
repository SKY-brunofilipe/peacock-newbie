//
//  NavigationBar.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 02/08/2024.
//

import Foundation
import UIKit

final class NavigationBar: UIControl {
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configure()
    }
    
    @available(*, unavailable)
    required internal init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        configureView()
    }
    
    private func configureView() {
        
    }
}
