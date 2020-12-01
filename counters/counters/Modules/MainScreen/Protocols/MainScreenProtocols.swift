//
//  MainScreenProtocols.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 27/11/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//
import UIKit

protocol MainScreenInteractorProtocol: AnyObject {
    var presenter: MainScreenInteractorOutputProtocol? { get set }
    
    func getItems()
    func updateCounter(isIncrement: Bool, idCounter: String, indexPath: IndexPath)
    func deleteCounter(idCounter: String)
}

protocol MainScreenPresenterProtocol: AnyObject {
    var view: MainScreenViewProtocol? { get set }
    var router: MainScreenRouterProtocol? { get set }
    var interactor: MainScreenInteractorProtocol? { get set }
    
    func loadCounters()
    func sendToCreateItem()
    func getNumberOfRows() -> Int
    func getCounterRow(index: Int) -> MainScreenCellModel
    func addCounter(with index: Int)
    func removeCounter(with index: Int)
    func deleteCounters()
}

protocol MainScreenInteractorOutputProtocol: AnyObject {
    func getItemsSuccess(items: [CounterBody])
    func getItemsError(error: Error)
    func updateCounterSuccess(items: [CounterBody], idCounter: String, indexPath: IndexPath)
    func updateCounterError(error: Error)
    func deleteCounterSuccess()
    func deleteCounterError(error: Error)
}

protocol MainScreenRouterProtocol: AnyObject {
    var viewController: BaseViewController? { get set }
    
    static func createMainScreenModule() -> MainScreenViewController?
    
    func presentCreateItem()
}

protocol MainScreenViewProtocol: AnyObject {
    var presenter: MainScreenPresenterProtocol? { get set }
    
    func updateView()
    func updateCounter(with indexPath: IndexPath)
    func finishEditing()
}
