//
//  DetailModuleConfigurator.swift
//  CatsApp
//
//  Created by student on 16.04.2024.
//

import Foundation
import UIKit

// MARK: - Detail configurator

final class DetailModuleConfigurator {
    
    func createDetailModule(cat: CatModel?, moduleOutput: DetailModuleOutput? = nil) -> (UIViewController, DetailModuleInput) {
        let view = DetailViewController()
        let networkService = NetworkService()
        let router = DetailRouter()
        router.view = view
        let presenter = DetailPresenter(view: view, networkService: networkService, cat: cat)
        view.output = presenter
        presenter.router = router
        presenter.output = moduleOutput
        return (view, presenter)
    }
    
}
