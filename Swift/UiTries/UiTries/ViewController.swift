//
//  ViewController.swift
//  UiTries
//
//  Created by Roman Bohun on 04.11.2020.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var searchBarContainerInStackView: UIView!
    var statusBarFrame: CGRect!
    var statusBarView: UIView!
    var offset: CGFloat!
    
    var searchBar: RoundedSearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ""
        searchBar = RoundedSearchBar(frame: CGRect(x: 0, y: 0, width: searchBarContainerInStackView.bounds.width, height: 50))
        searchBar.layer.cornerRadius = 25
        searchBar.backgroundColor = .white
        searchBar.layer.shadowRadius = 10
        searchBar.layer.shadowOffset = .zero
        searchBar.layer.shadowOpacity = 0.3
        searchBar.layer.shadowColor = UIColor.gray.cgColor
        searchBar.layer.shadowPath = UIBezierPath(roundedRect: searchBar.bounds, cornerRadius: 25).cgPath

        searchBarContainerInStackView.addSubview(searchBar)

        scrollView.contentInsetAdjustmentBehavior = .never
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.tintColor = .white
        //change title text color to white color
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        
        //required statement to access the scrollViewDidScroll function
        scrollView.delegate = self
        
        //get height of status bar
        if #available(iOS 13.0, *) {
            statusBarFrame = UIApplication.shared.windows[0].windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            // Fallback on earlier versions
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        
        //set status bar with white text
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        
        //initially add a view which overlaps the status bar. Will be altered later.
        statusBarView = UIView(frame: statusBarFrame)
        statusBarView.isOpaque = false
        statusBarView.backgroundColor = .white
        view.addSubview(statusBarView)
        
//        setupSearchBarContainer()
//        customizeSearchField()
    }
    
    // Worked code
    fileprivate func setupSearchBarContainer() {
//        searchBarViewContainer.layer.cornerRadius = 25
//        searchBarViewContainer.backgroundColor = .white
//        searchBarViewContainer.layer.shadowRadius = 10
//        searchBarViewContainer.layer.shadowOffset = .zero
//        searchBarViewContainer.layer.shadowOpacity = 0.3
//        searchBarViewContainer.layer.shadowColor = UIColor.gray.cgColor
//        searchBarViewContainer.layer.shadowPath = UIBezierPath(roundedRect: searchBarViewContainer.bounds, cornerRadius: 25).cgPath
    }
  
    // Worked code
    fileprivate func customizeSearchField(){
//        var searchTextField : UITextField?
//        if #available(iOS 13, *) {
//            searchTextField = searchField.searchTextField
//        } else {
//            if let matchingTextField = searchField.subviews[0].subviews.compactMap ({ $0 as? UITextField }).first {
//                searchTextField = matchingTextField
//            }
//        }
//
//        guard let unwrappedTextField = searchTextField else {
//            return
//        }
//
//        UISearchBar.appearance().setSearchFieldBackgroundImage(UIImage(), for: .normal)
//        searchField.backgroundColor = .white
//        searchField.showsCancelButton = false
//        searchField.searchTextField.clearButtonMode = .never
//        searchField.clipsToBounds = false
//        searchField.layer.cornerRadius = 25
//
//        unwrappedTextField.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            unwrappedTextField.heightAnchor.constraint(equalToConstant: 50),
//            unwrappedTextField.leadingAnchor.constraint(equalTo: searchField.leadingAnchor, constant: 10),
//            unwrappedTextField.trailingAnchor.constraint(equalTo: searchField.trailingAnchor, constant: -10),
//            unwrappedTextField.centerYAnchor.constraint(equalTo: searchField.centerYAnchor, constant: 0)
//        ])
//        unwrappedTextField.clipsToBounds = true
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        offset = scrollView.contentOffset.y / searchBar.bounds.height
        
//        print(String(describing: targetHeight), String(describing: offset))
        
        if offset > 1 { offset = 1 }
        
        //        if offset > 0.5 {
        //            self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        //        } else {
        //            self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        //        }
        
        
        let clearToWhite = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
//        let whiteToBlack = UIColor(hue: 1, saturation: 0, brightness: 1-offset, alpha: 1 )
        
        //        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : whiteToBlack]
        
        if (offset >= 1) {
            if navigationItem.titleView == nil {
                searchBar.removeFromSuperview()
                navigationItem.titleView = searchBar;
                var frame = searchBar.frame
                frame.origin.x = 16
                searchBar.frame = frame
                searchBar.translatesAutoresizingMaskIntoConstraints = true
                searchBar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                navigationController?.navigationBar.backgroundColor = clearToWhite
            }
        } else {
            
            if (navigationItem.titleView != nil) {
                navigationItem.titleView = nil
                searchBarContainerInStackView.addSubview(searchBar)
                navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            let height = CGFloat(72)
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)

    }
}

