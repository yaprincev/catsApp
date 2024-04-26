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
    
    func navigateToDetail(cat: CatModel?, moduleOutput: DetailModuleOutput) -> DetailModuleInput {
        let detailModule = DetailModuleConfigurator().createDetailModule(cat: cat, moduleOutput: moduleOutput)
        view?.push(module: detailModule.0, animated: true)
        return detailModule.1
    }
    
}
