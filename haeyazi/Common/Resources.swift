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
        static let white: UIColor = .white
        static let background: UIColor = .systemGroupedBackground
    }
    
    enum Font {
        static let title: UIFont = .systemFont(ofSize: 42, weight: .black)
    }
    
    enum SystemImage {
        static let add = UIImage(systemName: "plus.circle.fill")
        static let sort = UIImage(systemName: "ellipsis.circle")
        static let check = UIImage(systemName: "checkmark.circle.fill")
        static let uncheck = UIImage(systemName: "circle")
        static let right = UIImage(systemName: "chevron.right")
        static let text = UIImage(systemName: "textformat")
        static let calendar = UIImage(systemName: "calendar")
        static let priority = UIImage(systemName: "list.number")
    }
}
