//
//  WelcomeScreenPresenterTest.swift
//  Counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 7/12/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import XCTest
@testable import Counters

final class WelcomeScreenPresenterTest: XCTestCase {
    
    var mockView: MockView!
    var mockRouter: MockRouter!
    var mockInteractor: MockInteractor!
    var sut: WelcomeScreenPresenter!
    
    override func setUp() {
        super.setUp()
        mockView = MockView()
        mockRouter = MockRouter()
        mockInteractor = MockInteractor()
        sut = WelcomeScreenPresenter()
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
    
    func test_getNumberOfRows() {
        let numberOfRows = sut.getNumberOfRows()
        
        XCTAssertEqual(numberOfRows, 3)
    }
    
    func test_getCounterRow() {
        let row = sut.getCounterRow(index: 0)
        
        XCTAssertNotNil(row)
    }
    
    func test_sendToMainScreen() {
        sut.sendToMainScreen()
        
        XCTAssertTrue(mockRouter.presentMainScreenCalled)
    }
    
    class MockView: WelcomeScreenViewProtocol {
        var presenter: WelcomeScreenPresenterProtocol?
    }
    
    class MockRouter: WelcomeScreenRouterProtocol {
        var viewController: UIViewController?
        var presentMainScreenCalled = false
        
        static func createWelcomeScreenModule() -> WelcomeScreenViewController? {
            return WelcomeScreenViewController()
        }
        
        func presentMainScreen() {
            presentMainScreenCalled = true
        }
    }
    
    class MockInteractor: WelcomeScreenInteractorProtocol {
        var presenter: WelcomeScreenInteractorOutputProtocol?
    }
    
    struct DummyData {
        
    }
}
