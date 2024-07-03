//
//  DetailView.swift
//  haeyazi
//
//  Created by junehee on 7/3/24.
//

import UIKit
import SnapKit

class DetailView: BaseView {
    
    let titleField = UITextField()
    let memoField = UITextField()
    
    let tableView = UITableView()

    override func configureViewHierarchy() {
        let subViews = [titleField, memoField, tableView]
        subViews.forEach {
            self.addSubview($0)
        }
    }
    
    override func configureViewLayout() {
        titleField.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(60)
        }
        
        memoField.snp.makeConstraints {
            $0.top.equalTo(titleField.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(60)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(memoField.snp.bottom).offset(32)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func configureViewUI() {
        titleField.text = "제목 가져오기"
        memoField.text = "메모 가져오기"
        
        let textFields = [titleField, memoField]
        let placeholders = Constants.Add.placeholders
        for i in 0..<textFields.count {
            textFields[i].setTextFieldUI(placeholder: placeholders[i])
            textFields[i].setPadding(type: .left, amount: 20)
            textFields[i].font = Resources.Font.body14
        }
        
        tableView.backgroundColor = Resources.Color.clear
    }
    
    
}
