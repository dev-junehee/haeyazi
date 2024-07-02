//
//  BaseViewController.swift
//  haeyazi
//
//  Created by junehee on 7/2/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    // navigationItem.Title, delegate...
    func configureController() { }
    
    // 계층
    func configureHierarchy() { }
    
    // 레이아웃
    func configureLayout() { }
    
    // 디자인 & 변하지 않는 데이터
    func configureUI() {
        view.backgroundColor = .white
    }
    
}
