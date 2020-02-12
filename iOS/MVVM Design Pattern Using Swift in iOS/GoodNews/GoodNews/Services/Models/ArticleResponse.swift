//
//  ArticleResponse.swift
//  GoodNews
//
//  Created by Roman Bogun on 11.02.2020.
//  Copyright © 2020 Roman Bohun. All rights reserved.
//

import Foundation

struct ArticleResponse: Decodable {
    
    let articles: [Article]?
    
}
