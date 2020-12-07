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
    
    func saveItem(with text: String?) {
        guard let text = text else { return }
        interactor?.createItem(itemName: text)
    }
    
    func sendToCloseComponent() {
        router?.closeComponent()
    }
}

extension CreateItemScreenPresenter: CreateItemScreenInteractorOutputProtocol {
    func createItemSuccess() {
        router?.closeComponent()
    }
    
    func createItemFailed() {
        let model = AlertActionModel(title: AppStrings.Alerts.createErrorTitle,
                                     message: AppStrings.Alerts.defaultBody,
                                     leftActionText: AppStrings.Alerts.dismissOption)
        router?.presentAlert(with: model)
    }
}
