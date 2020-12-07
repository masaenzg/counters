//
//  MainScreenPresenterTest.swift
//  Counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 7/12/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import XCTest
@testable import Counters

final class MainScreenPresenterTest: XCTestCase {
    
    var mockView: MockView!
    var mockRouter: MockRouter!
    var mockInteractor: MockInteractor!
    var sut: MainScreenPresenter!
    
    override func setUp() {
        super.setUp()
        mockView = MockView()
        mockRouter = MockRouter()
        mockInteractor = MockInteractor()
        sut = MainScreenPresenter()
        sut.view = mockView
        sut.router = mockRouter
        sut.interactor = mockInteractor
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        mockRouter = nil
        mockInteractor = nil
        sut = nil
    }
    
    func test_loadCounters() {
        sut.loadCounters()
        
        XCTAssertTrue(mockView.startActivityCalled)
        XCTAssertTrue(mockInteractor.getItemsCalled)
    }
    
    func test_sendToCreateItem() {
        sut.sendToCreateItem()
        
        XCTAssertTrue(mockRouter.presentCreateItemCalled)
    }
    
    func test_getNumberOfRows() {
        sut.counterList = DummyData.list
        
        let rows = sut.getNumberOfRows()
        
        XCTAssertGreaterThanOrEqual(rows, 0)
    }
    
    func test_getCounterRow() {
        sut.counterList = DummyData.list
        
        let row = sut.getCounterRow(index: 0)
        
        XCTAssertNotNil(row)
    }
    
    func test_addCounter() {
        sut.counterList = DummyData.list
        
        sut.addCounter(with: 0)
        
        XCTAssertGreaterThanOrEqual(sut.counterListForDelete.count, 0)
    }
    
    func test_removeCounter() {
        sut.counterListForDelete = DummyData.list
        
        sut.removeCounter(with: 0)
        
        XCTAssertEqual(sut.counterListForDelete.count, 2)
    }
    
    func test_deleteCounters() {
        sut.counterListForDelete = DummyData.list
        
        sut.deleteCounters()
        
        
        XCTAssertTrue(mockInteractor.deleteCounterCalled)
    }
    
    func test_sendToActionSheet() {
        sut.sendToActionSheet()
        
        XCTAssertTrue(mockRouter.presentActionSheetCalled)
    }
    
    func test_getItemsSuccess_whenIsEmpty() {
        sut.getItemsSuccess(items: [])
        
        XCTAssertTrue(mockView.stopActivityCalled)
        XCTAssertTrue(mockView.showAlerCustomViewCalled)
    }
    
    func test_getItemsSuccess() {
        sut.getItemsSuccess(items: DummyData.listBody)
        
        XCTAssertTrue(mockView.stopActivityCalled)
        XCTAssertTrue(mockView.loadedInfoCalled)
        XCTAssertTrue(mockView.updateViewCalled)
    }
    
    func test_getItemsError() {
        sut.getItemsError()
        
        XCTAssertTrue(mockView.stopActivityCalled)
        XCTAssertTrue(mockView.showAlerCustomViewCalled)
    }
    
    func test_updateCounterSuccess() {
        sut.counterList = DummyData.list
        
        sut.updateCounterSuccess(items: DummyData.listBody, idCounter: DummyData.idCounter, indexPath: DummyData.indexPath)
        
        XCTAssertTrue(mockView.updateCounterCalled)
    }
    
    func test_updateCounterError() {
        sut.counterList = DummyData.list
        
        sut.updateCounterError(isIncrement: DummyData.isIncrement, idCounter: DummyData.idCounter, indexPath: DummyData.indexPath)
        
        XCTAssertTrue(mockRouter.presentAlertCalled)
    }
    
    class MockView: MainScreenViewProtocol {
        var presenter: MainScreenPresenterProtocol?
        var updateViewCalled = false
        var updateCounterCalled = false
        var finishEditingCalled = false
        var showAlerCustomViewCalled = false
        var resultLabelStatusCalled = false
        var loadedInfoCalled = false
        var startActivityCalled = false
        var stopActivityCalled = false
        
        func updateView() {
            updateViewCalled = true
        }
        
        func updateCounter(with indexPath: IndexPath) {
            updateCounterCalled = true
        }
        
        func finishEditing() {
            finishEditingCalled = true
        }
        
        func showAlerCustomView(with model: AlertCustomViewModel) {
            showAlerCustomViewCalled = true
        }
        
        func resultLabelStatus(with isVivible: Bool) {
            resultLabelStatusCalled = true
        }
        
        func loadedInfo(with isLoaded: Bool) {
            loadedInfoCalled = true
        }
        
        func startActivity() {
            startActivityCalled = true
        }
        
        func stopActivity() {
            stopActivityCalled = true
        }
    }
    
    class MockRouter: MainScreenRouterProtocol {
        var viewController: BaseViewController?
        var presentCreateItemCalled = false
        var presentActionSheetCalled = false
        var presentAlertCalled = false
        
        static func createMainScreenModule() -> MainScreenViewController? {
            return MainScreenViewController()
        }
        
        func presentCreateItem() {
            presentCreateItemCalled = true
        }
        
        func presentActionSheet(with text: String, completion: (() -> Void)?) {
            presentActionSheetCalled = true
        }
        
        func presentAlert(with model: AlertActionModel) {
            presentAlertCalled = true
        }
    }
    
    class MockInteractor: MainScreenInteractorProtocol {
        var presenter: MainScreenInteractorOutputProtocol?
        var getItemsCalled = false
        var updateCounterCalled = false
        var deleteCounterCalled = false
        
        func getItems() {
            getItemsCalled = true
        }
        
        func updateCounter(isIncrement: Bool, idCounter: String, indexPath: IndexPath) {
            updateCounterCalled = true
        }
        
        func deleteCounter(idCounter: String) {
            deleteCounterCalled = true
        }
    }
    
    struct DummyData {
        static let counterOne = MainScreenCellModel(id: "1234", title: "Demo", count: 2, updateClosure: nil)
        static let counterTwo = MainScreenCellModel(id: "Demo", title: "Demo", count: 1, updateClosure: nil)
        static let counterThree = MainScreenCellModel(id: "Demo", title: "Demo", count: 3, updateClosure: nil)
        static let list = [counterOne, counterTwo, counterThree]
        static let listBody = [CounterBody(id: "1234", title: "Demo", count: 1)]
        static let isIncrement = true
        static let idCounter = "1234"
        static let indexPath = IndexPath()
    }
}
