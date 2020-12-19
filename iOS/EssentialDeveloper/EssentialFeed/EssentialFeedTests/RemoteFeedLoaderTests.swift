//
//  EssentialFeedTests.swift
//  EssentialFeedTests
//
//  Created by Roman Bogun on 16.12.2020.
//

import XCTest
@testable import EssentialFeed

class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSut()

        XCTAssertTrue(client.requestedURLs.isEmpty)
    }

    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://a-given-url.com")
        let (sut, client) = makeSut(url: url!)

        sut.load { _ in }

        XCTAssertEqual(client.requestedURLs, [url])
    }

    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")
        let (sut, client) = makeSut(url: url!)

        sut.load { _ in }
        sut.load { _ in }

        XCTAssertEqual(client.requestedURLs, [url, url])
    }

    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSut()

        var capturedError = [RemoteFeedLoader.Error]()
        sut.load { error in
            capturedError.append(error)
        }

        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError)

        XCTAssertEqual(capturedError, [.connectivity])
    }

    func test_load_deliversErrorOnNon200HTTPReponse() {
        let (sut, client) = makeSut()

        var capturedError = [RemoteFeedLoader.Error]()
        sut.load { error in
            capturedError.append(error)
        }

        client.complete(with: 400)

        XCTAssertEqual(capturedError, [.invalidData])
    }

    // MARK: - Helpers

    private func makeSut(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }

    private class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL, completion: (Error?, HTTPURLResponse?) -> Void)]()

        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }
        func get(from url: URL, completion: @escaping (Error?, HTTPURLResponse?) -> Void) {
            messages.append((url, completion))
        }

        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(error, nil)
        }

        func complete(with statusCode: Int, at index: Int = 0 ) {
            let response = HTTPURLResponse(
                url: requestedURLs[index],
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil
            )

            messages[index].completion(nil, response)
        }

    }
}
