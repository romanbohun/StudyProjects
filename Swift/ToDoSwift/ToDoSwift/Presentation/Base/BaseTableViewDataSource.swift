//
//  BaseTableViewDataSource.swift
//  ToDoSwift
//
//  Created by Roman Bogun on 3/15/19.
//  Copyright © 2019 Roman Bogun. All rights reserved.
//

import Foundation
import UIKit

class BaseTableViewDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    typealias T = BaseDataModel
    var tasks: Array<T> = Array<T>()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell? = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: self.getCellIdentifier()) as UITableViewCell? else {
                return UITableViewCell(style: .subtitle, reuseIdentifier: self.getCellIdentifier())
            }

            return cell
        }()
        
        return initCellWithData(forCell: cell!, andIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func initCellWithData(forCell: UITableViewCell, andIndexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    public func getCellIdentifier() -> String {
        return String(describing: type(of: UITableViewCell.self()))
    }
    
    public func getTaskDataModel(_ byIndexPath: IndexPath) -> T {
        return tasks[byIndexPath.row]
    }
}
