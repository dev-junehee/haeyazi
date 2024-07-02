//
//  AddViewController.swift
//  haeyazi
//
//  Created by junehee on 7/2/24.
//

import UIKit

class AddViewController: BaseViewController {
    
    let addView = AddView()
    
    override func loadView() {
        self.view = addView
    }
    
    override func configureController() {
        navigationItem.title = Constants.Add.title
        setBarButton(type: .text, position: .left, title: Constants.cancel, image: nil, color: Resources.Color.primary, action: #selector(cancelBarButtonClicked))
        setBarButton(type: .text, position: .right, title: Constants.add, image: nil, color: Resources.Color.primary, action: #selector(saveBarButtonClicked))
        
        addView.tableView.delegate = self
        addView.tableView.dataSource = self
        addView.tableView.register(AddTableViewCell.self, forCellReuseIdentifier: AddTableViewCell.id)
        addView.tableView.rowHeight = 60
        addView.tableView.separatorStyle = .none
    }
    
    @objc private func cancelBarButtonClicked() {
        print("취소 버튼 클릭")
        dismiss(animated: true)
    }
    
    @objc private func saveBarButtonClicked() {
        print("저장 버튼 클릭")
    }
}

extension AddViewController: UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.Add.sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddTableViewCell.id, for: indexPath) as? AddTableViewCell else { return AddTableViewCell() }
        let title = Constants.Add.sectionTitles[indexPath.row]
        cell.configureCellData(title: title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Add - 각 버튼 클릭", indexPath)
//        navigationController?.pushViewController(UIViewController(), animated: true)
    }
}
