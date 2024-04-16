//
//  MainRouter.swift
//  CatsApp
//
//  Created by student on 16.04.2024.
//

import Foundation

protocol MainRouterInput {
    func navigateToDetail()
}

class MainRouter: MainRouterInput {
    let view = MainViewController()
    func navigateToDetail() {
        view.showModule(DetailViewController())
    }
}
