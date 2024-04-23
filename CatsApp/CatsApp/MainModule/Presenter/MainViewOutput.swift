//
//  viewOutput.swift
//  CatsApp
//
//  Created by Максим Япринцев on 23.04.2024.
//

import Foundation

// MARK: - View output

protocol MainViewOutput: AnyObject {
    func getCats()
    func catsImageDidTap(cat: CatModel?)
    func viewWasLoaded()
}
