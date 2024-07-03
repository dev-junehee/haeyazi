//
//  AddView.swift
//  haeyazi
//
//  Created by junehee on 7/2/24.
//

import UIKit
import SnapKit

class AddView: BaseView {
    
    let titleLabel = UILabel()
    let titleField = UITextField()
    let memoLabel = UILabel()
    let memoField = UITextField()
    
    let tableView = UITableView()
    
    override func configureViewHierarchy() {
        let subViews = [titleLabel, titleField, memoLabel, memoField, tableView]
        subViews.forEach {
            self.addSubview($0)
        }
    }
    
    override func configureViewLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(20)
        }
        
        titleField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(60)
        }
        
        memoLabel.snp.makeConstraints {
            $0.top.equalTo(titleField.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(20)
        }
        
        memoField.snp.makeConstraints {
            $0.top.equalTo(memoLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(60)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(memoField.snp.bottom).offset(32)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func configureViewUI() {
        self.backgroundColor = Resources.Color.background
        
        let textFields = [titleField, memoField]
        let placeholders = Constants.Add.placeholders
        for i in 0..<textFields.count {
            textFields[i].setTextFieldUI(placeholder: placeholders[i])
            textFields[i].setPadding(type: .left, amount: 20)
            textFields[i].font = .systemFont(ofSize: 14, weight: .regular)
        }
        
        tableView.backgroundColor = .clear
        
        titleLabel.text = "제목"
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        memoLabel.text = "내용"
        memoLabel.font = .systemFont(ofSize: 14, weight: .medium)
    }
}
