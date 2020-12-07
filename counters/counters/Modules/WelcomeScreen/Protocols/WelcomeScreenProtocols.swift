//
//  WelcomeScreenProtocols.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 27/11/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//
import UIKit

protocol WelcomeScreenInteractorProtocol: AnyObject {
    var presenter: WelcomeScreenInteractorOutputProtocol? { get set }
}

protocol WelcomeScreenPresenterProtocol: AnyObject {
    var view: WelcomeScreenViewProtocol? { get set }
    var router: WelcomeScreenRouterProtocol? { get set }
    var interactor: WelcomeScreenInteractorProtocol? { get set }
    
    func getNumberOfRows() -> Int
    func getCounterRow(index: Int) -> WelcomeScreenCellModel
    func sendToMainScreen()
}

protocol WelcomeScreenInteractorOutputProtocol: AnyObject {
}

protocol WelcomeScreenRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    
    static func createWelcomeScreenModule() -> WelcomeScreenViewController?
    func presentMainScreen()
}

protocol WelcomeScreenViewProtocol: AnyObject {
    var presenter: WelcomeScreenPresenterProtocol? { get set }
}
