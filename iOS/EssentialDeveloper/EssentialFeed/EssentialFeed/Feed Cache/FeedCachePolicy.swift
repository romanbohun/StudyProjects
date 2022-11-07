//
//  FeedCachePolicy.swift
//  EssentialFeed
//
//  Created by Roman Bogun on 07.11.2022.
//

import Foundation

final class FeedCachePolicy {
    private init() {}

    private static let _calendar = Calendar(identifier: .gregorian)

    private static var maxCacheAgeInDays: Int {
        return 7
    }

    static func validate(_ timestamp: Date, against date: Date) -> Bool {
        guard let maxCacheAge = _calendar.date(byAdding: .day, value: maxCacheAgeInDays, to: timestamp) else {
            return false
        }
        return date < maxCacheAge
    }
}
