//
//  MainRouter.swift
//  CatsApp
//
//  Created by student on 16.04.2024.
//

import Foundation

protocol MainRouterInput {
    func navigateToDetail(cat: Cat?)
}

class MainRouter: MainRouterInput {
    let view = MainViewController()
    let detailConfigurator = DetailModuleConfigurator()
    
    func navigateToDetail(cat: Cat?) {
        let detailView = detailConfigurator.createDetailModule(cat: cat)
        view.push(module: detailView, animated: true)
    }
}
