//
//  CounterAPI.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 30/11/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import Foundation

class CounterAPI: CounterAPIProtocol {
    func request<T>(serviceResponse: Response<T>, route: EndPoint, completion: @escaping (Result<T,Error>) -> Void) {
        if !Reachability.isConnectedToNetwork() {
            completion(Result { throw ErrorAPI.internetConnectionFailed })
        }
        let request = setupRequest(with: route)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.manageResponse(data: data, response: serviceResponse, completion: completion)
            }
        }
        task.resume()
    }
    
    func request<T>(serviceResponse: Response<T>, route: EndPoint, group: DispatchGroup, completion: @escaping (Error?) -> Void) {
        if !Reachability.isConnectedToNetwork() {
            completion(ErrorAPI.internetConnectionFailed)
        }
        let request = setupRequest(with: route)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            group.leave()
        }
        task.resume()
    }
    
    private func setupRequest(with route: EndPoint) -> URLRequest {
        let url = route.baseUrl.appendingPathComponent(route.path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = route.method.rawValue
        urlRequest.httpBody = route.method == .get ? nil : route.data
        urlRequest.allHTTPHeaderFields = route.headers
        return urlRequest
    }
    
    private func manageResponse<T>(data: Data?, response: Response<T>, completion: @escaping (Result<T,Error>) -> Void) {
        completion(
            Result {
                guard let data = data else {
                    throw ErrorAPI.notDataFount
                }
                if let dataParsed = try? response.content(data) {
                    return dataParsed
                } else {
                    throw ErrorAPI.unableParse
                }
            }
        )
    }
}
