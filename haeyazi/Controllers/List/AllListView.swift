//
//  AllListView.swift
//  haeyazi
//
//  Created by junehee on 7/2/24.
//

import UIKit
import SnapKit

class AllListView: BaseView {
    
    let titleLabel = UILabel()
    let tableView = UITableView()
    
    override func configureViewHierarchy() {
        let subViews = [titleLabel, tableView]
        subViews.forEach {
            self.addSubview($0)
        }
    }
    
    override func configureViewLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func configureViewUI() {
        titleLabel.text = Constants.AllList.title
        titleLabel.font = Resources.Font.title
    
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 20
        tableView.rowHeight = 90
    }
    
}
