//
//  NetworkService.swift
//  CatsApp
//
//  Created by Максим Япринцев on 06.04.2024.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    func getCats(completion: @escaping (Result<[Cat]?, Error>) -> Void)
    func getCatInfo(for id: String, completion: @escaping (Result<CatInfo?, Error>) -> Void)
}


class NetworkService: NetworkServiceProtocol {

    // MARK: - Constants
    
    let sessionConfiguration = URLSessionConfiguration.default
    let decoder = JSONDecoder()
    let session = URLSession.shared
    let apiKey = "live_zj8k3tkUBRYHpoByq7RTmV0NBz8moVcujbGMA0DVyN4FJtxheqbH1Uuv3DF9cOB3"
    
    // MARK: - Get image of cats
    
    func getCats(completion: @escaping (Result<[Cat]?, Error>) -> Void) {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=10&has_breeds=1&api_key=\(apiKey)") else { return }
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let obj = try self.decoder.decode([Cat].self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - Get cat's info by id
    
    func getCatInfo(for id: String, completion: @escaping (Result<CatInfo?, Error>) -> Void) {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/\(id)") else { return }
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let obj = try self.decoder.decode(CatInfo.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
