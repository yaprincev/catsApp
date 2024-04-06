//
//  NetworkService.swift
//  CatsApp
//
//  Created by Максим Япринцев on 06.04.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func getCats(completion: @escaping (Result<[Cat]?, Error>) -> Void)
}


class NetworkService: NetworkServiceProtocol {

    
    let sessionConfiguration = URLSessionConfiguration.default
    let decoder = JSONDecoder()
    let session = URLSession.shared
    
    
    func getCats(completion: @escaping (Result<[Cat]?, Error>) -> Void) {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=10") else { return }
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let obj = try self.decoder.decode([Cat].self, from: data!)
                completion(.success(obj))
                print(obj)
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
