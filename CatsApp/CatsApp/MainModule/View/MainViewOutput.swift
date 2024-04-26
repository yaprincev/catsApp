//
//  viewOutput.swift
//  CatsApp
//
//  Created by Максим Япринцев on 23.04.2024.
//

import Foundation

// MARK: - Output protocol

protocol MainViewOutput: AnyObject {
    func imageDidTap(cat: CatModel?)
    func viewWasLoaded()
    func refreshData()
}
