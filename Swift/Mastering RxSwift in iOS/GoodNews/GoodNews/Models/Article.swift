//
//  Article.swift
//  GoodNews
//
//  Created by Mohammad Azam on 3/5/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation

struct ArticlesList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {

    let title: String
    let description: String?

}
