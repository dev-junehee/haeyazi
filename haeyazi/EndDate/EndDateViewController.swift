//
//  EndDateViewController.swift
//  haeyazi
//
//  Created by junehee on 7/3/24.
//

import UIKit

class EndDateViewController: BaseViewController {
  
    let dateView = EndDateView()
    
    var selectedDate = Date()
    var sendDate: ((Date?) -> Void)?
    
    override func loadView() {
        self.view = dateView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("보내기전 확인", selectedDate)
        sendDate?(selectedDate)
    }
    
    override func configureController() {
        dateView.calendar.delegate = self
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        dateView.calendar.selectionBehavior = dateSelection
    }
    
}


extension EndDateViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let dateComponents else {
            print(self, #function, "날짜가 이상해요")
            return
        }
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)
        self.selectedDate = date ?? Date()
    }
}
