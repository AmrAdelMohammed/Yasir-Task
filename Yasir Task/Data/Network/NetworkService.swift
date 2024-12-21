//
//  NetworkService.swift
//  Yasir Task
//
//  Created by Amr Adel on 13/12/2024.
//

import Combine
import Foundation

protocol NetworkServiceContract {
    func request<T: Decodable>(_ urlRequest: URLRequest) async -> Result<T, Error>
}

class NetworkService: NetworkServiceContract {
    
    private let urlSession: URLSession
    private let decodingService: DecodingService
    
    init(urlSession: URLSession = URLSession.shared,
         decodingService: DecodingService = AppDecodingService()) {
        self.urlSession = urlSession
        self.decodingService = decodingService
    }
    
    
    func request<T: Decodable>(_ request: URLRequest) async -> Result<T, Error> {
        do {
            let (data, response) = try await urlSession.data(for: request)
            let result = verifyResponse(data: data, response: response)
            return decodeResponse(result: result)
        } catch {
            return .failure(error)
        }
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
    
    private func decodeResponse<T: Decodable>(result: Result<Data, Error>) -> Result<T,Error> {
        
        switch result {
        case .success(let data):
            do {
                let decodedData = try self.decodingService.decode(data, to: T.self)
                return .success(decodedData)
            } catch {
                return .failure(APIError.decodingFailed)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
