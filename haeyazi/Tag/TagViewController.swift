//
//  TagViewController.swift
//  haeyazi
//
//  Created by junehee on 7/3/24.
//

import Foundation

final class TagViewController: BaseViewController {
    
    private let tagView = TagView()
    
    var selectedTag = ""
    var sendTag: ((String) -> Void)?
    
    override func loadView() {
        self.view = tagView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(self, "보내기 전 확인", tagView.tagField.text)
        sendTag?(tagView.tagField.text ?? "")
    }
    
}
