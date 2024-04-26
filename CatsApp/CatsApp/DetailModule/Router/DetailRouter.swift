//
//  DetailRouter.swift
//  CatsApp
//
//  Created by student on 17.04.2024.
//

import Foundation

// MARK: - Detail router

final class DetailRouter: DetailRouterInput {

    weak var view: ModuleTransitionable?
    
    func backToMain() {
        view?.popToRoot(animated: true)
    }
    
}
