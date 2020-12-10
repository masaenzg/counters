//
//  MainScreenPresenter.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 27/11/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//
import UIKit

final class MainScreenPresenter: MainScreenPresenterProtocol {
    
    weak var view: MainScreenViewProtocol?
    var router: MainScreenRouterProtocol?
    var interactor: MainScreenInteractorProtocol?
    var counterList: [MainScreenCellModel] = []
    var counterListForDelete: [MainScreenCellModel] = []
    let dispatchGroup = DispatchGroup()
    private var searchingWorkItem: DispatchWorkItem?
    
    func loadCounters() {
        view?.startActivity()
        interactor?.getItems()
    }
    
    func sendToCreateItem() {
        router?.presentCreateItem()
    }
    
    func getNumberOfRows() -> Int {
        return counterList.count
    }
    
    func getCounterRow(index: Int) -> MainScreenCellModel {
        return counterList[index]
    }
    
    func addCounter(with index: Int) {
        let row = counterList[index]
        counterListForDelete.append(row)
    }
    
    func removeCounter(with index: Int) {
        if counterListForDelete.indices.contains(index) {
            counterListForDelete.remove(at: index)
        }
    }
    
    func deleteCounters() {
        counterListForDelete.forEach { [weak self] (model) in
            dispatchGroup.enter()
            self?.interactor?.deleteCounter(idCounter: model.id)
        }
        
        dispatchGroup.notify(queue: .main) {
            self.handleDeleteResponse()
        }
    }
    
    func cleanRowsForDelete() {
        counterListForDelete = []
    }

    func sendToActionSheet() {
        let counterText = counterListForDelete.count == 1 ? AppStrings.MainScreen.counter : AppStrings.MainScreen.counters
        let text = String(format: AppStrings.MainScreen.deleteActionSheetText, counterListForDelete.count, counterText)
        router?.presentActionSheet(with: text, completion: { [weak self] in
            self?.deleteCounters()
        })
    }
    
    func searchCounter(with text: String) {
        searchingWorkItem?.cancel()
        if text.isEmpty {
            view?.resultLabelStatus(with: false)
            loadCounters()
        } else {
            let currentWorkItem = DispatchWorkItem { [weak self] in
                self?.filterCounter(with: text)
            }
            searchingWorkItem = currentWorkItem
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: currentWorkItem)
        }
    }
    
    private func filterCounter(with text: String) {
        counterList = counterList.filter { $0.title.lowercased().contains(text.lowercased()) }
        view?.resultLabelStatus(with: counterList.count == .zero)
        view?.updateView()
    }
    
    private func createViewModel(items: [CounterBody]) {
        counterList = []
        items.forEach { [weak self] (counter) in
            guard let strongSelf = self else { return }
            let cellModel = MainScreenCellModel(id: counter.id,
                                                title: counter.title,
                                                count: counter.count) { [weak self] (isIncrement, indexPath, idCounter) in
                                                    self?.interactor?.updateCounter(isIncrement: isIncrement, idCounter: idCounter, indexPath: indexPath)
                                                    
            }
            strongSelf.counterList.append(cellModel)
        }
    }
    
    private func handleDeleteResponse() {
        if counterListForDelete.isEmpty {
            self.view?.finishEditing()
            self.loadCounters()
        } else if counterListForDelete.count == 1 {
            setDeleteSingleCounterMessage()
        } else {
            sendToAlert(with: AppStrings.Alerts.deleteManyErrorTitle) { [weak self] (_) in
                self?.counterListForDelete.removeAll()
                self?.view?.finishEditing()
                self?.loadCounters()
            }
        }
    }
    
    private func updateDeleteCounters(with idCounter: String) {
        guard let index = counterListForDelete.firstIndex(where: { $0.id == idCounter }) else { return }
        removeCounter(with: index)
    }
    
    private func setDeleteSingleCounterMessage() {
        if counterListForDelete.indices.contains(.zero) {
            let text = String(format: AppStrings.Alerts.deleteErrorTitle, counterListForDelete[.zero].title)
            sendToAlert(with: text) { [weak self] (_) in
                self?.counterListForDelete.removeAll()
                self?.view?.finishEditing()
                self?.loadCounters()
            }
        }
    }
    
    private func sendToAlert(with text: String,
                             rightButtonText: String? = nil,
                             leftButtonText: String = AppStrings.Alerts.dismissOption,
                             closure: ((UIAlertAction) -> Void)?) {
        let model = AlertActionModel(title: text,
                                     message: AppStrings.Alerts.defaultBody,
                                     leftActionClosure: closure,
                                     rightActionText: rightButtonText,
                                     leftActionText: leftButtonText)
        router?.presentAlert(with: model)
    }
    
    
    private func setAlertForEmptyRows() {
        let closure: (() -> Void)? = { [weak self] in
            self?.router?.presentCreateItem()
        }
        let model = AlertCustomViewModel(title: AppStrings.MainScreen.alertEmptyRowsTitle,
                                         message: AppStrings.MainScreen.alertEmptyRowsContent,
                                         buttonTitle: AppStrings.MainScreen.alertEmptyRowsButtonText,
                                         closure: closure)
        view?.showAlerCustomView(with: model)
        view?.loadedInfo(with: false)
    }
    
    private func setAlertForErrorList() {
        let closure: (() -> Void)? = { [weak self] in
            self?.loadCounters()
        }
        let model = AlertCustomViewModel(title: AppStrings.MainScreen.alertLoadFailTitle,
                                         message: AppStrings.MainScreen.alertLoadFailContent,
                                         buttonTitle: AppStrings.MainScreen.alertLoadFailButtonText,
                                         closure: closure)
        view?.showAlerCustomView(with: model)
        view?.loadedInfo(with: false)
    }
}

extension MainScreenPresenter: MainScreenInteractorOutputProtocol {
    func getItemsSuccess(items: [CounterBody]) {
        view?.stopActivity()
        if items.count == 0 {
            setAlertForEmptyRows()
        } else {
            createViewModel(items: items)
            view?.updateView()
            view?.loadedInfo(with: true)
        }
    }
    
    func getItemsError() {
        view?.stopActivity()
        setAlertForErrorList()
    }
    
    func updateCounterSuccess(items: [CounterBody], idCounter: String, indexPath: IndexPath) {
        guard let indexRow = counterList.firstIndex(where: { $0.id == idCounter }) else { return }
        let updatedRow = items.filter({ $0.id == idCounter })
        counterList[indexRow].count = updatedRow[0].count
        view?.updateCounter(with: indexPath)
    }
    
    func updateCounterError(isIncrement: Bool, idCounter: String, indexPath: IndexPath) {
        guard let indexRow = counterList.firstIndex(where: { $0.id == idCounter }) else { return }
        let row = counterList[indexRow]
        let value = isIncrement ? (row.count + 1) : (row.count - 1)
        let title = String(format: AppStrings.Alerts.updateErrorTitle, row.title, value)
        sendToAlert(with: title,
                    rightButtonText: AppStrings.Alerts.dismissOption,
                    leftButtonText: AppStrings.Alerts.retryOption) { [weak self] (_) in
                        self?.interactor?.updateCounter(isIncrement: isIncrement, idCounter: idCounter, indexPath: indexPath)
        }
    }
    
    func deleteCounterSuccess(idCounter: String) {
        dispatchGroup.leave()
        updateDeleteCounters(with: idCounter)
    }
    
    func deleteCounterError() {
        dispatchGroup.leave()
    }
}
