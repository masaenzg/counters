//
//  CreateItemScreenPresenter.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 28/11/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

final class CreateItemScreenPresenter: CreateItemScreenPresenterProtocol {
    
    weak var view: CreateItemScreenViewProtocol?
    var router: CreateItemScreenRouterProtocol?
    var interactor: CreateItemScreenInteractorProtocol?
    
    func sendToCloseComponent() {
        router?.closeComponent()
    }
}

extension CreateItemScreenPresenter: CreateItemScreenInteractorOutputProtocol {}
