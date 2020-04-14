//
//  NewsTableViewController.swift
//  GoodNews
//
//  Created by Mohammad Azam on 3/3/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {

    let disposeBag = DisposeBag()

    private var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true

        populateNews()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return self.articles.count
       }

       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

           guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
               fatalError("ArticleTableViewCell does not exist")
           }

           cell.titleLabel.text = self.articles[indexPath.row].title
           cell.descriptionLabel.text = self.articles[indexPath.row].description

           return cell

       }
    
//    private func populateNews() {
//        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=645e1a4b6a2c43fa9c138a83791e269a")!
//
//        Observable.just(url)
//            .flatMap { url -> Observable<Data> in
//                let request = URLRequest(url: url)
//                return URLSession.shared.rx.data(request: request)
//        }.map { data -> [Article]? in
//            return try? JSONDecoder().decode(ArticlesList.self, from: data).articles
//        }.subscribe(onNext: { [weak self] articles in
//            guard let articles = articles else {
//                return
//            }
//            self?.articles = articles
//            DispatchQueue.main.async {
//                self?.tableView.reloadData()
//            }
//        }).disposed(by: disposeBag)
//    }

    private func populateNews() {

        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=645e1a4b6a2c43fa9c138a83791e269a")!

        let resource = Resource<ArticlesList>(url)
        URLRequest.load(resource: resource)
            .subscribe(onNext: { [weak self] result in
                guard let self = self, let result = result else { return }
                self.articles = result.articles

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }
    
}
