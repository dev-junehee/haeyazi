//
//  AddTableViewCell.swift
//  haeyazi
//
//  Created by junehee on 7/2/24.
//

import UIKit
import SnapKit

class AddTableViewCell: BaseTableViewCell {
    
    let titleLabel = UILabel()
    let arrowButton = UIImageView()
    
    override func configureCellHierarchy() {
        let subViews = [titleLabel, arrowButton]
        subViews.forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureCellLayout() {
        titleLabel.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView)
            $0.leading.equalTo(contentView).inset(16)
            $0.trailing.equalTo(arrowButton.snp.leading)
        }
        
        arrowButton.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView)
            $0.trailing.equalTo(contentView).inset(16)
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.size.equalTo(10)
            $0.centerY.equalTo(contentView)
        }
    }
    
    override func configureCellUI() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 16
        titleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        arrowButton.image = Resources.SystemImage.right
        arrowButton.contentMode = .scaleAspectFit
        arrowButton.tintColor = .gray
    }
    
    func configureCellData(title: String) {
        titleLabel.text = title
    }
    
}
