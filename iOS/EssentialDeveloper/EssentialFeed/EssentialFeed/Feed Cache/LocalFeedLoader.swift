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
    private let calendar = Calendar(identifier: .gregorian)

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
        _store.retrieve { [unowned self] result in
            switch result {
            case let .failure(error):
                self._store.deleteCachedFeed { _ in }
                completion(.failure(error))

            case let .found(feed, timestamp) where self.validate(timestamp):
                completion(.success(feed.toModels()))

            case .found, .empty:
                completion(.success([]))
            }
        }
    }

    private var maxCacheAgeInDays: Int {
        return 7
    }

    private func validate(_ timestamp: Date) -> Bool {
        guard let maxCacheAge = calendar.date(byAdding: .day, value: maxCacheAgeInDays, to: timestamp) else {
            return false
        }
        return _currentDate() < maxCacheAge
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

private extension Array where Element == LocalFeedImage {
    func toModels() -> [FeedImage] {
        return map { FeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url) }
    }
}
