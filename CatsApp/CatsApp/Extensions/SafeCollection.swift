//
//  SafeCollection.swift
//  CatsApp
//
//  Created by Максим Япринцев on 23.04.2024.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
