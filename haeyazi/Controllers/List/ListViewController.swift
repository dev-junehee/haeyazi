//
//  AllListViewController.swift
//  haeyazi
//
//  Created by junehee on 7/2/24.
//

import UIKit
import RealmSwift

final class ListViewController: BaseViewController {
    
    private let listView = ListView()
    
    private let realm = try! Realm()
    private let repository = TodoTableRepository()
    
    var listType: MainTodoListType = .all
    
    var todoList: Results<Todo>? {
        didSet {
            listView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = listView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listView.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 스키마 버전 확인
        repository.getSchemaVersion()
        getNotification()
    }
    
    override func configureController() {
        setBarButtons()
        setSortPullDownButton()
    
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
        listView.tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.id)
        listView.tableView.rowHeight = 80
    }
    
    override func configureUI() {
        super.configureUI()
        listView.titleLabel.text = listType.rawValue
    }
    
    @objc private func backBarButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
}


extension ListViewController {
    private func setBarButtons() {
        setBarButton(type: .image, position: .left, title: nil, image: Resources.SystemImage.left, color: nil, action: #selector(backBarButtonClicked))
        setBarButton(type: .image, position: .right, title: nil, image: Resources.SystemImage.sort, color: nil, action: nil)
    }
    
    private func setSortPullDownButton() {
        guard let sortButton = navigationItem.rightBarButtonItem else { return }
        guard let todoList = todoList else { return }
        
        let sortedTitle = UIAction(title: Constants.AllList.Sort.title, image: Resources.SystemImage.text) { _ in
            self.todoList = self.repository.getSortedTodo(target: todoList, key: "title", ascending: true)
        }
        let sortedDate = UIAction(title: Constants.AllList.Sort.date, image: Resources.SystemImage.calendar) { _ in
            self.todoList = self.repository.getSortedTodo(target: todoList, key: "endDate", ascending: true)
        }
        let sortedPriority = UIAction(title: Constants.AllList.Sort.priority, image: Resources.SystemImage.priority) { _ in
            self.todoList = self.repository.getSortedTodo(target: todoList, key: "priority", ascending: true)
        }
        
        sortButton.menu = UIMenu(image: nil, identifier:  nil, options: .displayInline, children: [sortedTitle,sortedDate, sortedPriority])
    }
    
    // AddViewController에서 dismiss 알림 받기
    private func getNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didDismissViewNotification(_:)),
            name: NSNotification.Name(AddViewController.id),
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didDismissViewNotification(_:)),
            name: NSNotification.Name(DetailViewController.id),
            object: nil
        )
    }
    
    // dismiss 알림오면 테이블뷰 리로드
    @objc private func didDismissViewNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            self.listView.tableView.reloadData()
        }
    }
    
}


extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.id, for: indexPath) as? TodoTableViewCell else { return TodoTableViewCell() }

        if let todoList = todoList {
            let todo = todoList[indexPath.row]
            cell.configureCellData(data: todo)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let todo = todoList?[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.todoData = todo
        present(UINavigationController(rootViewController: detailVC), animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let todoList = todoList else {
            return UISwipeActionsConfiguration(actions: [])
        }
        
        let todo = todoList[indexPath.row]
        
        let done = UIContextualAction(style: .normal, title: todo.isDone ? Constants.Button.incomplete : Constants.Button.complete) { _, _, completionHandler in
            try! self.realm.write {
                todo.isDone = !todo.isDone
                if let cell = tableView.cellForRow(at: indexPath) as? TodoTableViewCell {
                    cell.updateDoneButtonUI(isDone: todo.isDone)
                }
            }
            completionHandler(true)
            self.listView.tableView.reloadData()
        }
        
        let delete = UIContextualAction(style: .destructive, title: Constants.Button.delete ) { _, _, _ in
            try! self.realm.write {
                self.realm.delete(todo)
            }
            self.listView.tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [delete, done])
    }
}
