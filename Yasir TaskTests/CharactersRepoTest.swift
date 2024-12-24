//
//  CharactersRepoTest.swift
//  Yasir TaskTests
//
//  Created by Amr Adel on 24/12/2024.
//
import XCTest
import Combine
@testable import Yasir_Task

class CharactersRepoTests: XCTestCase {
    // MARK: - Properties
    var repo: CharactersRepo!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        repo = CharactersRepo(networkService: mockNetworkService)
    }

    override func tearDown() {
        repo = nil
        mockNetworkService = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testGetCharactersSuccess() async {
        let characterResult = CharacterResult(id: 1, name: "Rick Sanchez", status: .alive, species: "Human", type: "", gender: .male, origin: Location(name: "Earth", url: "url"), location: Location(name: "Earth", url: "url"), image: "image_url", episode: ["ep1", "ep2"], url: "url", created: "2024-12-13")
        let characterModel = CharacterModel(info: Info(count: 1, pages: 1, next: nil, prev: nil), results: [characterResult])
        let mockData = try! JSONEncoder().encode(characterModel)
        mockNetworkService.mockResponse = .success(mockData)
        
        let result = await repo.getCharacters(urlString: "https://rickandmortyapi.com/api/character")
        
        switch result {
        case .success(let characterModel):
            XCTAssertEqual(characterModel.info?.count, 1)
            XCTAssertEqual(characterModel.results?.first?.name, "Rick Sanchez")
            XCTAssertEqual(characterModel.results?.first?.species, "Human")
        case .failure:
            XCTFail("Expected success, but got failure.")
        }
    }

    func testGetCharactersFailure() async {
        mockNetworkService.shouldReturnError = true
        let result = await repo.getCharacters(urlString: "https://rickandmortyapi.com/api/character")
        
        switch result {
        case .success:
            XCTFail("Expected failure, but got success.")
        case .failure(let error):
            XCTAssertEqual(error as? APIError, APIError.badRequest)
        }
    }

    func testGetCharactersWithNilURL() async {
        let result = await repo.getCharacters(urlString: nil)
        
        switch result {
        case .success:
            XCTFail("Expected failure, but got success.")
        case .failure(let error):
            XCTAssertEqual(error as? APIError, APIError.badRequest)
        }
    }
}
