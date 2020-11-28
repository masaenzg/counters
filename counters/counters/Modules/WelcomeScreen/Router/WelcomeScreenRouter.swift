//
//  WelcomeScreenRouter.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 27/11/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

final class WelcomeScreenRouter: WelcomeScreenRouterProtocol {
    
    weak var viewController: BaseViewController?
    
    static func createWelcomeScreenModule() -> WelcomeScreenViewController? {
        guard let ref = WelcomeScreenViewController.instantiate(from: .welcomeScreen) else { return nil } 
        
        let presenter: WelcomeScreenPresenterProtocol & WelcomeScreenInteractorOutputProtocol = WelcomeScreenPresenter()
        
        let router = WelcomeScreenRouter()
        router.viewController = ref
        
        let interactor = WelcomeScreenInteractor()
        interactor.presenter = presenter
        
        presenter.view = ref
        presenter.router = router
        presenter.interactor = interactor
        
        ref.presenter = presenter
        return ref
    }
}

