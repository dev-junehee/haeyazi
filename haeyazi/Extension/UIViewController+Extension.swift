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

enum AlertStyle {
    case oneButton
    case twoButton
}

extension UIViewController {
    // BarButton
    func setBarButton(type: BarButtonType, position: BarButtonPosition, title: String?, image: UIImage?, color: UIColor?, action: Selector?) {
        var barButton: UIBarButtonItem?
        
        switch type {
        case .image:
            barButton = UIBarButtonItem(image: image, style: .plain, target: self, action: action)
        case .text:
            barButton = UIBarButtonItem(title: title, style: .plain, target: self, action: action)
        }
        
        barButton?.tintColor = (color != nil) ? color : Resources.Color.primary
        
        switch position {
        case .left:
            navigationItem.leftBarButtonItem = barButton
        case .right:
            navigationItem.rightBarButtonItem = barButton
        }
    }
    
    // Alert
    func showAlert(style: AlertStyle, title: String, message: String?, completionHandler: @escaping () -> Void?) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        switch style {
        case .oneButton:
            let okay = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okay)
            completionHandler()
            present(alert, animated: true)
        case .twoButton:
            let okay = UIAlertAction(title: "확인", style: .default)
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(okay)
            alert.addAction(cancel)
            completionHandler()
            present(alert, animated: true)
        }
    }
}
