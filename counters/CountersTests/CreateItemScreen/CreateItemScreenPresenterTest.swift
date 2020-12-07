//
//  CreateItemScreenPresenterTest.swift
//  Counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 7/12/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import XCTest
@testable import Counters

final class CreateItemScreenPresenterTest: XCTestCase {
    
    var mockView: MockView!
    var mockRouter: MockRouter!
    var mockInteractor: MockInteractor!
    var sut: CreateItemScreenPresenter!
    
    override func setUp() {
        super.setUp()
        mockView = MockView()
        mockRouter = MockRouter()
        mockInteractor = MockInteractor()
        sut = CreateItemScreenPresenter()
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
    
    func test_saveItem() {
        sut.saveItem(with: DummyData.itemText)
        
        XCTAssertTrue(mockInteractor.createItemCalled)
    }
    
    func test_sendToCloseComponent() {
        sut.sendToCloseComponent()
        
        XCTAssertTrue(mockRouter.closeComponentCalled)
    }
    
    func test_createItemSuccess() {
        sut.createItemSuccess()
        
        XCTAssertTrue(mockRouter.closeComponentCalled)
    }
    
    func test_createItemFailed() {
        sut.createItemFailed()
        
        XCTAssertTrue(mockRouter.presentAlertCalled)
    }
    
    class MockView: CreateItemScreenViewProtocol {
        var presenter: CreateItemScreenPresenterProtocol?
    }
    
    class MockRouter: CreateItemScreenRouterProtocol {
        var viewController: BaseViewController?
        var presentAlertCalled = false
        var closeComponentCalled = false
        
        static func createCreateItemScreenModule() -> CreateItemScreenViewController? {
            return CreateItemScreenViewController()
        }
        
        func presentAlert(with model: AlertActionModel) {
            presentAlertCalled = true
        }
        
        func closeComponent() {
            closeComponentCalled = true
        }
    }
    
    class MockInteractor: CreateItemScreenInteractorProtocol {
        var presenter: CreateItemScreenInteractorOutputProtocol?
        var createItemCalled = false
        
        func createItem(itemName: String) {
            createItemCalled = true
        }
    }
    
    struct DummyData {
        static let itemText = "Demo Counter"
    }
}
