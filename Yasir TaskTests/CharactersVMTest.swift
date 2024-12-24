//
//  CharactersVMTest.swift
//  Yasir TaskTests
//
//  Created by Amr Adel on 24/12/2024.
//

import XCTest
import Combine
@testable import Yasir_Task

class CharactersVMTests: XCTestCase {
    // MARK: - Properties
    var viewModel: CharactersVM!
    var mockCharacterUseCase: MockCharacterUseCase!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        mockCharacterUseCase = MockCharacterUseCase()
        viewModel = CharactersVM(characterUseCase: mockCharacterUseCase)
    }
    
    override func tearDown() {
        viewModel = nil
        mockCharacterUseCase = nil
        cancellables = []
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testLoadDataSuccess() async {
        let characterEntity = CharacterEntity(image: "image_url", name: "Rick Sanchez", species: "Human", gender: .male, status: .alive, location: "Earth")
        let response = ResposneEntity(characters: [characterEntity], dataInfo: DataInfo(count: 1, pages: 1, next: nil, prev: nil))
        mockCharacterUseCase.mockResponse = response
        let expectation = expectation(description: "Characters loaded")
        
        viewModel.$charactersList
            .dropFirst()
            .sink { characters in
                XCTAssertEqual(characters.count, 1)
                XCTAssertEqual(characters.first?.name, "Rick Sanchez")
                expectation.fulfill() // Fulfill the expectation once the test passes
            }
            .store(in: &cancellables)

        viewModel.loadData()
        
        wait(for: [expectation])
    }
    
    func testLoadDataFailure() async {
        let viewModel = CharactersVM(characterUseCase: mockCharacterUseCase)
        mockCharacterUseCase.shouldReturnError = true
        
        let expectation = expectation(description: "Load failed")
        viewModel.$charactersList
            .dropFirst()
            .sink { characters in
                XCTAssertTrue(characters.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadData()
        wait(for: [expectation])
    }
}

