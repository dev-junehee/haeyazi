//
//  AddViewController.swift
//  haeyazi
//
//  Created by junehee on 7/2/24.
//

import UIKit
import RealmSwift

final class AddViewController: BaseViewController {
    
    private let addView = AddView()
    private var userSelectedData = [
        "endDate": "",
        "tag": "",
        "priority": "",
        "image": ""
    ] {
        didSet {
            addView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = addView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.post(
            name: NSNotification.Name(AddViewController.id),
            object: nil,
            userInfo: nil
        )
    }
    
    override func configureController() {
        navigationItem.title = Constants.Add.title
        
        setBarButton(type: .text, position: .left, title: Constants.cancel, image: nil, color: nil, action: #selector(cancelBarButtonClicked))
        setBarButton(type: .text, position: .right, title: Constants.add, image: nil, color: nil, action: #selector(addBarButtonClicked))
        
        addView.tableView.delegate = self
        addView.tableView.dataSource = self
        addView.tableView.register(AddTableViewCell.self, forCellReuseIdentifier: AddTableViewCell.id)
        addView.tableView.rowHeight = 50
        addView.tableView.separatorStyle = .none
    }
    
    @objc private func cancelBarButtonClicked() {
        print("취소 버튼 클릭")
        dismiss(animated: true)
    }
    
    @objc private func addBarButtonClicked() {
        print("저장 버튼 클릭")
        
        let realm = try! Realm()
        
        guard let title = addView.titleField.text, !title.isEmpty, let memo = addView.memoField.text else {
            showAlert(style: .oneButton, title: "제목이 비어있어요!", message: "제목을 입력해 주세요.") { return }
            return
        }
        
        let todo = Todo(title: title, memo: memo, regDate: Date())
        
        try! realm.write {
            realm.add(todo)
            print("DB 저장 성공!")
        }
        dismiss(animated: true)
    }
}

extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.Add.sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddTableViewCell.id, for: indexPath) as? AddTableViewCell else { return AddTableViewCell() }
        let section = indexPath.section
        
        var key = ""
        if section == 0 {
            key = "endDate"
        } else if section == 1 {
            key = "tag"
        } else if section == 2 {
            key = "priority"
        } else {
            key = "image"
        }
        
        let title = Constants.Add.sectionTitles[section]
        let data = userSelectedData[key]
        cell.configureCellData(title: title, data: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
        
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        if section == 0 {
            let endDateVC = EndDateViewController()
            endDateVC.sendDate = { date in
                print("이게 나오면 진짜다", date)
                self.userSelectedData["endDate"] = date
            }
            navigationController?.pushViewController(endDateVC, animated: true)
        } else if section == 1 {
            let tagVC = TagViewController()
            navigationController?.pushViewController(tagVC, animated: true)
        } else if section == 2 {
            let priorityVC = PriorityViewController()
            navigationController?.pushViewController(priorityVC, animated: true)
        } else {
            showAlert(style: .oneButton, title: "준비 중이에요!", message: nil) {
                return
            }
        }
    }
}
