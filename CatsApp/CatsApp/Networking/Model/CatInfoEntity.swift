//
//  CatInfoEntity.swift
//  CatsApp
//
//  Created by student on 06.05.2024.
//

import Foundation

// MARK: - Detail info entity model

struct CatInfoEntity: Codable {
    var breeds: [BreedEntity]
}

struct BreedEntity: Codable {
    var name: String
    var origin: String
    var description: String
}





