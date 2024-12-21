//
//  CharacterModel.swift
//  Yasir Task
//
//  Created by Amr Adel on 13/12/2024.
//

import Foundation


// MARK: - Welcome
struct CharacterModel: Codable {
    var info: Info?
    var results: [CharacterResult]?
}

// MARK: - Info
struct Info: Codable {
    var count, pages: Int?
    var next: String?
    var prev: String?
}

// MARK: - Result
struct CharacterResult: Codable {
    var id: Int?
    var name: String?
    var status: Status?
    var species: String?
    var type: String?
    var gender: Gender?
    var origin, location: Location?
    var image: String?
    var episode: [String]?
    var url: String?
    var created: String?
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
    case genderless = "Genderless"
}

// MARK: - Location
struct Location: Codable {
    var name: String?
    var url: String?
}

enum Status: String, Codable, CaseIterable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
