//
//  CharacterUseCaseTest.swift
//  Yasir TaskTests
//
//  Created by Amr Adel on 24/12/2024.
//

import XCTest
@testable import Yasir_Task

class CharacterUseCaseTests: XCTestCase {
    // MARK: - Properties
    var useCase: CharacterUseCase!
    var mockRepo: MockCharactersRepo!
    
    override func setUp() {
        super.setUp()
        mockRepo = MockCharactersRepo()
        useCase = CharacterUseCase(repo: mockRepo)
    }
    
    override func tearDown() {
        useCase = nil
        mockRepo = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    // Test: Success case
    func testGetCharactersSuccess() async {
        let characterResult = CharacterResult(id: 1, name: "Rick Sanchez", status: .alive, species: "Human", type: "", gender: .male, origin: Location(name: "Earth", url: "url"), location: Location(name: "Earth", url: "url"), image: "image_url", episode: ["ep1", "ep2"], url: "url", created: "2024-12-13")
        let characterModel = CharacterModel(info: Info(count: 1, pages: 1, next: nil, prev: nil), results: [characterResult])
        mockRepo.mockResponse = .success(characterModel)
        
        let result = await useCase.getCharacters(urlString: "https://rickandmortyapi.com/api/character")
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.characters.count, 1)
        XCTAssertEqual(result?.characters.first?.name, "Rick Sanchez")
        XCTAssertEqual(result?.characters.first?.species, "Human")
        XCTAssertEqual(result?.dataInfo?.count, 1)
        XCTAssertEqual(result?.dataInfo?.pages, 1)
    }
    
    func testGetCharactersFailure() async {
        mockRepo.shouldReturnError = true
        let result = await useCase.getCharacters(urlString: "https://rickandmortyapi.com/api/character")
        XCTAssertNil(result)
    }
    
}

