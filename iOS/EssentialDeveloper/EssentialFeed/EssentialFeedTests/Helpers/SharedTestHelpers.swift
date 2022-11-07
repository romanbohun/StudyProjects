//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Roman Bogun on 07.11.2022.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}
