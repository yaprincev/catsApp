//
//  CatModel.swift
//  CatsApp
//
//  Created by Максим Япринцев on 23.04.2024.
//

import Foundation

struct CatModel {
    var id: String
    var url: URL?
    
    init(id: String, url: String) {
        self.id = id
        self.url = URL(string: url)
    }
    
    init (cat: CatEntity) {
        self.id = cat.id
        self.url = URL(string: cat.url)
    }
    
}
