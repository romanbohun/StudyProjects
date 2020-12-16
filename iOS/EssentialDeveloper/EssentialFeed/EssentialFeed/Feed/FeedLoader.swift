//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Roman Bogun on 16.12.2020.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
