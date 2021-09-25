//
//  FeedItemMapper.swift
//  EssentialFeed
//
//  Created by Roman Bogun on 26.12.2020.
//

import Foundation

struct RemoteFeedItem: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL

//    var item: FeedItem {
//        return FeedItem(
//            id: id,
//            description: description,
//            location: location,
//            imageURL: image
//        )
//    }
}


internal final class FeedItemMapper {

    private struct Root: Decodable {
        let items: [RemoteFeedItem]
    }

    private static let OK_200: Int = 200

    internal static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem] {
        guard response.statusCode == OK_200,
              let decodedRootData = try? JSONDecoder().decode(Root.self, from: data) else {
            throw RemoteFeedLoader.Error.invalidData
        }
        return decodedRootData.items
    }
}
