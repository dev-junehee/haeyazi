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
    private var userSelectedData: [Int: Any] = [
        0: "",      // 마감일
        1: "",      // 태그
        2: "",      // 우선순위
        3: ""      // 이미지 추가
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
        super.configureController()
        navigationItem.title = Constants.Add.navigationTitle
        
        setBarButton(type: .text, position: .left, title: Constants.Button.cancel, image: nil, color: nil, action: #selector(cancelBarButtonClicked))
        setBarButton(type: .text, position: .right, title: Constants.Button.add, image: nil, color: nil, action: #selector(addBarButtonClicked))
        
        addView.tableView.delegate = self
        addView.tableView.dataSource = self
        addView.tableView.register(AddTableViewCell.self, forCellReuseIdentifier: AddTableViewCell.id)
        addView.tableView.rowHeight = 50
        addView.tableView.separatorStyle = .none
    }
    
    @objc private func cancelBarButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc private func addBarButtonClicked() {
        let repository = TodoTableRepository()
        
        guard let title = addView.titleField.text, !title.isEmpty, let memo = addView.memoField.text else {
            showAlert(style: .oneButton, title: "제목이 비어있어요!", message: "제목을 입력해 주세요.") { return }
            return
        }
        
        let todo = Todo(
            title: title,
            memo: memo,
            endDate: userSelectedData[0] as? Date,
            tag: userSelectedData[1] as? String,
            priority: userSelectedData[2] as? Int ?? 1
        )
        print("저장 전 저장값 확인", userSelectedData)
        print("저장 전 확인", todo)
        repository.createTodo(todo)
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
        let title = Constants.Add.sectionTitles[section]
        
        
        if section == 0 {
            // 마감일
            let data = userSelectedData[section] as? Date
            cell.configureDateCellData(title: title, data: data ?? Date())
        } else if section == 1 {
            // 태그
            let data = userSelectedData[section] as? String
            cell.configureTagCellData(title: title, tag: data)
        } else if section == 2 {
            // 우선순위 높 보통 낮
            let data = userSelectedData[section] as? Int
            cell.configurePriorityCellData(title: title, data: data)
        } else {
            let data = userSelectedData[section] as? String
            cell.configureCellData(title: title, data: data)
        }
       
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
            endDateVC.sendDate = { date in // Date
                self.userSelectedData[section] = date ?? Date()
            }
            navigationController?.pushViewController(endDateVC, animated: true)
        } else if section == 1 {
            let tagVC = TagViewController()
            tagVC.sendTag = { tag in // String
                self.userSelectedData[section] = tag
            }
            navigationController?.pushViewController(tagVC, animated: true)
        } else if section == 2 {
            let priorityVC = PriorityViewController()
            priorityVC.sendPriority = { priority in // Int
                self.userSelectedData[section] = priority
            }
            navigationController?.pushViewController(priorityVC, animated: true)
        } else {
            showAlert(style: .oneButton, title: "준비 중이에요!", message: nil) { return }
        }
    }
}
