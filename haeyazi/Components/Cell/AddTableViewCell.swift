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
    let dataLabel = UILabel()
    let arrowButton = UIImageView()
    
    override func configureCellHierarchy() {
        let subViews = [titleLabel, dataLabel, arrowButton]
        subViews.forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureCellLayout() {
        titleLabel.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView)
            $0.leading.equalTo(contentView).inset(16)
            $0.width.equalTo(100)
        }
        
        dataLabel.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView)
            $0.trailing.equalTo(arrowButton.snp.leading)
            $0.width.equalTo(120)
        }
        
        arrowButton.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView)
            $0.trailing.equalTo(contentView).inset(16)
            $0.leading.equalTo(dataLabel.snp.trailing)
            $0.width.equalTo(10)
            $0.centerY.equalTo(contentView)
        }
    }
    
    override func configureCellUI() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 16
        titleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        dataLabel.font = .systemFont(ofSize: 14, weight: .light)
        dataLabel.textColor = Resources.Color.primary
        dataLabel.textAlignment = .center
        arrowButton.image = Resources.SystemImage.right
        arrowButton.contentMode = .scaleAspectFit
        arrowButton.tintColor = .gray
    }
    
    func configureCellData(title: String, data: String?) {
        titleLabel.text = title
        dataLabel.text = data ?? ""
    }
    
    // 마감일
    func configureDateCellData(title: String, data: Date) {
        titleLabel.text = title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd (EE)"
        let formattedDate = dateFormatter.string(for: data)
        dataLabel.text = formattedDate
    }
    
    // 태그
    func configureTagCellData(title: String, tag: String?) {
        titleLabel.text = title
        dataLabel.text = tag ?? ""
    }
    
    // 우선순위
    func configurePriorityCellData(title: String, data: Int?) {
        titleLabel.text = title
        dataLabel.text = Constants.Add.priority[data ?? 1]
    }
    
}
