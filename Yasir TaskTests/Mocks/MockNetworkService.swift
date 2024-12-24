//
//  MockNetworkService.swift
//  Yasir TaskTests
//
//  Created by Amr Adel on 24/12/2024.
//

import Foundation
@testable import Yasir_Task

class MockNetworkService: NetworkServiceContract {
    var shouldReturnError: Bool = false
    var mockResponse: Result<Data, Error>!

    func request<T: Decodable>(_ urlRequest: URLRequest) async -> Result<T, Error> {
        if shouldReturnError {
            return .failure(APIError.badRequest)
        } else {
            // Decode the mockResponse to the expected type T
            switch mockResponse {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    return .success(decodedData)
                } catch {
                    return .failure(APIError.decodingFailed)
                }
            case .failure(let error):
                return .failure(error)
            case .none:
                return .failure(APIError.badRequest)
            }
        }
    }
}
