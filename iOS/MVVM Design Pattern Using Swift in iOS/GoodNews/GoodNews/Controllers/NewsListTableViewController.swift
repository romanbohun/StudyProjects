//
//  NewsListTableViewController.swift
//  GoodNews
//
//  Created by Roman Bogun on 11.02.2020.
//  Copyright © 2020 Roman Bohun. All rights reserved.
//

import UIKit

class NewsListTableViewController: UITableViewController {
    
    private var articleListViewModel: ArticleListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "GoodNews"
        initialize()
    }
    
    private func initialize() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        if let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=645e1a4b6a2c43fa9c138a83791e269a") {
            WebService().getArticles(url: url) { articles in
                
                if let articles = articles {
                    self.articleListViewModel = ArticleListViewModel(articles: articles)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
}

// MARK: - Table view data source
extension NewsListTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = articleListViewModel else {
            return 0
        }
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = articleListViewModel else {
            return 0
        }
        return viewModel.numberOfRows
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError()
        }
        
        if let articleViewModel = articleListViewModel?.articleAtIndex(indexPath.row) {
            cell.titleLabel.text = articleViewModel.title
            cell.descriptionLabel.text = articleViewModel.description
        }
        return cell
    }
    
}
