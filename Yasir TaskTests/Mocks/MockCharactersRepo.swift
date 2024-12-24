//
//  MockCharactersRepo.swift
//  Yasir TaskTests
//
//  Created by Amr Adel on 24/12/2024.
//

import Foundation
@testable import Yasir_Task

class MockCharactersRepo: CharactersRepoContract {
    var shouldReturnError: Bool = false
    var mockResponse: Result<CharacterModel, Error>!
    
    func getCharacters(urlString: String?) async -> Result<CharacterModel, Error> {
        if shouldReturnError {
            return .failure(APIError.badRequest)
        } else {
            return mockResponse
        }
    }
}
