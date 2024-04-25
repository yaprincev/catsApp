//
//  MainRouterInput.swift
//  CatsApp
//
//  Created by Максим Япринцев on 23.04.2024.
//

import Foundation

// MARK: - Main router input protocol

protocol MainRouterInput {
    func navigateToDetail(cat: CatModel?)
}
