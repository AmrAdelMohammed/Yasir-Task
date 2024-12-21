//
//  CharactersVM.swift
//  Yasir Task
//
//  Created by Amr Adel on 21/12/2024.
//

import Combine
import Foundation

protocol CharactersVMContract {
    func loadData()
}

class CharactersVM: CharactersVMContract {
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
    
    private func getChatacters(_ urlString: String?) async {
        let response = await characterUseCase.getCharacters(urlString: urlString)
        DispatchQueue.main.async {
            self.charactersList = response?.characters ?? []
            self.dataInfo = response?.dataInfo
        }
    }
}
