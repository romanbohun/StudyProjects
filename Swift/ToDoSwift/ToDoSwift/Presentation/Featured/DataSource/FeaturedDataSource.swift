//
//  FeaturedDataSource.swift
//  ToDoSwift
//
//  Created by Roman Bogun on 3/15/19.
//  Copyright © 2019 Roman Bogun. All rights reserved.
//

import Foundation
import UIKit

class FeaturedDataSource: BaseTableViewDataSource {
    
    public var openTaskDetails: ((_ model: BaseDataModel) -> Void)?
    public var markTaskAsDone: ((_ model: BaseDataModel) -> Void)?
    public var deleteTask: ((_ model: BaseDataModel) -> Void)?
    
    override func initCellWithData(forCell: UITableViewCell, andIndexPath: IndexPath) -> UITableViewCell {
        
        let task = tasks[andIndexPath.row] as! TaskDataModel
        
        forCell.textLabel?.text = task.name
        forCell.detailTextLabel?.text = task.descr
        
        return forCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.openTaskDetails!(getTaskDataModel(indexPath))
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let doneAction = UITableViewRowAction(style: .normal, title: "Done" , handler: { [weak self] (action: UITableViewRowAction, indexPath: IndexPath) -> Void in
            
            guard self?.markTaskAsDone != nil else {
                return
            }
            
            
        })
        doneAction.backgroundColor = UIColor.orange

        let deleteAction = UITableViewRowAction(style: .destructive, title: "Remove" , handler: { [weak self] (action: UITableViewRowAction, indexPath: IndexPath) -> Void in
            
            self?.deleteTaskFor(tableView, indexPath)
        })

        return [doneAction, deleteAction].reversed()
    }
    
    private func deleteTaskFor(_ tableView: UITableView,_ indexPath: IndexPath) {
        
        guard self.deleteTask != nil else {
            return
        }
        
        self.deleteTask!(self.getTaskDataModel(indexPath))
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    private func markTaskAsDoneFor(_ tableView: UITableView,_ indexPath: IndexPath) {
        
        guard self.markTaskAsDone != nil else {
            return
        }
        
        self.markTaskAsDone!(self.getTaskDataModel(indexPath))
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
}
