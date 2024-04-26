//
//  NetworkService.swift
//  CatsApp
//
//  Created by Максим Япринцев on 06.04.2024.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    func getInfo <T: Decodable>(forURL url: URL?, id: String?, model: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}


class NetworkService: NetworkConfiguration, NetworkServiceProtocol {
    
    func getInfo <T: Decodable>(forURL url: URL?, id: String?, model: T.Type ,completion: @escaping (Result<T, Error>) -> Void) {
        let id = id ?? ""
        guard var url = url else { return }
        url.append(path: id)
        self.session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let obj = try self.decoder.decode(model.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
