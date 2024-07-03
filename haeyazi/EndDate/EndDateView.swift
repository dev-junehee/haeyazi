//
//  EndDateView.swift
//  haeyazi
//
//  Created by junehee on 7/3/24.
//

import UIKit
import SnapKit

class EndDateView: BaseView {
    
    let datePicker = UIDatePicker()
    
    override func configureViewHierarchy() {
        self.addSubview(datePicker)
    }
    
    override func configureViewLayout() {
        datePicker.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(400)
        }
    }
    
}
