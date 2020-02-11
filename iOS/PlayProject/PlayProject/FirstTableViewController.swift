//
//  FirstTableViewController.swift
//  PlayProject
//
//  Created by Roman Bogun on 7/19/19.
//  Copyright © 2019 Roman Bohun. All rights reserved.
//

import Foundation
import UIKit

class FirstTableViewController: UITableViewController {
    
    private var data: Array<String> = Array<String>()
    
    override func viewDidLoad() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Insert", style: UIBarButtonItem.Style.plain, target: self, action: #selector(insertNewData))
        
        self.tableView.tableFooterView = UIView();
//        self.tableView.isEditing = true
        self.tableView.estimatedRowHeight = 44
        
        data.append("Title 1")
        data.append("Title 2")
        data.append("Title 3")
        data.append("Title 4")
        
        tableViewInitWithGestures()

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell") as! TitleTableViewCell
        
        cell.title.text = self.data[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "This is the Footer"
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        view.backgroundColor = UIColor.groupTableViewBackground
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.darkGray
        
        switch section {
        case 0:
            label.text = "Header title"
            label.frame = view.frame
            label.textAlignment = .center
            label.textColor = UIColor.red
        default:
            label.frame = CGRect.zero
        }
        
        view.addSubview(label)
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    //MARK: - Editing
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            deleteRow(indexPath: indexPath)
        default:
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: UITableViewRowAction.Style.normal, title: "Edit") { (action, indexPath) in
            
        }
        
        editAction.backgroundColor = UIColor.yellow
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowAction.Style.destructive, title: "Remove") {
            [weak self] (action, indexPath) in
            
            self?.deleteRow(indexPath: indexPath)
        }
        
        return [deleteAction, editAction]
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        showAlert(for: indexPath)
//    }
    
    func deleteRow(indexPath: IndexPath) {
        self.data.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
    }
    
    @objc func insertNewData() {
        let newString = "Title \(self.data.count + 1)"
        
        self.data.append(newString)
        self.tableView.insertRows(at: [IndexPath(row: self.data.count - 1, section: 0)], with: UITableView.RowAnimation.middle)
    }
    
    private func tableViewInitWithGestures() {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(sender:)))
        doubleTapGesture.numberOfTapsRequired = 2
        self.tableView.addGestureRecognizer(doubleTapGesture)
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(sender:)))
        singleTapGesture.numberOfTapsRequired = 1
        singleTapGesture.require(toFail: doubleTapGesture)
        self.tableView.addGestureRecognizer(singleTapGesture)
    }
    
    @objc private func handleDoubleTap(sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: self.tableView)
        if let indexPath = self.tableView.indexPathForRow(at: touchPoint) {
            showAlert(for: indexPath)
        }
    }
    
    @objc private func handleSingleTap(sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: self.tableView)
        if let indexPath = self.tableView.indexPathForRow(at: touchPoint) {
            showAlert(for: indexPath)
        }
    }
    
    private func showAlert(for indexPath: IndexPath) {
        let alert = UIAlertController(title: "Action", message: "Row \(indexPath.row) is tapped", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
    }
}
