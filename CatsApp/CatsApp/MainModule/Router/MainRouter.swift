//
//  MainRouter.swift
//  CatsApp
//
//  Created by student on 16.04.2024.
//

import Foundation
import UIKit

protocol MainRouterInput {
    func navigateToDetail(cat: CatEntity?)
}

class MainRouter: MainRouterInput {

    weak var view: ModuleTransitionable?
    
    func navigateToDetail(cat: CatEntity?) {
        let detailView = DetailModuleConfigurator().createDetailModule(cat: cat)
        view?.push(module: detailView, animated: true)
    }
}
