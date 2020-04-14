//
//  TaskListViewController.swift
//  GoodList
//
//  Created by Mohammad Azam on 2/26/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    private let disposeBag = DisposeBag()
    private var tasks = BehaviorRelay<[Task]>(value: [])
    private var filteredTasks = [Task]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true

        prioritySegmentedControl.addTarget(self, action: #selector(priorityValueChanged), for: .valueChanged)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        let task = filteredTasks[indexPath.row]
        cell.textLabel?.text = task.title
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
            let addTaskController = navC.viewControllers.first as? AddTaskViewController else {
            fatalError("Controller not found...")
        }

        addTaskController.taskSubjectObservable
            .subscribe(onNext: { [weak self] task in
                guard let self = self else { return }

                let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
                self.tasks.accept(self.tasks.value + [task])

                self.filterTasks(by: priority)
            })
            .disposed(by: disposeBag)
    }

    @objc private func priorityValueChanged(target: UISegmentedControl) {
        let priority = Priority(rawValue: prioritySegmentedControl.selectedSegmentIndex - 1)
        filterTasks(by: priority)
    }

    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    private func filterTasks(by priority: Priority?) {
        defer {
            updateTableView()
        }

        guard let priority = priority else {
            self.filteredTasks = self.tasks.value
            return
        }

        self.tasks.map { tasks in
            return tasks.filter { $0.priority == priority }
        }
        .subscribe(onNext: { [weak self] tasks in
            self?.filteredTasks = tasks
        })
        .disposed(by: disposeBag)
    }
}
