//
//  CharactersVM.swift
//  Yasir Task
//
//  Created by Amr Adel on 21/12/2024.
//

import Combine
import Foundation

class CharactersVM {
    private let characterUseCase: CharacterUseCaseContract
    @Published private(set) var charactersList: [CharacterEntity] = [CharacterEntity]()
    private(set) var dataInfo: DataInfo?
    
    init(characterUseCase: CharacterUseCaseContract = CharacterUseCase()) {
        self.characterUseCase = characterUseCase
    }
    
    func loadData() {
        Task {
            guard let dataInfo = dataInfo else { return await getChatacters("https://rickandmortyapi.com/api/character") }
            await getChatacters(dataInfo.next)
        }
    }
    func filter(status: Status? = nil) {
        Task {
            var defaultUrl = "https://rickandmortyapi.com/api/character"
            dataInfo =  nil
            charactersList = []
            if status != nil {
                defaultUrl = "https://rickandmortyapi.com/api/character?status=\(status?.rawValue ?? "")"
            }
            guard let dataInfo = dataInfo else { return await getChatacters(defaultUrl) }
            await getChatacters(dataInfo.next)
            
        }
    }
    
    private func getChatacters(_ urlString: String?) async {
        let response = await characterUseCase.getCharacters(urlString: urlString)
        DispatchQueue.main.async {
            self.charactersList.append(contentsOf: response?.characters ?? [])
            self.dataInfo = response?.dataInfo
        }
    }
}
