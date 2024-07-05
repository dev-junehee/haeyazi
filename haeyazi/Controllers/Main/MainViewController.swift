//
//  MainViewController.swift
//  haeyazi
//
//  Created by junehee on 7/3/24.
//

import UIKit
import RealmSwift

enum MainTodoListType: String, CaseIterable {
    case today = "오늘"
    case plan = "예정"
    case all = "전체"
    case priority = "중요한 일"
    case complete = "완료"
    
    var color: UIColor {
        switch self {
        case .today:
            return .systemBlue
        case .plan:
            return .systemRed
        case .all:
            return .systemGray
        case .priority:
            return .systemYellow
        case .complete:
            return .systemGray
        }
    }
    
    var icon: UIImage {
        switch self {
        case .today:
            return Resources.SystemImage.calendar
        case .plan:
            return Resources.SystemImage.paperplane
        case .all:
            return Resources.SystemImage.tray
        case .priority:
            return Resources.SystemImage.flag
        case .complete:
            return Resources.SystemImage.checkmark
        }
    }
}

final class MainViewController: BaseViewController {
    
    private let mainView = MainView()
    
    private let repository = TodoTableRepository()
    var todoList: Results<Todo>? {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNotification()
        mainView.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTodoList()
//        getNotification()
    }
    
    override func configureController() {
        navigationController?.isToolbarHidden = false
        setToolBarButtons()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.id)
    }
    
    private func getTodoList() {
        todoList = repository.getAllTodo()
    }
    
    private func getNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didDismissAddViewNotification(_:)),
            name: NSNotification.Name(AddViewController.id),
            object: nil
        )
    }
    
    // dismiss 알림오면 테이블뷰 리로드
    @objc private func didDismissAddViewNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            self.mainView.collectionView.reloadData()
        }
    }
    
}


extension MainViewController {
    func setToolBarButtons() {
        let addTodoButton = UIBarButtonItem(title: Constants.Button.new, image: Resources.SystemImage.add, target: self, action: #selector(addButtonClicked))
        let addListButton = UIBarButtonItem(title: Constants.Button.list, style: .plain, target: self, action: #selector(listButtonClicked))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        navigationController?.toolbar.tintColor = Resources.Color.primary
        toolbarItems = [addTodoButton, flexibleSpace, addListButton]
    }
    
    @objc private func addButtonClicked() {
        print(ListViewController.id, #function, "추가 버튼 클릭")
        let addVC = UINavigationController(rootViewController: AddViewController())
        present(addVC, animated: true)
    }
    
    @objc private func listButtonClicked() {
        print(self, #function)
        showAlert(style: .oneButton, title: "준비 중이에요!", message: nil) { return }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MainTodoListType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.id, for: indexPath) as? MainCollectionViewCell else { return MainCollectionViewCell() }

        let item = indexPath.item
        
        let type = MainTodoListType.allCases[item]
        var count = 0
        
        switch type {
        case .today:
            count = self.repository.getTodayTodo(sort: true).count
        case .plan:
            count = self.repository.getTodayTodo(sort: false).count
        case .all:
            count = self.repository.getAllTodo().count
        case .priority:
            count = self.repository.getPriorityTodo(priority: 0).count
        case .complete:
            count = self.repository.getCompleteTodo(status: true).count
        }
        
        cell.configureCellData(
            title: MainTodoListType.allCases[item].rawValue,
            image: MainTodoListType.allCases[item].icon,
            color: MainTodoListType.allCases[item].color,
            count: count
        )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = indexPath.item
        let type = MainTodoListType.allCases[item]
        
        let listVC = ListViewController()
        
        switch type {
        case .today:
            listVC.todoList = self.repository.getTodayTodo(sort: true)
        case .plan:
            listVC.todoList = self.repository.getTodayTodo(sort: false)
        case .all:
            listVC.todoList = self.repository.getAllTodo()
        case .priority:
            listVC.todoList = self.repository.getPriorityTodo(priority: 0)
        case .complete:
            listVC.todoList = self.repository.getCompleteTodo(status: true)
        }
        
        listVC.listType = MainTodoListType.allCases[item]
        navigationController?.pushViewController(listVC, animated: true)
    }
}
