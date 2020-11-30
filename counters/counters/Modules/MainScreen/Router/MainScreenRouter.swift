//
//  MainScreenRouter.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 27/11/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

final class MainScreenRouter: MainScreenRouterProtocol {
    
    weak var viewController: BaseViewController?
    
    static func createMainScreenModule() -> MainScreenViewController? {
        guard let ref = MainScreenViewController.instantiate(from: .mainScreen) else { return nil }
        
        let presenter: MainScreenPresenterProtocol & MainScreenInteractorOutputProtocol = MainScreenPresenter()
        
        let router = MainScreenRouter()
        router.viewController = ref
        
        let interactor = MainScreenInteractor()
        interactor.presenter = presenter
        
        presenter.view = ref
        presenter.router = router
        presenter.interactor = interactor
        
        ref.presenter = presenter
        return ref
    }
    
    func presentCreateItem() {
        guard let createItemScreen = CreateItemScreenRouter.createCreateItemScreenModule() else { return }
        viewController?.navigationController?.pushViewController(createItemScreen, animated: true)
    }
}

