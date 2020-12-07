//
//  MainScreenInteractorTest.swift
//  Counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 7/12/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import XCTest
@testable import Counters

final class MainScreenInteractorTest: XCTestCase {
    
    var mockPresenter: MockPresenter!
    var sut: MainScreenInteractor!
    var mockNetwork: MockNetwork!
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockPresenter()
        mockNetwork = MockNetwork()
        sut = MainScreenInteractor(networkManager: mockNetwork)
        sut.presenter = mockPresenter
    }
    
    override func tearDown() {
        super.tearDown()
        mockPresenter = nil
        mockNetwork = nil
        sut = nil
    }
    
    func test_getItems() {
        mockNetwork.mockData = loadJsonResults()
        
        sut.getItems()
        
        XCTAssertTrue(mockPresenter.getItemsSuccessCalled)
    }
    
    func test_getItems_whenFailed() {
        sut.getItems()
        
        XCTAssertTrue(mockPresenter.getItemsErrorCalled)
    }
    
    func test_updateCounter() {
        mockNetwork.mockData = loadJsonResults()
        
        sut.updateCounter(isIncrement: DummyData.isIncrement, idCounter: DummyData.idCounter, indexPath: DummyData.indexPath)
        
        XCTAssertTrue(mockPresenter.updateCounterSuccessCalled)
    }
    
    func test_updateCounter_whenFailed() {
        sut.updateCounter(isIncrement: DummyData.isIncrement, idCounter: DummyData.idCounter, indexPath: DummyData.indexPath)
        
        XCTAssertTrue(mockPresenter.updateCounterErrorCalled)
    }
    
    func test_deleteCounter() {
        mockNetwork.mockData = loadJsonResults()
        
        sut.deleteCounter(idCounter: DummyData.idCounter)
        
        XCTAssertTrue(mockPresenter.deleteCounterSuccessCalled)
    }
    
    func test_deleteCounter_whenFailed() {
        sut.deleteCounter(idCounter: DummyData.idCounter)
        
        XCTAssertTrue(mockPresenter.deleteCounterErrorCalled)
    }
    
    private func loadJsonResults() -> Data? {
        guard let jsonPath = Bundle(for: type(of: self)).url(forResource: "SuccessResponse", withExtension: "json") else {
            XCTFail("Missing file: SuccessResponse.json")
            return nil
        }
        
        return try? Data(contentsOf: jsonPath)
    }
    
    class MockPresenter: MainScreenInteractorOutputProtocol {
        var getItemsSuccessCalled = false
        var getItemsErrorCalled = false
        var updateCounterSuccessCalled = false
        var updateCounterErrorCalled = false
        var deleteCounterSuccessCalled = false
        var deleteCounterErrorCalled = false
        
        func getItemsSuccess(items: [CounterBody]) {
            getItemsSuccessCalled = true
        }
        
        func getItemsError() {
            getItemsErrorCalled = true
        }
        
        func updateCounterSuccess(items: [CounterBody], idCounter: String, indexPath: IndexPath) {
            updateCounterSuccessCalled = true
        }
        
        func updateCounterError(isIncrement: Bool, idCounter: String, indexPath: IndexPath) {
            updateCounterErrorCalled = true
        }
        
        func deleteCounterSuccess(idCounter: String) {
            deleteCounterSuccessCalled = true
        }
        
        func deleteCounterError() {
            deleteCounterErrorCalled = true
        }
    }
    
    struct DummyData {
        static let isIncrement = true
        static let idCounter = "1234"
        static let indexPath = IndexPath()
    }
}
