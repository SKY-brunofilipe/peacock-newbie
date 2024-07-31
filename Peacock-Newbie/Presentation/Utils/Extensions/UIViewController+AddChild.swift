//
//  UIViewController+AddChild.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 30/07/2024.
//

import UIKit

extension UIViewController {
    
    func add(child: UIViewController, container: UIView) {
        addChild(child)
        child.view.frame = container.bounds
        container.addSubview(child.view)
        child.didMove(toParent: self)
    }
}
