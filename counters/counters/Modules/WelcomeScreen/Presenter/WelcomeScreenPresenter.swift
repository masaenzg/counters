//
//  WelcomeScreenPresenter.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 27/11/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

final class WelcomeScreenPresenter: WelcomeScreenPresenterProtocol {
    
    weak var view: WelcomeScreenViewProtocol?
    var router: WelcomeScreenRouterProtocol?
    var interactor: WelcomeScreenInteractorProtocol?
    
    func getNumberOfRows() -> Int {
        return WelcomeScreenModel.getInformation().count
    }
    
    func getCounterRow(index: Int) -> WelcomeScreenCellModel {
        let arrayInformation = WelcomeScreenModel.getInformation()
        return arrayInformation[index]
    }
    
    func sendToMainScreen() {
        router?.presentMainScreen()
    }
}

extension WelcomeScreenPresenter: WelcomeScreenInteractorOutputProtocol {}
