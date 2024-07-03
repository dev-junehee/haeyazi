//
//  MainCollectionViewCell.swift
//  haeyazi
//
//  Created by junehee on 7/3/24.
//

import UIKit
import SnapKit

class MainCollectionViewCell: BaseCollectionViewCell {
    
    let iconTitleStack = UIStackView()
    let iconView = UIImageView()
    let titleLabel = UILabel()
    let countLabel = UILabel()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        iconView.clipsToBounds = true
        iconView.layer.cornerRadius = iconView.frame.width / 2
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        iconView.layoutIfNeeded()
//        iconView.clipsToBounds = true
//        iconView.layer.cornerRadius = iconView.frame.width / 2
//    }
    
    override func configureCellHierarchy() {
        let iconTitle = [iconView, titleLabel]
        iconTitle.forEach {
            iconTitleStack.addArrangedSubview($0)
        }
        
        let subViews = [iconTitleStack, countLabel]
        subViews.forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureCellLayout() {
        iconTitleStack.snp.makeConstraints {
            $0.verticalEdges.leading.equalTo(contentView).inset(8)
            $0.width.equalTo(contentView.frame.width / 2)
        }
        iconTitleStack.axis = .vertical
        iconTitleStack.alignment = .leading
        iconTitleStack.spacing = 4
        
        iconView.snp.makeConstraints {
            $0.top.equalTo(iconTitleStack.snp.top).offset(4)
            $0.size.equalTo(36)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconView.snp.bottom).offset(8)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).inset(8)
            $0.trailing.equalTo(contentView).inset(12)
        }
    }
    
    override func configureCellUI() {
        contentView.backgroundColor = Resources.Color.system
        contentView.layer.cornerRadius = 16
        iconView.tintColor = Resources.Color.white
        iconView.contentMode = .center
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .gray
        countLabel.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
    func configureCellData(title: String, image: UIImage, color: UIColor, count: Int) {
        iconView.image = image
        iconView.backgroundColor = color
        titleLabel.text = title
        countLabel.text = "\(count)"
    }
    
}
