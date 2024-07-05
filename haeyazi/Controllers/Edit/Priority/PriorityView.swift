//
//  PriorityView.swift
//  haeyazi
//
//  Created by junehee on 7/3/24.
//

import UIKit
import SnapKit

class PriorityView: BaseView {
    
    let controlTitles = Constants.Add.priority
    lazy var priorityControl = UISegmentedControl(items: controlTitles)
    
    override func configureViewHierarchy() {
        self.addSubview(priorityControl)
    }
    
    override func configureViewLayout() {
        priorityControl.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(44)
        }
    }
    
    override func configureViewUI() {
        priorityControl.tintColor = Resources.Color.primary
        priorityControl.selectedSegmentIndex = 1
    }
    
}
