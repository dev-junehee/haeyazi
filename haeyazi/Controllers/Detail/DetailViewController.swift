//
//  DetailViewController.swift
//  haeyazi
//
//  Created by junehee on 7/3/24.
//

import UIKit

class DetailViewController: BaseViewController {
    
    let detailView = DetailView()
    
//    var title: String?
//    var memo: String?
    
    var todoData: Todo?
    
    var isEdit = false
    
    override func loadView() {
        self.view = detailView
    }
    
    override func configureController() {
        super.configureController()
        navigationItem.title = "상세정보"
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
    
    @objc private func editButtonClicked() {
        print(self, #function, "수정 버튼 클릭")
    }
}


extension DetailViewController {
    private func setEditBarButton() {
        setBarButton(type: .text, position: .right, title: "수정", image: nil, color: Resources.Color.gray, action: #selector(editButtonClicked))
        let button = navigationItem.rightBarButtonItem
        button?.isHidden = true
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
}
