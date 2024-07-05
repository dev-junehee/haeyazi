//
//  TagView.swift
//  haeyazi
//
//  Created by junehee on 7/3/24.
//

import UIKit
import SnapKit

class TagView: BaseView {
    
    let tagLabel = UILabel()
    let tagField = UITextField()
    
    override func configureViewHierarchy() {
        let subViews = [tagLabel, tagField]
        subViews.forEach {
            self.addSubview($0)
        }
    }
    
    override func configureViewLayout() {
        tagLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(20)
        }
        
        tagField.snp.makeConstraints {
            $0.top.equalTo(tagLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(60)
        }
    }
    
    override func configureViewUI() {
        tagLabel.text = Constants.Tag.tag
        tagLabel.font = Resources.Font.medium14
        
        tagField.setTextFieldUI(placeholder: Constants.Tag.placeholder)
        tagField.setPadding(type: .left, amount: 20)
        tagField.font = Resources.Font.body14
    }
    
}
