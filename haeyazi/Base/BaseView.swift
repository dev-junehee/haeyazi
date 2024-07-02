//
//  BaseView.swift
//  haeyazi
//
//  Created by junehee on 7/2/24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewHierarchy()
        configureViewLayout()
        configureViewUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 계층
    func configureViewHierarchy() { }
    
    // 레이아웃
    func configureViewLayout() { }
    
    // 디자인 & 변하지 않는 데이터
    func configureViewUI() {
    }
}
