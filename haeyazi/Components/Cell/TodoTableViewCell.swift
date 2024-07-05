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
        checkButton.setImage(Resources.SystemImage.uncheck, for: .normal)
        titleLabel.font = Resources.Font.bold16
        memoLabel.font = Resources.Font.body14
        dateLabel.textColor = .gray
        dateLabel.font = Resources.Font.body14
    }
    
    func configureCellData(data: Todo) {
        titleLabel.text = data.title
        memoLabel.text = data.memo
        
        guard let endDate = data.endDate else {
            dateLabel.text = "-"
            return
        }
        dateLabel.text = getFormattedDateString(date: endDate, formatStyle: "yyyy.MM.dd (EE)")
        
        if data.isDone {
            checkButton.setImage(Resources.SystemImage.check, for: .normal)
        } else {
            checkButton.setImage(Resources.SystemImage.uncheck, for: .normal)
        }
    }
    
    func updateDoneButtonUI(isDone: Bool) {
        if isDone {
            checkButton.setImage(Resources.SystemImage.check, for: .normal)
        } else {
            checkButton.setImage(Resources.SystemImage.uncheck, for: .normal)
        }
    }
}
