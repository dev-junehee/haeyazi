//
//  EndDateView.swift
//  haeyazi
//
//  Created by junehee on 7/3/24.
//

import UIKit
import SnapKit

class EndDateView: BaseView {
    
    let calendar = UICalendarView()
    
    override func configureViewHierarchy() {
        self.addSubview(calendar)
    }
    
    override func configureViewLayout() {
        calendar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(400)
        }
    }
    
    override func configureViewUI() {
        calendar.backgroundColor = Resources.Color.white
        calendar.tintColor = Resources.Color.primary
        calendar.layer.cornerRadius = 16
        
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.wantsDateDecorations = true
        calendar.locale = Locale(identifier: "ko-KR")
    }
    
}
