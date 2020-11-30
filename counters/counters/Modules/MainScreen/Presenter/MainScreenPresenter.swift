//
//  MainScreenPresenter.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 27/11/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

final class MainScreenPresenter: MainScreenPresenterProtocol {
    
    weak var view: MainScreenViewProtocol?
    var router: MainScreenRouterProtocol?
    var interactor: MainScreenInteractorProtocol?
    
    func sendToCreateItem() {
        router?.presentCreateItem()
    }
}

extension MainScreenPresenter: MainScreenInteractorOutputProtocol {}
