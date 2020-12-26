//
//  FeedItemMapper.swift
//  EssentialFeed
//
//  Created by Roman Bogun on 26.12.2020.
//

import Foundation

internal final class FeedItemMapper {

    private struct Root: Decodable {
        let items: [Item]

        var feed: [FeedItem] {
            return items.map({ $0.item })
        }
    }

    private struct Item: Decodable {
        let id: UUID
        let description: String?
        let location: String?
        let image: URL

        var item: FeedItem {
            return FeedItem(
                id: id,
                description: description,
                location: location,
                imageURL: image
            )
        }
    }

    private static let OK_200: Int = 200

    internal static func map(_ data: Data, from response: HTTPURLResponse) -> RemoteFeedLoader.Result {
        guard response.statusCode == OK_200,
              let decodedRootData = try? JSONDecoder().decode(Root.self, from: data) else {
            return .failure(.invalidData)
        }
        return .success(decodedRootData.feed)
    }
}
