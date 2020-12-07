//
//  MockNetwork.swift
//  CountersTests
//
//  Created by Manuel Adolfo Saenz Grijalba on 7/12/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import Foundation
@testable import Counters

class MockNetwork: CounterAPIProtocol {
    var mockData: Data? = nil
    func request<T>(serviceResponse: Response<T>, route: EndPoint, completion: @escaping (Result<T, Error>) -> Void) {
        completion(
            Result {
                guard let data = mockData else {
                    throw ErrorAPI.notDataFound
                }
                if let dataParsed = try? serviceResponse.content(data) {
                    return dataParsed
                } else {
                    throw ErrorAPI.unableParse
                }
            }
        )
    }

    class FakeDataTask: URLSessionTask {
        override init() { }
    }
}
