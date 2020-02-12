//
//  ArticleViewModel.swift
//  GoodNews
//
//  Created by Roman Bogun on 11.02.2020.
//  Copyright © 2020 Roman Bohun. All rights reserved.
//

import Foundation

struct ArticleViewModel {
    
    private let article: Article
    
    var title: String {
        return article.title
    }
    
    var description: String {
        return article.description
    }
    
    init(_ article: Article) {
        self.article = article
    }
    
}
