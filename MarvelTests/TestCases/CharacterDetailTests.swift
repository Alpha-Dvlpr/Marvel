//
//  CharacterDetailTests.swift
//  MarvelTests
//
//  Created by Aarón Granado Amores on 21/3/22.
//

import XCTest
@testable import Marvel

class CharacterDetailTests: MarvelBaseTest {

    var characterDetailVM: VM?
    var mockedDetailService: MockedNetService?
    var mockedDetailManager: MockedServiceManager?
    
    override func setUp() {
        super.setUp()
        
        self.mockedDetailManager = MockedServiceManager()
        
        self.mockedDetailService = MockedNetService()
        self.mockedDetailService?.manager = self.mockedDetailManager
        
        self.characterDetailVM = DetailVM(characterID: 1011198, services: self.mockedDetailService!)
    }

    func testGetCharacterDataSuccess() {
        self.mockedDetailManager?.inflate(json: "character")
        self.characterDetailVM?.getData()
        
        XCTAssertNotNil(self.characterDetailVM?.data.first)
    }
    
    func testGetCharacterDataFailure() {
        self.mockedDetailManager?.inflate(json: "empty")
        self.characterDetailVM?.getData()
        
        XCTAssertNil(self.characterDetailVM?.data.first)
    }
    
    func testGetCharacterElementSuccess() {
        self.mockedDetailManager?.inflate(json: "story")
        self.characterDetailVM?.getData(for: "") { (story, error) in
            XCTAssertNotNil(story)
            XCTAssertNil(error)
        }
    }
    
    func testGetCharacterElementFailure() {
        self.mockedDetailManager?.inflate(json: "empty")
        self.characterDetailVM?.getData(for: "") { (story, error) in
            XCTAssertNil(story)
            XCTAssertNotNil(error)
        }
    }
}
