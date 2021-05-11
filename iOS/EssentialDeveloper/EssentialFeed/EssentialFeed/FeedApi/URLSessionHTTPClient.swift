//
//  URLSessionHTTPClient.swift
//  EssentialFeed
//
//  Created by Roman Bogun on 11.05.2021.
//

public class URLSessionHTTPClient: HTTPClient {

    private let _session: URLSession

    public init(session: URLSession = .shared) {
        _session = session
    }

    private struct UnexpectedValuesRepresentation: Error {}

    public func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        _session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            } else {
                completion(.failure(UnexpectedValuesRepresentation()))
            }
        }.resume()
    }

}
