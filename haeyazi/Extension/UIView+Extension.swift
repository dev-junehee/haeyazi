//
//  UIView+Extension.swift
//  haeyazi
//
//  Created by junehee on 7/5/24.
//

import UIKit

extension UIView {
    // 날짜 포맷팅
    func getFormattedDateString(date: Date, formatStyle: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formatStyle
        return formatter.string(for: date) ?? "\(formatStyle)"
    }
}
