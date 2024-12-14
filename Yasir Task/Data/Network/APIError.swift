//
//  APIError.swift
//  Yasir Task
//
//  Created by Amr Adel on 13/12/2024.
//

import Foundation

enum APIError: Error {
    
    case noInternetConnection
    case badRequest
    case unAuthenticated
    case serverError
    case decodingFailed
    case unknown
    
}
