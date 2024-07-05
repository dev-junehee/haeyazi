//
//  PriorityViewController.swift
//  haeyazi
//
//  Created by junehee on 7/3/24.
//

import Foundation

final class PriorityViewController: BaseViewController {
    
    private let priorityView = PriorityView()
    
    var selectedPriority: Int?
    var sendPriority: ((Int) -> Void)?
    
    override func loadView() {
        self.view = priorityView
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setSelectedPriority()
    }
    
    private func setSelectedPriority() {
        let selected = priorityView.priorityControl.selectedSegmentIndex
        print("우선순위 보내기 전 확인", selected)
        sendPriority?(selected)
    }
    
}
