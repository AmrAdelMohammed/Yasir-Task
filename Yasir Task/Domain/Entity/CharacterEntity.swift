//
//  CharacterEntity.swift
//  Yasir Task
//
//  Created by Amr Adel on 21/12/2024.
//

import Foundation

struct ResposneEntity {
    var characters: [CharacterEntity]
    var dataInfo: DataInfo?
}

struct CharacterEntity {
    var image: String?
    var name: String?
    var species: Species?
    var gender: Gender?
    var status: Status?
}

struct DataInfo {
    var count, pages: Int?
    var next: String?
    var prev: String?
}
