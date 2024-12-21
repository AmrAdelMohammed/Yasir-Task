//
//  CharactersRepo.swift
//  Yasir Task
//
//  Created by Amr Adel on 13/12/2024.
//

import Foundation
import Combine

protocol CharactersRepoContract{
    func getCharacters(urlString:  String?) async -> Result<CharacterModel,Error>
}

class CharactersRepo: CharactersRepoContract {
    private let networkService: NetworkServiceContract

    init(networkService: NetworkServiceContract = NetworkService()) {
        self.networkService = networkService
    }

    func getCharacters(urlString: String?) async -> Result<CharacterModel,Error> {
        if let url = urlString {
            let urlRequest = URLRequest(url: URL(string: url)!)
            return await networkService.request(urlRequest)
        }
        return .failure(APIError.badRequest)
    }
}
