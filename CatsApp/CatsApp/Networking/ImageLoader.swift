//
//  ImageLoader.swift
//  CatsApp
//
//  Created by Максим Япринцев on 08.04.2024.
//

import UIKit
import Foundation

struct ImageLoader {
    let queueForLoad = DispatchQueue.global(qos: .utility)
    let session = URLSession(configuration: .default)

    func loadImage(from url: URL, defaultImage: UIImage?,_ onLoadWasCompleted: @escaping (UIImage?) -> Void) {
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                onLoadWasCompleted(defaultImage)
                print(error.localizedDescription)
            }
            if let data = data, let image = UIImage(data: data) {
                onLoadWasCompleted(image)
            }
        }
        .resume()
    }
     
}
