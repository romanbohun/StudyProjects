//
//  LocalFeedItem.swift
//  EssentialFeed
//
//  Created by Roman Bogun on 25.09.2021.
//

import Foundation

public struct LocalFeedImage: Equatable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let url: URL

    public init(
        id: UUID,
        description: String?,
        location: String?,
        imageURL: URL
    ) {
        self.id = id
        self.description = description
        self.location = location
        self.url = imageURL
    }
}
