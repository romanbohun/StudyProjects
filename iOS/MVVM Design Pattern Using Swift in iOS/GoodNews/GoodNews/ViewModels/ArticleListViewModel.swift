//
//  ArticleListViewModel.swift
//  GoodNews
//
//  Created by Roman Bogun on 11.02.2020.
//  Copyright © 2020 Roman Bohun. All rights reserved.
//

import Foundation

struct ArticleListViewModel {
    
    let articles: [Article]
    
}

extension ArticleListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfRows: Int {
        return articles.count
    }
    
    func articleAtIndex(_ index: Int) -> ArticleViewModel {
        let article = articles[index]
        return ArticleViewModel(article)
    }
    
}
