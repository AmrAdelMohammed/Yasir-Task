//
//  NetworkService.swift
//  Yasir Task
//
//  Created by Amr Adel on 13/12/2024.
//

import Combine
import Foundation

protocol NetworkServiceContract {
    func request<T: Decodable>(_ urlRequest: URLRequest) -> AnyPublisher<T, Error>
}

class NetworkService: NetworkServiceContract {
    
    private let urlSession: URLSession
    private let decodingService: DecodingService
    
    init(urlSession: URLSession = URLSession.shared,
         decodingService: DecodingService = AppDecodingService()) {
        self.urlSession = urlSession
        self.decodingService = decodingService
    }
    
    func request<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return urlSession.dataTaskPublisher(for: request)
            .tryMap { [weak self] data, response in
                // Check the response status code
                guard let self = self else {
                    throw APIError.unknown
                }
                
                let result = self.verifyResponse(data: data, response: response)
                switch result {
                case .success:
                    return data
                case .failure(let error):
                    throw error
                }
            }
            .tryMap { [weak self] data in
                // Decode the response data
                guard let self = self else {
                    throw APIError.unknown
                }
                
                do {
                    return try self.decodingService.decode(data, to: T.self)
                } catch {
                    throw APIError.decodingFailed
                }
            }
            .mapError { error -> Error in
                // Map any error to a generic Error type
                return error
            }
            .eraseToAnyPublisher()
    }
    
    private func verifyResponse(data: Data, response: URLResponse) -> Result<Data, Error> {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .failure(APIError.unknown)
        }
        switch httpResponse.statusCode {
        case 200...299:
            return .success(data)
        case 400...499:
            return .failure(APIError.badRequest)
        case 500...599:
            return .failure(APIError.serverError)
        default:
            return .failure(APIError.unknown)
        }
    }
}
