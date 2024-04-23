//
//  MainViewInput.swift
//  CatsApp
//
//  Created by Максим Япринцев on 23.04.2024.
//

import Foundation

// MARK: - View input

protocol MainViewInput: AnyObject {
    func setupInitialState(cats: [CatModel]?)
    func setupErrorState(error: Error)
}
