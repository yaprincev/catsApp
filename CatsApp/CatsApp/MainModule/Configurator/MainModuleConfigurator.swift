//
//  MainModuleConfigurator.swift
//  CatsApp
//
//  Created by student on 16.04.2024.
//

import Foundation
import UIKit

// MARK: - Main configurator

final class MainModuleConfigurator {
    
    func createMainModule() -> UIViewController {
        let view = MainViewController()
        let router = MainRouter()
        router.view = view
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.output = presenter
        return view
    }
    
}
