//
//  MainRouter.swift
//  CatsApp
//
//  Created by student on 16.04.2024.
//

import Foundation
import UIKit

// MARK: - Main router

final class MainRouter: MainRouterInput {
    weak var view: ModuleTransitionable?
    
    func navigateToDetail(cat: CatModel?) {
        let detailViewController = DetailModuleConfigurator().createDetailModule(cat: cat)
        view?.push(module: detailViewController, animated: true)
    }
    
}
