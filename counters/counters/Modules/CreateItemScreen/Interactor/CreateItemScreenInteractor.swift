//
//  CreateItemScreenInteractor.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 28/11/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import Foundation

final class CreateItemScreenInteractor: CreateItemScreenInteractorProtocol {
    weak var presenter: CreateItemScreenInteractorOutputProtocol?
    var networkManager: CounterAPIProtocol?
    
    init(networkManager: CounterAPIProtocol? = CounterAPI()) {
        self.networkManager = networkManager
    }
    
    func createItem(itemName: String) {
        let content: (Data) throws -> [CounterBody] = { data in
            return try JSONDecoder().decode([CounterBody].self, from: data)
        }
        let result = Response(content: content)
        let request = CounterCreate(title: itemName)
        networkManager?.request(serviceResponse: result,
                                route: Networking.baseOperation((method: .post, request: request)) ,
                                completion: { [weak self] (result) in
                                    switch result {
                                    case .success(_):
                                        self?.presenter?.createItemSuccess()
                                    case .failure(let error):
                                        self?.presenter?.createItemFailed(error: error)
                                    }
                                    
        })
    }
}
