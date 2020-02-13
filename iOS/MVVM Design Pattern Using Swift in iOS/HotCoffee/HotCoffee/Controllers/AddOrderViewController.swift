//
//  AddOrderViewController.swift
//  HotCoffee
//
//  Created by Mohammad Azam on 5/10/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

class AddOrderViewController: UIViewController {
    
    private var addCoffeeViewModel = AddCoffeeOrderViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    private var coffeeSizesSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        initialize()
    }
    
    private func initialize() {
        coffeeSizesSegmentedControl = UISegmentedControl(items: addCoffeeViewModel.sizes)
        coffeeSizesSegmentedControl?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(coffeeSizesSegmentedControl)
        coffeeSizesSegmentedControl.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20).isActive = true
        coffeeSizesSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

extension AddOrderViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return addCoffeeViewModel.numberOfTypeSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addCoffeeViewModel.numberOfTypeRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableViewCell", for: indexPath)
        
        cell.textLabel?.text = addCoffeeViewModel.types[indexPath.row]
        return cell
    }
    
}

extension AddOrderViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
}

extension AddOrderViewController {
    
    @IBAction func save() {
        let name = nameTextField.text
        let email = emailTextField.text
        
        let selectedSize = coffeeSizesSegmentedControl.titleForSegment(at: coffeeSizesSegmentedControl.selectedSegmentIndex)
        
        guard let indexPath = tableView.indexPathForSelectedRow else {
            fatalError()
        }
        
        addCoffeeViewModel.name = name
        addCoffeeViewModel.email = email
        addCoffeeViewModel.selectSize = selectedSize
        addCoffeeViewModel.selectedType = addCoffeeViewModel.types[indexPath.row]
        
        guard let order = addCoffeeViewModel.orderModel(),
            let addOrderURL = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders"),
            let data = try? JSONEncoder().encode(order) else { return }
        
        var resource = Resource<Order>(url: addOrderURL)
        resource.body = data
        
        WebService().post(resource: resource) { result in
            switch result {
            case .success(let order):
                print(order)
            case .failure(let error):
                print(error)
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
