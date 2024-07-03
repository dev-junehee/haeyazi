//
//  Resources.swift
//  haeyazi
//
//  Created by junehee on 7/2/24.
//

import UIKit

/**
 프로젝트에서 사용할 리소스 관리
 - Color
 - Font
 */
enum Resources {
    enum Color {
        static let primary: UIColor = .systemIndigo
        static let system: UIColor = .systemBackground
        static let black: UIColor = .black
        static let gray: UIColor = .gray
        static let white: UIColor = .white
        static let background: UIColor = .systemGroupedBackground
        static let clear: UIColor = .clear
        
        static var mainColors: [UIColor] {
            return [.systemBlue, .systemRed, .systemGray, .systemYellow, .systemGray]
        }
    }
    
    enum Font {
        static let title: UIFont = .systemFont(ofSize: 42, weight: .black)
        static let subTitle: UIFont = .systemFont(ofSize: 24, weight: .bold)
        static let bold16: UIFont = .systemFont(ofSize: 16, weight: .bold)
        static let medium14: UIFont = .systemFont(ofSize: 14, weight: .medium)
        static let body14: UIFont = .systemFont(ofSize: 14, weight: .regular)
        static let light14: UIFont = .systemFont(ofSize: 14, weight: .light)
    }
    
    enum SystemImage {
        static let add = UIImage(systemName: "plus.circle.fill")!
        static let sort = UIImage(systemName: "ellipsis.circle")!
        static let check = UIImage(systemName: "checkmark.circle.fill")!
        static let uncheck = UIImage(systemName: "circle")!
        static let left = UIImage(systemName: "chevron.left")!
        static let right = UIImage(systemName: "chevron.right")!
        static let text = UIImage(systemName: "textformat")!
        static let calendar = UIImage(systemName: "calendar")!
        static let priority = UIImage(systemName: "list.number")!
        static let flag = UIImage(systemName: "flag.fill")!
        static let tray = UIImage(systemName: "tray.fill")!
        static let checkmark = UIImage(systemName: "checkmark")!
        static let paperplane = UIImage(systemName: "paperplane.fill")!
        
        static var mainIcons: [UIImage] {
            return [
                Resources.SystemImage.calendar,
                Resources.SystemImage.paperplane,
                Resources.SystemImage.tray,
                Resources.SystemImage.flag,
                Resources.SystemImage.checkmark]
        }
    }
}
