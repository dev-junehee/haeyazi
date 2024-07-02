//
//  UITextField+Extension.swift
//  haeyazi
//
//  Created by junehee on 7/2/24.
//

import UIKit

enum PaddingPosition {
    case left
    case right
}

extension UITextField {
    func setTextFieldUI(placeholder: String) {
        self.placeholder = placeholder
        self.backgroundColor = Resources.Color.white
        self.clipsToBounds = true
        self.layer.cornerRadius = 16
    }
    
    func setPadding(type: PaddingPosition, amount: CGFloat) {
        switch type {
        case .left:
            self.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: amount, height: 0.0))
            self.leftViewMode = .always
        case .right:
            self.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: amount, height: 0.0))
            self.rightViewMode = .always
        }
    }
}
