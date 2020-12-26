//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Roman Bogun on 26.12.2020.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
