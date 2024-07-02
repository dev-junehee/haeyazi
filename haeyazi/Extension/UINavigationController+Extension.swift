//
//  UINavigationController+Extension.swift
//  haeyazi
//
//  Created by junehee on 7/2/24.
//

import UIKit

enum BarButtonPosition {
    case left
    case right
}

enum BarButtonType {
    case text
    case image
}

extension UIViewController {
    // BarButton
    func setBarButton(type: BarButtonType, position: BarButtonPosition, title: String?, image: UIImage?, color: UIColor, action: Selector?) {
        var barButton: UIBarButtonItem?
        
        switch type {
        case .image:
            barButton = UIBarButtonItem(image: image, style: .plain, target: self, action: action)
        case .text:
            barButton = UIBarButtonItem(title: title, style: .plain, target: self, action: action)
        }
        
        barButton?.tintColor = color
        
        switch position {
        case .left:
            navigationItem.leftBarButtonItem = barButton
        case .right:
            navigationItem.rightBarButtonItem = barButton
        }
    }
}
