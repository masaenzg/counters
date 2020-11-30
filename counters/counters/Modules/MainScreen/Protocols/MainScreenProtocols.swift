//
//  MainScreenProtocols.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 27/11/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

protocol MainScreenInteractorProtocol: AnyObject {
    var presenter: MainScreenInteractorOutputProtocol? { get set }
}

protocol MainScreenPresenterProtocol: AnyObject {
    var view: MainScreenViewProtocol? { get set }
    var router: MainScreenRouterProtocol? { get set }
    var interactor: MainScreenInteractorProtocol? { get set }
    
    func sendToCreateItem()
}

protocol MainScreenInteractorOutputProtocol: AnyObject {
}

protocol MainScreenRouterProtocol: AnyObject {
    var viewController: BaseViewController? { get set }
    
    static func createMainScreenModule() -> MainScreenViewController?
    
    func presentCreateItem()
}

protocol MainScreenViewProtocol: AnyObject {
    var presenter: MainScreenPresenterProtocol? { get set }
}
