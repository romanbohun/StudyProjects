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

    public init(store: FeedStore, currentDate: @escaping () -> Date) {
        _store = store
        _currentDate = currentDate
    }

    public func save(_ items: [FeedItem], completion: @escaping (Error?) -> Void) {
        _store.deleteCachedFeed { [weak self ] error in
            guard let self = self else { return }

            if let cacheDeletionError = error {
                completion(cacheDeletionError)
            } else {
                self.cache(items, completion: completion)
            }
        }
    }

    private func cache(_ items: [FeedItem], completion: @escaping (Error?) -> Void) {
        _store.insert(items, timestamp: _currentDate()) { [weak self] error in
            guard self != nil else { return }
            completion(error)
        }
    }
}
