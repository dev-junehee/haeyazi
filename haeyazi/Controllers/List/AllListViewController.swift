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
    
    let realm = try! Realm()
    var todoList: Results<Todo>?
    
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
        getNotification()
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
    
    @objc private func didDismissAddViewNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            self.allView.tableView.reloadData()
        }
    }
}

extension AllListViewController {
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
        return todoList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.id, for: indexPath) as? TodoTableViewCell else { return TodoTableViewCell() }

        guard let todoList = todoList else {
            print("todoList 오류")
            return cell
        }
        
        let todo = todoList[indexPath.row]
        cell.configureCellData(data: todo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
