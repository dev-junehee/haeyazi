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
    
    var todoData: Todo? {
        didSet {
            detailView.tableView.reloadData()
        }
    }
    
    var sendNewData: ((String?) -> Void)?
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        detailView.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        detailView.titleField.delegate = self
        detailView.memoField.delegate = self
    }
    
    override func configureUI() {
        super.configureUI()
        detailView.titleField.text = todoData?.title
        detailView.memoField.text = todoData?.memo
    }
    
    @objc private func editButtonClicked() {
        print(self, #function, "수정 버튼 클릭")
        // 바뀐 제목/메모 확인
        print("바뀐 제목 확인", detailView.titleField.text)
        print("바뀐 메모 확인", detailView.memoField.text)
        print("todo확인", todoData)
    }
    
}


extension DetailViewController {
    private func setEditBarButton() {
        setBarButton(type: .text, position: .right, title: Constants.Button.edit, image: nil, color: Resources.Color.gray, action: #selector(editButtonClicked))
        let button = navigationItem.rightBarButtonItem
        button?.setTitleTextAttributes(
            [.font: Resources.Font.bold18],
            for: .normal
        )
    }
}

extension DetailViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("텍스트필드 수정 시작!")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("텍스트필드 수정 끝!")
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
            let endDate = todoData?.endDate ?? Date()
            cell.configureDateCellData(title: title, data: endDate)
        } else if section == 1 {
            // 태그
            let tag = todoData?.tag ?? ""
            cell.configureTagCellData(title: title, tag: tag)
        } else if section == 2 {
            // 우선순위 높 보통 낮
            let priority = todoData?.priority ?? 1
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
                try! self.realm.write {
                    self.todoData?.endDate = date ?? Date()
                }
            }
            navigationController?.pushViewController(endDateVC, animated: true)
        } else if section == 1 {
            let tagVC = TagViewController()
            tagVC.sendTag = { tag in
                try! self.realm.write {
                    self.todoData?.tag = tag // String

                }
            }
            navigationController?.pushViewController(tagVC, animated: true)
        } else if section == 2 {
            let priorityVC = PriorityViewController()
            priorityVC.sendPriority = { priority in // Int
                try! self.realm.write {
                    self.todoData?.priority = priority
                }
            }
            navigationController?.pushViewController(priorityVC, animated: true)
        } else {
            showAlert(style: .oneButton, title: "준비 중이에요!", message: nil) { return }
        }
    }
}
