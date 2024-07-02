//
//  AllListViewController.swift
//  haeyazi
//
//  Created by junehee on 7/2/24.
//

import UIKit

final class AllListViewController: BaseViewController {
    
    private let allView = AllListView()
    
    let dummyList = ["1111", "22222"]
    
    override func loadView() {
        self.view = allView
    }
    
    override func configureController() {
        setBarButton(type: .image, position: .right, title: nil, image: Resources.SystemImage.add, color: Resources.Color.primary, action: #selector(addButtonClicked))
        
        allView.tableView.delegate = self
        allView.tableView.dataSource = self
        allView.tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.id)
        allView.tableView.rowHeight = 80
    }
    
    @objc private func addButtonClicked() {
        print(AllListViewController.id, #function, "추가 버튼 클릭")
        let addVC = UINavigationController(rootViewController: AddViewController())
        present(addVC, animated: true)
    }
}


extension AllListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.id, for: indexPath)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
