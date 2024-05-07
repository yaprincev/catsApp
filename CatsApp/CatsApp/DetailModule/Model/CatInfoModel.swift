//
//  CatInfoModel.swift
//  CatsApp
//
//  Created by student on 06.05.2024.
//

import Foundation

struct CatInfoModel {
    var breeds = [Breed]()
    
    init(catInfo: CatInfoEntity) {
        self.breeds.append(Breed(name: catInfo.breeds[0].name, origin: catInfo.breeds[0].origin, description: catInfo.breeds[0].description))
    }
    
}

struct Breed {
    var name: String
    var origin: String
    var description: String
    
    init(name: String, origin: String, description: String) {
        self.name = name
        self.origin = origin
        self.description = description
    }
    
}



