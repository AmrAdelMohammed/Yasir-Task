//
//  CharactersRepo.swift
//  Yasir Task
//
//  Created by Amr Adel on 13/12/2024.
//

import Foundation
import Combine

protocol CharactersRepoContract{
    func getCharacters() -> AnyPublisher<CharacterModel, Error>
}

class CharactersRepo: CharactersRepoContract {
    private let networkService: NetworkServiceContract

    init(networkService: NetworkServiceContract = NetworkService()) {
        self.networkService = networkService
    }

    func getCharacters() -> AnyPublisher<CharacterModel, Error> {
        let urlRequest = URLRequest(url: URL(string: "https://rickandmortyapi.com/api/character")!)
        return networkService.request(urlRequest)
    }
}
