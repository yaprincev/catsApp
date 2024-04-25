//
//  CatInfo.swift
//  CatsApp
//
//  Created by Максим Япринцев on 08.04.2024.
//

import Foundation

// MARK: - Cat info model

struct CatInfo: Codable {
    var breeds: [Breed]
}

struct Breed: Codable {
    var name: String
    var origin: String
    var description: String
}
