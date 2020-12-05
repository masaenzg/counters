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
    var counterInternetError = 0
    var counterDeleteError = 0
    
    func loadCounters() {
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
            self.view?.finishEditing()
            self.loadCounters()
        }
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
}

extension MainScreenPresenter: MainScreenInteractorOutputProtocol {
    func getItemsSuccess(items: [CounterBody]) {
        createViewModel(items: items)
        view?.updateView()
    }
    
    func getItemsError(error: Error) {
        
    }
    
    func updateCounterSuccess(items: [CounterBody], idCounter: String, indexPath: IndexPath) {
        guard let indexRow = counterList.firstIndex(where: { $0.id == idCounter }) else { return }
        let updatedRow = items.filter({ $0.id == idCounter })
        counterList[indexRow].count = updatedRow[0].count
        view?.updateCounter(with: indexPath)
    }
    
    func updateCounterError(error: Error) {
        
    }
    
    func deleteCounterSuccess() {
        dispatchGroup.leave()
    }
    
    func deleteCounterError(error: Error) {
        if case ErrorAPI.internetConnectionFailed = error {
            counterInternetError += 1
        } else {
            counterDeleteError += 1
        }
        dispatchGroup.leave()
    }
}
