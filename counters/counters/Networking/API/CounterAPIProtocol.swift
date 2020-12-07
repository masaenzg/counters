//
//  CounterAPIProtocol.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 30/11/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import Foundation

protocol CounterAPIProtocol {
    func request<T>(serviceResponse: Response<T>, route: EndPoint, completion: @escaping (Result<T,Error>) -> Void)
}
