//
//  ViewController.swift
//  DynamicHeader
//
//  Created by Roman Bohun on 05.11.2020.
//

import UIKit

class ViewController: UIViewController {

    fileprivate let spacing = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    fileprivate let horizontalItemSpacing: CGFloat = 8
//    fileprivate let generalSpacing: CGFloat = 16
    
    // MARK: - Header setup
    fileprivate let minHeaderHeight: CGFloat = 83
    fileprivate let maxHeaderHeight: CGFloat = 134
    
    fileprivate let headerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    fileprivate lazy var bottomBorder: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    fileprivate weak var headerHeightConstraint: NSLayoutConstraint!
        
    
    // MARK: - TableView setup
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - Top StackView
    fileprivate lazy var topStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = horizontalItemSpacing
        stackView.isUserInteractionEnabled = true
        return stackView
    }()

    fileprivate lazy var topStackBackgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    fileprivate weak var topStackBackgroundViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - SearchBar setup
    fileprivate var searchBar: CustomSearchBar!
    fileprivate let searchBarHeight: CGFloat = 50
    
    // MARK: - Round button
    fileprivate lazy var roundButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.setTitle("B", for: .normal)
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 50),
        ])
        return button
    }()
    
    // MARK: - Bottom StackView
    fileprivate lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = horizontalItemSpacing
        stackView.isUserInteractionEnabled = true
        let borderColor = UIColor(red: 229/255, green: 228/255, blue: 229/255, alpha: 1)
        let titleColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1)
        for index in 0..<3 {
            let button = UIButton(type: .system)
            button.setTitleColor(titleColor, for: .normal)
            button.setTitleColor(titleColor, for: .highlighted)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.borderWidth = 1
            button.layer.borderColor = borderColor.cgColor
            button.setTitle("index \(index + 1)", for: .normal)
            button.layer.cornerRadius = 10
            
            stackView.addArrangedSubview(button)
        }
        
        return stackView
    }()
    fileprivate weak var bottomStackViewBottomHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Scroll
    fileprivate var previousScrollOffset: CGFloat = 0
    fileprivate var previousScrollViewHeight: CGFloat = 0
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    fileprivate func initialize() {
        view.backgroundColor = .white
        
        view.addSubview(headerView)
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: maxHeaderHeight)
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            headerHeightConstraint
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
        
        headerView.addSubview(bottomBorder)
        NSLayoutConstraint.activate([
            bottomBorder.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: bottomBorder.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: bottomBorder.bottomAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        searchBar = CustomSearchBar(frame: CGRect(x: 0, y: 0, width: headerView.bounds.width, height: searchBarHeight))
        searchBar.layer.cornerRadius = 25
        searchBar.backgroundColor = .clear
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.gray.cgColor
        searchBar.layer.shadowRadius = 10
        searchBar.layer.shadowOffset = .zero
        searchBar.layer.shadowOpacity = 0.3
        searchBar.layer.shadowColor = UIColor.gray.cgColor
        searchBar.layer.shadowPath = UIBezierPath(roundedRect: searchBar.bounds, cornerRadius: 25).cgPath
        
        headerView.addSubview(topStackBackgroundView)
        NSLayoutConstraint.activate([
            topStackBackgroundView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            topStackBackgroundView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 24),
            headerView.trailingAnchor.constraint(equalTo: topStackBackgroundView.trailingAnchor),
            topStackBackgroundView.heightAnchor.constraint(equalToConstant: searchBarHeight + spacing.bottom)
        ])
        
        topStackBackgroundView.addSubview(topStackView)
        NSLayoutConstraint.activate([
            topStackView.leadingAnchor.constraint(equalTo: topStackBackgroundView.leadingAnchor, constant: spacing.left),
            topStackView.topAnchor.constraint(equalTo: topStackBackgroundView.topAnchor),
            topStackBackgroundView.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor, constant: spacing.right),
            topStackBackgroundView.bottomAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: spacing.bottom),
        ])
        
        topStackView.addArrangedSubview(searchBar)
        topStackView.addArrangedSubview(roundButton)
        
        headerView.addSubview(bottomStackView)
        bottomStackViewBottomHeightConstraint = headerView.bottomAnchor.constraint(equalTo: bottomStackView.bottomAnchor, constant: spacing.bottom)
        NSLayoutConstraint.activate([
            bottomStackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: spacing.left),
            headerView.trailingAnchor.constraint(equalTo: bottomStackView.trailingAnchor, constant: spacing.right),
            bottomStackViewBottomHeightConstraint,
            bottomStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        headerView.bringSubviewToFront(topStackBackgroundView)
        headerView.sendSubviewToBack(bottomStackView)
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Cell index -> \(indexPath.row)"
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        defer {
            self.previousScrollViewHeight = scrollView.contentSize.height
            self.previousScrollOffset = scrollView.contentOffset.y
        }
        
        let heightDiff = scrollView.contentSize.height - self.previousScrollViewHeight
        let scrollDiff = (scrollView.contentOffset.y - self.previousScrollOffset)
        
        guard heightDiff == 0 else { return }
        
        let absoluteTop: CGFloat = 0;
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;

        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
        
        var newHeight = self.headerHeightConstraint.constant
        if isScrollingDown {
            newHeight = max(self.minHeaderHeight, self.headerHeightConstraint.constant - abs(scrollDiff))
        } else if isScrollingUp {
            newHeight = min(self.maxHeaderHeight, self.headerHeightConstraint.constant + abs(scrollDiff))
        }
        
        if newHeight != self.headerHeightConstraint.constant {
            headerHeightConstraint.constant = newHeight
            updateHeader(height: newHeight)
            setScrollPosition(previousScrollOffset)
        }
    }
    
    func setScrollPosition(_ position: CGFloat) {
        self.tableView.contentOffset = CGPoint(x: self.tableView.contentOffset.x, y: position)
    }
    
    fileprivate func updateHeader(height: CGFloat) {
        let percent: CGFloat = (maxHeaderHeight - height) / (maxHeaderHeight - minHeaderHeight)
//        print("Percent -> \(percent)")
        let colorToClear = UIColor(red: 229/255, green: 228/255, blue: 229/255, alpha: 1 - percent)
        let titleColotToClear = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1 - percent)
        let clearToColor = UIColor(red: 229/255, green: 228/255, blue: 229/255, alpha: percent)
        bottomBorder.backgroundColor = clearToColor
        for item in bottomStackView.arrangedSubviews.enumerated() {
            if let unwrappedButton = item.element as? UIButton {
                unwrappedButton.layer.borderColor = colorToClear.cgColor
                unwrappedButton.setTitleColor(titleColotToClear, for: .normal)
                unwrappedButton.setTitleColor(titleColotToClear, for: .highlighted)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = UIViewController(nibName: nil, bundle: nil)
        viewController.title = "Cell index \(indexPath.row)"
        viewController.view.backgroundColor = .red
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
