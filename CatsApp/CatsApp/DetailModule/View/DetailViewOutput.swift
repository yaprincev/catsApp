//
//  DetailViewOutput.swift
//  CatsApp
//
//  Created by Максим Япринцев on 23.04.2024.
//

import Foundation

// MARK: - Output protocol

protocol DetailViewOutput: AnyObject {
    func viewWasLoaded()
    func mainButtonDidTap()
}
