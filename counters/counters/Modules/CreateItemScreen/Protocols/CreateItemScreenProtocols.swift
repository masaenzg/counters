//
//  CreateItemScreenProtocols.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 28/11/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

protocol CreateItemScreenInteractorProtocol: AnyObject {
    var presenter: CreateItemScreenInteractorOutputProtocol? { get set }
    func createItem(itemName: String)
}

protocol CreateItemScreenPresenterProtocol: AnyObject {
    var view: CreateItemScreenViewProtocol? { get set }
    var router: CreateItemScreenRouterProtocol? { get set }
    var interactor: CreateItemScreenInteractorProtocol? { get set }
    
    func saveItem(with text: String?)
    func sendToCloseComponent()
}

protocol CreateItemScreenInteractorOutputProtocol: AnyObject {
    func createItemSuccess()
    func createItemFailed()
}

protocol CreateItemScreenRouterProtocol: AnyObject {
    var viewController: BaseViewController? { get set }
    
    static func createCreateItemScreenModule() -> CreateItemScreenViewController?
    func presentAlert(with model: AlertActionModel)
    func closeComponent()
}

protocol CreateItemScreenViewProtocol: AnyObject {
    var presenter: CreateItemScreenPresenterProtocol? { get set }
}
