//
//  MockCharacterUseCase.swift
//  Yasir TaskTests
//
//  Created by Amr Adel on 24/12/2024.
//

import Foundation
@testable import Yasir_Task

class MockCharacterUseCase: CharacterUseCaseContract {
    var mockResponse: ResposneEntity?
    var shouldReturnError = false
    
    func getCharacters(urlString: String?) async -> ResposneEntity? {
        if shouldReturnError {
            return nil
        }
        return mockResponse
    }
}
