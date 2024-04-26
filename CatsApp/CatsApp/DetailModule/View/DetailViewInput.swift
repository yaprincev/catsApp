//
//  DetailViewInput.swift
//  CatsApp
//
//  Created by Максим Япринцев on 23.04.2024.
//

import Foundation

// MARK: - Input protocol

protocol DetailViewInput: AnyObject {
    func setInfo(catInfo: CatInfo?)
}
