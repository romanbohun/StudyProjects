//
//  WebService.swift
//  GoodNews
//
//  Created by Roman Bogun on 11.02.2020.
//  Copyright © 2020 Roman Bohun. All rights reserved.
//

import Foundation

class WebService {
    
    func getArticles(url: URL, complition: @escaping ([Article]?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                complition(nil)
                return
            }
            
            if let decodedResponse = try? JSONDecoder().decode(ArticleResponse.self, from: data) {
                complition(decodedResponse.articles)
                print(decodedResponse.articles)
            }
        }.resume()
    }
    
}
