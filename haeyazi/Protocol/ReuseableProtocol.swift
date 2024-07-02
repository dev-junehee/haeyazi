//
//  ReuseableProtocol.swift
//  haeyazi
//
//  Created by junehee on 7/2/24.
//

import UIKit

protocol ReuseableProtocol: AnyObject {
    static var id: String { get }
}

extension UIView: ReuseableProtocol {
    static var id: String {
        return String(describing: self)
    }
}

extension UIViewController: ReuseableProtocol {
    static var id: String {
        return String(describing: self)
    }
}
