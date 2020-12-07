//
//  CreateItemScreenRouter.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 28/11/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

final class CreateItemScreenRouter: CreateItemScreenRouterProtocol {
    
    weak var viewController: BaseViewController?
    
    static func createCreateItemScreenModule() -> CreateItemScreenViewController? {
        guard let ref = CreateItemScreenViewController.instantiate(from: .createItemScreen) else { return nil }
        
        let presenter: CreateItemScreenPresenterProtocol & CreateItemScreenInteractorOutputProtocol = CreateItemScreenPresenter()
        
        let router = CreateItemScreenRouter()
        router.viewController = ref
        
        let interactor = CreateItemScreenInteractor()
        interactor.presenter = presenter
        
        presenter.view = ref
        presenter.router = router
        presenter.interactor = interactor
        
        ref.presenter = presenter
        return ref
    }
    
    func presentAlert(with model: AlertActionModel) {
        viewController?.showAlert(with: model)
    }
    
    func closeComponent() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}

