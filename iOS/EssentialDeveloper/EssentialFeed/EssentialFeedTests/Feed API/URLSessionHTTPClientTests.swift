//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Roman Bogun on 02.03.2021.
//

import XCTest

public class URLSessionHTTPClient {
    private let _session: URLSession

    init(session: URLSession) {
        _session = session
    }

    func get(from url: URL) {
        _session.dataTask(with: url) { data, response, error in }
    }
}

class URLSessionHTTPClientTests: XCTestCase {

    func test_getFromURL_createsDataTaskWithURL() {
        let url = URL(string: "http://any-url.com")!
        let session = URLSessionSpy()
        let sut = URLSessionHTTPClient(session: session)

        sut.get(from: url)

        XCTAssertEqual(session.receivedURLs, [url])
    }

    //MARK: - Helpers
    private class URLSessionSpy: URLSession {
        var receivedURLs = [URL]()

        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            receivedURLs.append(url)

            return FakeURLSessionDataTask()
        }
    }

    private class FakeURLSessionDataTask : URLSessionDataTask {}

}
