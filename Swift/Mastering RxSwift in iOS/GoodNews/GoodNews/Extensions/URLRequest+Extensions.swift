//
//  URLRequest+Extensions.swift
//  GoodNews
//
//  Created by Roman Bogun on 07.04.2020.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource<T: Decodable> {
    let url: URL

    init(_ url: URL) {
        self.url = url
    }
}

extension URLRequest {

    static func load<T>(resource: Resource<T>) -> Observable<T?> {
        return Observable.from([resource.url])
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> T? in
                return try? JSONDecoder().decode(T.self, from: data)

        }.asObservable()

    }

}
