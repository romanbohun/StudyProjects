//
//  FeaturedViewController.swift
//  ToDoSwift
//
//  Created by Roman Bogun on 3/15/19.
//  Copyright © 2019 Roman Bogun. All rights reserved.
//

import UIKit

class FeaturedViewController: BaseViewController {

    @IBOutlet weak var taskTableView: UITableView!
    
    private let addBtn: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(gotoAddNewPage))
    private let viewModel: FeaturedViewModel? = FeaturedViewModelFactory().getInstance()
    private let dataSource: FeaturedDataSource = FeaturedDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.initWithTasks()
        initDataSource()
    }
    
    override func getTitleName() -> String {
        return "Featured"
    }
    
    override func initUIPart() {
        super.initUIPart()
        
        self.taskTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        addCreateTaskButton()
    }
    
    private func initDataSource() {
    
        self.dataSource.openTaskDetails = openDetails()
        self.dataSource.deleteTask = deleteTask()
        
        reloadDataSourceWithTasks()
        
        self.taskTableView.dataSource = self.dataSource
        self.taskTableView.delegate = self.dataSource
        self.taskTableView.estimatedRowHeight = 50
    }
    
    private func reloadDataSourceWithTasks() {
        dataSource.tasks.removeAll()
        
        for task in (viewModel?.tasks)! {
            dataSource.tasks.append(task)
        }
    }
    
    private func addCreateTaskButton() {
        resetRightBarButtons()
        
        self.navigationItem.setRightBarButton(addBtn, animated: true)
    }
    
    @objc func gotoAddNewPage(_ sender:UIBarButtonItem!){
        
    }
    
    private func openDetails() -> ((_ model: BaseDataModel) -> Void)? {
        return { [weak self ] BaseDataModel in
            
            let detailsVc = TaskDetailsViewController(nibName: String(describing: type(of: TaskDetailsViewController.self())), bundle: nil)
            self?.navigationController?.pushViewController(detailsVc, animated: true)
        }
    }
    
    private func deleteTask() -> ((_ model: BaseDataModel) -> Void)? {
        return { [weak self ] BaseDataModel in
            
            self?.viewModel?.deleteTask(task: BaseDataModel as! TaskDataModel)
            self?.reloadDataSourceWithTasks()
        }
    }
}
