//
//  CharacterListTests.swift
//  MarvelTests
//
//  Created by Aarón Granado Amores on 21/3/22.
//

import XCTest
@testable import Marvel

class CharacterListTests: MarvelBaseTest {

    var characterListVM: VM?
    var mockedListService: MockedNetService?
    var mockedListManager: MockedServiceManager?
    
    override func setUp() {
        super.setUp()
        
        self.mockedListManager = MockedServiceManager()
        
        self.mockedListService = MockedNetService()
        self.mockedListService?.manager = self.mockedListManager
        
        self.characterListVM = CharacterListVM(service: self.mockedListService!)
    }

    func testGetListSuccess() {
        self.mockedListManager?.inflate(json: "characterList")
        self.characterListVM?.getData()
        
        XCTAssertEqual(self.characterListVM?.data.count ?? 0, 3)
    }
    
    func testGetListFailure() {
        self.mockedListManager?.inflate(json: "empty")
        self.characterListVM?.getData()
        
        XCTAssertTrue(self.characterListVM?.data.isEmpty ?? false)
    }
}
