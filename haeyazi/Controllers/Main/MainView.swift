//
//  MainView.swift
//  haeyazi
//
//  Created by junehee on 7/3/24.
//

import UIKit
import SnapKit

class MainView: BaseView {
    
    let titleLabel = UILabel()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 48
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: width / 2, height: width / 4)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        return layout
    }
    
    override func configureViewHierarchy() {
        let subViews = [titleLabel, collectionView]
        subViews.forEach {
            self.addSubview($0)
        }
    }
    
    override func configureViewLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func configureViewUI() {
        titleLabel.text = Constants.Title.all
        titleLabel.font = Resources.Font.title
        collectionView.backgroundColor = Resources.Color.clear
    }
    
}
