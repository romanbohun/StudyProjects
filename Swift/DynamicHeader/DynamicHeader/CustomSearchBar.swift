//
//  CustomSearchBar.swift
//  DynamicHeader
//
//  Created by Roman Bohun on 05.11.2020.
//

import UIKit
import Foundation

open class CustomSearchBar: UIControl {
    
    private let searchBar: UISearchBar = {
        let searchControl = UISearchBar(frame: .zero)
        searchControl.placeholder = "Your text here"
        searchControl.searchBarStyle = .minimal
        searchControl.translatesAutoresizingMaskIntoConstraints = false
        
        var searchTextField : UITextField?
        if #available(iOS 13, *) {
            searchTextField = searchControl.searchTextField
        } else {
            if let matchingTextField = searchControl.subviews[0].subviews.compactMap ({ $0 as? UITextField }).first {
                searchTextField = matchingTextField
            }
        }
        
        if let unwrappedTextField = searchTextField {
            UISearchBar.appearance().setSearchFieldBackgroundImage(UIImage(), for: .normal)
            searchControl.backgroundColor = .white
            searchControl.showsCancelButton = false
            searchControl.searchTextField.clearButtonMode = .never
            searchControl.clipsToBounds = false
            searchControl.layer.cornerRadius = 25
            
            unwrappedTextField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                unwrappedTextField.heightAnchor.constraint(equalToConstant: 50),
                unwrappedTextField.leadingAnchor.constraint(equalTo: searchControl.leadingAnchor, constant: 10),
                unwrappedTextField.trailingAnchor.constraint(equalTo: searchControl.trailingAnchor, constant: -10),
                unwrappedTextField.centerYAnchor.constraint(equalTo: searchControl.centerYAnchor, constant: 0)
            ])
            unwrappedTextField.clipsToBounds = true
        }
        return searchControl
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
//    open override func didMoveToSuperview() {
//        super.didMoveToSuperview()
//
//        guard let unwrappedSuperView = superview else {
//            return
//        }
//        translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            leadingAnchor.constraint(equalTo: unwrappedSuperView.leadingAnchor),
//            unwrappedSuperView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            topAnchor.constraint(equalTo: unwrappedSuperView.topAnchor),
//            unwrappedSuperView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            centerXAnchor.constraint(equalTo: unwrappedSuperView.centerXAnchor),
//            centerYAnchor.constraint(equalTo: unwrappedSuperView.centerYAnchor),
//            heightAnchor.constraint(equalToConstant: frame.height)
//        ])
//    }

    private func initialize() {
        addSubview(searchBar)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 25
        backgroundColor = .white
        
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: self.topAnchor),
            self.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor),
            searchBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            searchBar.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}
