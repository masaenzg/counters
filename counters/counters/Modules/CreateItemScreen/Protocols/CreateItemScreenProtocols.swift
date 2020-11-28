//
//  CreateItemScreenProtocols.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 28/11/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

protocol CreateItemScreenInteractorProtocol: AnyObject {
    var presenter: CreateItemScreenInteractorOutputProtocol? { get set }
}

protocol CreateItemScreenPresenterProtocol: AnyObject {
    var view: CreateItemScreenViewProtocol? { get set }
    var router: CreateItemScreenRouterProtocol? { get set }
    var interactor: CreateItemScreenInteractorProtocol? { get set }
}

protocol CreateItemScreenInteractorOutputProtocol: AnyObject {
}

protocol CreateItemScreenRouterProtocol: AnyObject {
    var viewController: BaseViewController? { get set }
    
    static func createCreateItemScreenModule() -> CreateItemScreenViewController?
}

protocol CreateItemScreenViewProtocol: AnyObject {
    var presenter: CreateItemScreenPresenterProtocol? { get set }
}
