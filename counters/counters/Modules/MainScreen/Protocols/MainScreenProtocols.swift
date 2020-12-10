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
    func cleanRowsForDelete()
    func sendToActionSheet()
    func searchCounter(with text: String)
}

protocol MainScreenInteractorOutputProtocol: AnyObject {
    func getItemsSuccess(items: [CounterBody])
    func getItemsError()
    func updateCounterSuccess(items: [CounterBody], idCounter: String, indexPath: IndexPath)
    func updateCounterError(isIncrement: Bool, idCounter: String, indexPath: IndexPath)
    func deleteCounterSuccess(idCounter: String)
    func deleteCounterError()
}

protocol MainScreenRouterProtocol: AnyObject {
    var viewController: BaseViewController? { get set }
    
    static func createMainScreenModule() -> MainScreenViewController?
    
    func presentCreateItem()
    func presentActionSheet(with text: String, completion: (() -> Void)?)
    func presentAlert(with model: AlertActionModel)
}

protocol MainScreenViewProtocol: AnyObject {
    var presenter: MainScreenPresenterProtocol? { get set }
    
    func updateView()
    func updateCounter(with indexPath: IndexPath)
    func finishEditing()
    func showAlerCustomView(with model: AlertCustomViewModel)
    func resultLabelStatus(with isVivible: Bool)
    func loadedInfo(with isLoaded: Bool)
    func startActivity()
    func stopActivity()
}
