//
//  CharacterUseCase.swift
//  Yasir Task
//
//  Created by Amr Adel on 21/12/2024.
//

import Foundation

protocol CharacterUseCaseContract {
    func getCharacters(urlString:  String?) async -> ResposneEntity?
}

class CharacterUseCase: CharacterUseCaseContract {
    private let repo: CharactersRepoContract
    
    init(repo: CharactersRepoContract = CharactersRepo()) {
        self.repo = repo
    }
    
    func getCharacters(urlString: String?) async -> ResposneEntity? {
        let res = await repo.getCharacters(urlString: urlString)
        switch res{
        case .success(let data):
            let datainfo = DataInfo(count: data.info?.count,
                                    pages: data.info?.pages,
                                    next: data.info?.next,
                                    prev: data.info?.prev)
            let characters = mapToCharacterEntity(from: data.results ?? [])
            let results: ResposneEntity = ResposneEntity(characters: characters, dataInfo: datainfo)
            return results
        case .failure(let error):
            return nil
        }
    }
    
    func mapToCharacterEntity(from results: [CharacterResult]) -> [CharacterEntity] {
        return results.map { result in
            CharacterEntity(
                image: result.image,
                name: result.name,
                species: result.species,
                gender: result.gender,
                status: result.status
            )
        }
    }
    
}
