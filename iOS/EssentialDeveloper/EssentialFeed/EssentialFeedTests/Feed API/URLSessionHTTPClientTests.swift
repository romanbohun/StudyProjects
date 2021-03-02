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
        _session.dataTask(with: url) { data, response, error in }.resume()
    }
}

class URLSessionHTTPClientTests: XCTestCase {

    func test_getFromURL_resumesDataTaskWithURL() {
        let url = URL(string: "http://any-url.com")!
        let session = URLSessionSpy()
        let task = URLSessionDataTaskSpy()
        session.stub(url: url, task: task)
        let sut = URLSessionHTTPClient(session: session)

        sut.get(from: url)

        XCTAssertEqual(task.resumeCallCount, 1)
    }

    //MARK: - Helpers
    private class URLSessionSpy: URLSession {
        private var _stubs = [URL: URLSessionDataTask]()

        func stub(url: URL, task: URLSessionDataTask) {
            _stubs[url] = task
        }
        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            return _stubs[url] ?? FakeURLSessionDataTask()
        }
    }

    private class FakeURLSessionDataTask : URLSessionDataTask {
        override func resume() {}
    }
    private class URLSessionDataTaskSpy : URLSessionDataTask {
        var resumeCallCount = 0

        override func resume() {
            resumeCallCount += 1
        }
    }

}
