//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Roman Bogun on 16.12.2020.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
