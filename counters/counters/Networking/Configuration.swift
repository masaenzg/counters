//
//  Configuration.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 30/11/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

struct Response<T> {
    var content: (Data) throws -> T
}

protocol EndPoint {
    var baseUrl: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var data: Data? { get }
}

extension EndPoint {
   var baseUrl: URL {
        guard let url = URL(string: "http://localhost:3000") else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var headers: HTTPHeaders?{
        return ["Content-Type": "application/json"]
    }
    
    func shouldEncodeData(request: Encodable?) -> Data? {
        guard let request = request else {
            return nil
        }
        return request.encode()
    }
}


enum Networking: EndPoint {
    case baseOperation((method: HTTPMethod, request: Encodable?))
    case increment(request: Encodable)
    case decrement(request: Encodable)
    case listCounters
    
    var path: String {
        switch self {
        case .baseOperation:
            return "/api/v1/counter"
        case .increment:
            return "/api/v1/counter/inc"
        case .decrement:
            return "/api/v1/counter/dec"
        case .listCounters:
            return "/api/v1/counters"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .baseOperation(let parameters):
            return parameters.method
        case .increment,
             .decrement:
            return .post
        case .listCounters:
            return .get
        }
    }
    
    var data: Data? {
        switch self {
        case .baseOperation(let parameters):
            return shouldEncodeData(request: parameters.request)
        case .increment(let request):
            return request.encode()
        case .decrement(let request):
            return request.encode()
        case .listCounters:
            return nil
        }
    }
}
