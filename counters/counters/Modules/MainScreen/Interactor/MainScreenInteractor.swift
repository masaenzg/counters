//
//  MainScreenInteractor.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 27/11/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//
import Foundation

final class MainScreenInteractor: MainScreenInteractorProtocol {
    weak var presenter: MainScreenInteractorOutputProtocol?
    var networkManager: CounterAPIProtocol?
    
    init(networkManager: CounterAPIProtocol? = CounterAPI()) {
        self.networkManager = networkManager
    }
    
    func getItems() {
        let content: (Data) throws -> [CounterBody] = { data in
            return try JSONDecoder().decode([CounterBody].self, from: data)
        }
        let result = Response(content: content)
        networkManager?.request(serviceResponse: result,
                                route: Networking.listCounters ,
                                completion: { [weak self] (result) in
                                    switch result {
                                    case .success(let response):
                                        self?.presenter?.getItemsSuccess(items: response)
                                    case .failure(let error):
                                        self?.presenter?.getItemsError(error: error)
                                    }
                                    
        })
    }
    
    func updateCounter(isIncrement: Bool, idCounter: String, indexPath: IndexPath) {
        let content: (Data) throws -> [CounterBody] = { data in
            return try JSONDecoder().decode([CounterBody].self, from: data)
        }
        let request = CounterUpdate(id: idCounter)
        let endPoint = isIncrement ? Networking.increment(request: request) : Networking.decrement(request: request)
        let result = Response(content: content)
        networkManager?.request(serviceResponse: result,
                                route: endPoint,
                                completion: { [weak self] (result) in
                                    switch result {
                                    case .success(let response):
                                        self?.presenter?.updateCounterSuccess(items: response, idCounter: idCounter, indexPath: indexPath)
                                    case .failure(let error):
                                        self?.presenter?.updateCounterError(error: error)
                                    }
                                    
        })
    }
    
    func deleteCounter(idCounter: String) {
        let content: (Data) throws -> [CounterBody] = { data in
            return try JSONDecoder().decode([CounterBody].self, from: data)
        }
        let request = CounterUpdate(id: idCounter)
        let result = Response(content: content)
        networkManager?.request(serviceResponse: result,
                                route: Networking.baseOperation((method: .delete, request: request)),
                                completion: { [weak self] (result) in
                                    switch result {
                                    case .success(_):
                                        self?.presenter?.deleteCounterSuccess()
                                    case .failure(let error):
                                        self?.presenter?.deleteCounterError(error: error)
                                    }
                                    
        })
    }
}


