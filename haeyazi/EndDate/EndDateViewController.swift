//
//  EndDateViewController.swift
//  haeyazi
//
//  Created by junehee on 7/3/24.
//

import UIKit

class EndDateViewController: BaseViewController {
    
    let dateView = EndDateView()
    
    override func loadView() {
        self.view = dateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("마감일 화면 진입")
    }
    
}
