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
    public init(store: FeedStore, currentDate: @escaping () -> Date) {
        _store = store
        _currentDate = currentDate
    }

    public func save(_ items: [FeedImage], completion: @escaping (SaveResult) -> Void) {
        _store.deleteCachedFeed { [weak self ] error in
            guard let self = self else { return }

            if let cacheDeletionError = error {
                completion(cacheDeletionError)
            } else {
                self.cache(items, completion: completion)
            }
        }
    }

    private func cache(_ items: [FeedImage], completion: @escaping (SaveResult) -> Void) {
        _store.insert(items.toLocal(), timestamp: _currentDate()) { [weak self] error in
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
