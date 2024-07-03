//
//  MainViewController.swift
//  haeyazi
//
//  Created by junehee on 7/3/24.
//

import UIKit

class MainViewController: BaseViewController {
    
    let mainView = MainView()
    
    let titles = Constants.Main.titles
    let colors = Resources.Color.mainColors
    let icons = Resources.SystemImage.mainIcons
    
    override func loadView() {
        self.view = mainView
    }
    
    override func configureController() {
        navigationController?.isToolbarHidden = false
        setToolBarButtons()
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.id)
    }
    
}


extension MainViewController {
    func setToolBarButtons() {
        let addTodoButton = UIBarButtonItem(title: "새로운 할 일", image: Resources.SystemImage.add, target: self, action: #selector(addButtonClicked))
        let addListButton = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(listButtonClicked))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        navigationController?.toolbar.tintColor = Resources.Color.primary
        toolbarItems = [addTodoButton, flexibleSpace, addListButton]
    }
    
    @objc private func addButtonClicked() {
        print(AllListViewController.id, #function, "추가 버튼 클릭")
        let addVC = UINavigationController(rootViewController: AddViewController())
        present(addVC, animated: true)
    }
    
    @objc private func listButtonClicked() {
        print(self, #function)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.id, for: indexPath) as? MainCollectionViewCell else { return MainCollectionViewCell() }

        let title = titles[indexPath.item]
        let color = colors[indexPath.item]
        let icon = icons[indexPath.item]

        cell.configureCellData(title: title, image: icon, color: color, count: Int.random(in: 0...20))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = indexPath.item
        if item == 2 {
            let AllListVC = AllListViewController()
            navigationController?.pushViewController(AllListVC, animated: true)
        } else {
            showAlert(style: .oneButton, title: "준비 중이에요!", message: nil) { return }
        }
    }
}
