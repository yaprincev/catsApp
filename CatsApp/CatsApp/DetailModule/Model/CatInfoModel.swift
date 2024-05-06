//
//  CatInfoModel.swift
//  CatsApp
//
//  Created by student on 06.05.2024.
//

import Foundation

struct CatInfo: Codable {
    var breeds: [Breed]
}

struct Breed: Codable {
    var name: String
    var origin: String
    var description: String
}


