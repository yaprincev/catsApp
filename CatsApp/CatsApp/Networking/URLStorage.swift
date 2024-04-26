//
//  URLStorage.swift
//  CatsApp
//
//  Created by student on 15.04.2024.
//

import Foundation

enum URLStorage {
    case idCatURL
    case imageCatURL
    var url: URL? {
        switch self {
        case .idCatURL:
            return URL(string: "https://api.thecatapi.com/v1/images/")
        case .imageCatURL:
            return URL(string: "https://api.thecatapi.com/v1/images/search?limit=10&has_breeds=1&api_key=live_zj8k3tkUBRYHpoByq7RTmV0NBz8moVcujbGMA0DVyN4FJtxheqbH1Uuv3DF9cOB3")
        }
    }
}
