//
//  CreateItemScreenInteractorTest.swift
//  Counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 7/12/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import XCTest
@testable import Counters

final class CreateItemScreenInteractorTest: XCTestCase {
    
    var mockPresenter: MockPresenter!
    var sut: CreateItemScreenInteractor!
    var mockNetwork: MockNetwork!
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockPresenter()
        mockNetwork = MockNetwork()
        sut = CreateItemScreenInteractor(networkManager: mockNetwork)
        sut.presenter = mockPresenter
    }
    
    override func tearDown() {
        super.tearDown()
        mockPresenter = nil
        mockNetwork = nil
        sut = nil
    }
    
    func test_createItem() {
        mockNetwork.mockData = loadJsonResults()
        
        sut.createItem(itemName: "test")
        
        XCTAssertTrue(mockPresenter.createItemSuccessCalled)
    }
    
    func test_createItem_whenFailed() {
        sut.createItem(itemName: "test")
        
        XCTAssertTrue(mockPresenter.createItemFailedCalled)
    }

    private func loadJsonResults() -> Data? {
        guard let jsonPath = Bundle(for: type(of: self)).url(forResource: "SuccessResponse", withExtension: "json") else {
            XCTFail("Missing file: SuccessResponse.json")
            return nil
        }
        
        return try? Data(contentsOf: jsonPath)
    }
    
    class MockPresenter: CreateItemScreenInteractorOutputProtocol {
        var createItemSuccessCalled = false
        var createItemFailedCalled = false
        
        func createItemSuccess() {
            createItemSuccessCalled = true
        }
        
        func createItemFailed() {
            createItemFailedCalled = true
        }
    }
    
    struct DummyData {
        
    }
}
