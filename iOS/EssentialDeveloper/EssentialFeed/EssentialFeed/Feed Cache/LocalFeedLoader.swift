//
//  LocalFeedLoader.swift
//  EssentialFeed
//
//  Created by Roman Bogun on 25.09.2021.
//

import Foundation

public final class LocalFeedLoader {
    private let _store: FeedStore
    private let _currentDate: () -> Date

    public typealias SaveResult = Error?
    public typealias LoadResult = LoadFeedResult
    public init(store: FeedStore, currentDate: @escaping () -> Date) {
        _store = store
        _currentDate = currentDate
    }

    public func save(_ feed: [FeedImage], completion: @escaping (SaveResult) -> Void) {
        _store.deleteCachedFeed { [weak self ] error in
            guard let self = self else { return }

            if let cacheDeletionError = error {
                completion(cacheDeletionError)
            } else {
                self.cache(feed, completion: completion)
            }
        }
    }

    public func load(completion: @escaping (LoadResult) -> Void) {
        _store.retrieve { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success([]))
            }
        }
    }
    
    private func cache(_ feed: [FeedImage], completion: @escaping (SaveResult) -> Void) {
        _store.insert(feed.toLocal(), timestamp: _currentDate()) { [weak self] error in
            guard self != nil else { return }
            completion(error)
        }
    }

}

private extension Array where Element == FeedImage {
    func toLocal() -> [LocalFeedImage] {
        return map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, imageURL: $0.url) }
    }
}
