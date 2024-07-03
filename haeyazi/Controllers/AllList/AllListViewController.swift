//
//  AllListViewController.swift
//  haeyazi
//
//  Created by junehee on 7/2/24.
//

import UIKit
import RealmSwift

final class AllListViewController: BaseViewController {
    
    private let allView = AllListView()
    
    private let realm = try! Realm()
    private var todoList: Results<Todo>! {
        didSet {
            allView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = allView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        todoList = realm.objects(Todo.self)
        allView.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self, #function, "스키마 버전 확인", realm.configuration.schemaVersion)
        getNotification()
    }
    
    override func configureController() {
        setBarButtons()
        setSortPullDownButton()
    
        allView.tableView.delegate = self
        allView.tableView.dataSource = self
        allView.tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.id)
        allView.tableView.rowHeight = 80
    }
    
//    @objc private func addButtonClicked() {
//        print(AllListViewController.id, #function, "추가 버튼 클릭")
//        let addVC = UINavigationController(rootViewController: AddViewController())
//        present(addVC, animated: true)
//    }
    
    @objc private func backBarButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    // dismiss 알림오면 테이블뷰 리로드
    @objc private func didDismissAddViewNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            self.allView.tableView.reloadData()
        }
    }
}


extension AllListViewController {
    private func setBarButtons() {
//        setBarButton(type: .image, position: .left, title: nil, image: Resources.SystemImage.add, color: nil, action: #selector(addButtonClicked))
        setBarButton(type: .image, position: .left, title: nil, image: Resources.SystemImage.left, color: nil, action: #selector(backBarButtonClicked))
        setBarButton(type: .image, position: .right, title: nil, image: Resources.SystemImage.sort, color: nil, action: nil)
    }
    
    private func setSortPullDownButton() {
        guard let sortButton = navigationItem.rightBarButtonItem else { return }
        
        let sortedTitle = UIAction(title: "제목순", image: Resources.SystemImage.text) { _ in
            self.todoList = self.realm.objects(Todo.self).sorted(byKeyPath: "title", ascending: true)
        }
        let sortedDate = UIAction(title: "마감일순", image: Resources.SystemImage.calendar) { _ in
            self.todoList = self.realm.objects(Todo.self).sorted(byKeyPath: "regDate", ascending: true)
        }
        let sortedPriority = UIAction(title: "우선순위 높은순", image: Resources.SystemImage.priority) { _ in
            self.showAlert(style: .oneButton, title: "준비 중인 기능이에요!", message: nil) { return }
        }
        
        sortButton.menu = UIMenu(image: nil, identifier:  nil, options: .displayInline, children: [sortedTitle,sortedDate, sortedPriority])
    }
    
    // AddViewController에서 dismiss 알림 받기
    private func getNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didDismissAddViewNotification(_:)),
            name: NSNotification.Name(AddViewController.id),
            object: nil
        )
    }
}


extension AllListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.id, for: indexPath) as? TodoTableViewCell else { return TodoTableViewCell() }

        let todo = todoList[indexPath.row]
        cell.configureCellData(data: todo)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let todo = todoList[indexPath.row]
        
        let done = UIContextualAction(style: .normal, title: todo.isDone ? "미완료" : "완료") { _, _, completionHandler in
            try! self.realm.write {
                todo.isDone = !todo.isDone
                if let cell = tableView.cellForRow(at: indexPath) as? TodoTableViewCell {
                    cell.updateDoneButtonUI(isDone: todo.isDone)
                }
            }
            completionHandler(true)
            self.allView.tableView.reloadData()
        }
        
        let delete = UIContextualAction(style: .destructive, title: "삭제" ) { _, _, _ in
            try! self.realm.write {
                self.realm.delete(todo)
            }
            self.allView.tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [delete, done])
    }
}
