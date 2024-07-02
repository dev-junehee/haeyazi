//
//  TodoTableViewCell.swift
//  haeyazi
//
//  Created by junehee on 7/2/24.
//

import UIKit
import SnapKit

class TodoTableViewCell: BaseTableViewCell {
    
    let checkButton = UIButton()
    
    let labelStack = UIStackView()
    let titleLabel = UILabel()
    let memoLabel = UILabel()
    let dateLabel = UILabel()
    
    override func configureCellHierarchy() {
        let labels = [titleLabel, memoLabel, dateLabel]
        labels.forEach {
            labelStack.addArrangedSubview($0)
        }
        
        let subViews = [checkButton, labelStack]
        subViews.forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureCellLayout() {
        checkButton.snp.makeConstraints {
            $0.top.leading.bottom.equalTo(contentView)
            $0.trailing.equalTo(labelStack.snp.leading)
            $0.width.equalTo(60)
        }
        
        labelStack.snp.makeConstraints {
            $0.top.bottom.trailing.equalTo(contentView)
            $0.leading.equalTo(checkButton.snp.trailing)
            $0.height.equalTo(40)
        }
        labelStack.axis = .vertical
        labelStack.distribution = .equalSpacing
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(labelStack.snp.top)
            $0.height.equalTo(30)
        }
        
        memoLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(memoLabel.snp.bottom)
        }
    }
    
    override func configureCellUI() {
        // 임시 확인용
//        checkButton.backgroundColor = .yellow
//        labelStack.backgroundColor = .orange
//        titleLabel.backgroundColor = .red
//        memoLabel.backgroundColor = .blue
//        dateLabel.backgroundColor = .green
        
        checkButton.setImage(Resources.SystemImage.uncheck, for: .normal)
        checkButton.setImage(Resources.SystemImage.check, for: .selected)
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        memoLabel.font = .systemFont(ofSize: 14, weight: .regular)
        dateLabel.textColor = .gray
        dateLabel.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    func configureCellData(data: Todo) {
        titleLabel.text = data.title
        memoLabel.text = data.memo
        dateLabel.text = data.regDate.formatted()
    }
}
