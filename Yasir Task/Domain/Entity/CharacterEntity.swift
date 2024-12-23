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
    var species: String?
    var gender: Gender?
    var status: Status?
    var location: String?
}

struct DataInfo {
    var count, pages: Int?
    var next: String?
    var prev: String?
}
