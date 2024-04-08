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
    func loadImage(from url: URL, _ onLoadWasCompleted: @escaping (_ result: Result<UIImage, Error>) -> Void)
    
}


class NetworkService: NetworkServiceProtocol {

    
    let sessionConfiguration = URLSessionConfiguration.default
    let decoder = JSONDecoder()
    let session = URLSession.shared
    
    
    func getCats(completion: @escaping (Result<[Cat]?, Error>) -> Void) {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=30") else { return }
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
    
    func loadImage(from url: URL, _ onLoadWasCompleted: @escaping (_ result: Result<UIImage, Error>) -> Void) {
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                onLoadWasCompleted(.failure(error))
            }
            if let data = data, let image = UIImage(data: data) {
                onLoadWasCompleted(.success(image))
            }
        }
        .resume()
    }
}
