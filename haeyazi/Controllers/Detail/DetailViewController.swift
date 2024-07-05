//
//  DetailViewController.swift
//  haeyazi
//
//  Created by junehee on 7/3/24.
//

import UIKit
import RealmSwift

final class DetailViewController: BaseViewController {
    
    let detailView = DetailView()
    
    let realm = try! Realm()
    
    // 기존 데이터
    var todoData: Todo?
    
    // 바뀔 데이터
    var isUpdated = false
    var updateTodoData: [String: Any] = [
        "endDate": "",
        "tag": "",
        "priority": ""
    ] {
        didSet {
            print("투두 바뀜")
            detailView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        configureUpdateTodoData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print(#function)
        detailView.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
    }
    
    override func configureController() {
        super.configureController()
        navigationItem.title = Constants.Detail.navigationTitle
        setEditBarButton()
        
        detailView.tableView.delegate = self
        detailView.tableView.dataSource = self
        detailView.tableView.register(AddTableViewCell.self, forCellReuseIdentifier: AddTableViewCell.id)
        detailView.tableView.rowHeight = 50
        detailView.tableView.separatorStyle = .none
    }
    
    override func configureUI() {
        super.configureUI()
        detailView.titleField.text = todoData?.title
        detailView.memoField.text = todoData?.memo
    }
    
    private func configureUpdateTodoData() {
        updateTodoData["endDate"] = todoData?.endDate
        updateTodoData["tag"] = todoData?.tag
        updateTodoData["priority"] = todoData?.priority
    }
    
}


extension DetailViewController {
    private func setEditBarButton() {
        setBarButton(type: .text, position: .right, title: Constants.Button.edit, image: nil, color: nil, action: #selector(editButtonClicked))
        let button = navigationItem.rightBarButtonItem
        button?.setTitleTextAttributes(
            [.font: Resources.Font.bold18],
            for: .normal
        )
    }
    
    @objc private func editButtonClicked() {
        guard let title = detailView.titleField.text else {
            showAlert(style: .oneButton, title: "제목을 입력해 주세요!", message: nil) { return }
            return
        }
        
        if isUpdated {
            try! realm.write {
                todoData?.title = title
                todoData?.memo = detailView.memoField.text
                todoData?.endDate = updateTodoData["endDate"] as? Date ?? nil
                todoData?.tag = updateTodoData["tag"] as? String ?? nil
                todoData?.priority = updateTodoData["priority"] as? Int ?? 1
            }
            NotificationCenter.default.post(
                name: NSNotification.Name(DetailViewController.id),
                object: nil,
                userInfo: nil
            )
        } else {
            configureUpdateTodoData()
        }
        
        dismiss(animated: true)
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
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
            let endDate = updateTodoData["endDate"] as? Date ?? Date()
            cell.configureDateCellData(title: title, data: endDate)
        } else if section == 1 {
            // 태그
            let tag = updateTodoData["tag"] as? String ?? ""
            cell.configureTagCellData(title: title, tag: tag)
        } else if section == 2 {
            // 우선순위 높 보통 낮
            let priority = updateTodoData["priority"] as? Int ?? 1
            cell.configurePriorityCellData(title: title, data: priority)
        } else {
            cell.configureCellData(title: title, data: "")
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
                if date != self.todoData?.endDate {
                    self.isUpdated = true
                }
                if self.isUpdated {
                    self.updateTodoData["endDate"] = date
                }
            }
            navigationController?.pushViewController(endDateVC, animated: true)
        } else if section == 1 {
            let tagVC = TagViewController()
            tagVC.sendTag = { tag in
                if tag != self.todoData?.tag {
                    self.isUpdated = true
                }
                if self.isUpdated {
                    self.updateTodoData["tag"] = tag
                }
            }
            navigationController?.pushViewController(tagVC, animated: true)
        } else if section == 2 {
            let priorityVC = PriorityViewController()
            priorityVC.sendPriority = { priority in // Int
                if priority != self.todoData?.priority {
                    self.isUpdated = true
                }
                if self.isUpdated {
                    self.updateTodoData["priority"] = priority
                }
            }
            navigationController?.pushViewController(priorityVC, animated: true)
        } else {
            showAlert(style: .oneButton, title: "준비 중이에요!", message: nil) { return }
        }
    }
}
