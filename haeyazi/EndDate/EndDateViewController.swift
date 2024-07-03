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
    
    override func configureHierarchy() {
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
        
        print(dateComponents)
        
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)
        self.selectedDate = date ?? Date()
   
//        let calendar = Calendar.current
//        let selectedDate = calendar.date(from: dateComponents)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy.MM.dd (EE)"
//        
//        if let selectedDate = dateFormatter.string(for: selectedDate) {
//            print("1", selectedDate)
//            self.selectedDate = selectedDate
//            print("2", self.selectedDate)
//        }
//        else {
//            print("3", dateFormatter.string(from: Date()))
//            self.selectedDate = dateFormatter.string(from: Date())
//            print("4", self.selectedDate)
//        }
        
//        let calendar = Calendar(identifier: .gregorian)
//        if let date = calendar.date(from: dateComponents) {
//            print(self, #function, date)
//            self.selectedDate = date
//        }
    }
}
