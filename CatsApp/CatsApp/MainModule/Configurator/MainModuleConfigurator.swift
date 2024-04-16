//
//  MainModuleConfigurator.swift
//  CatsApp
//
//  Created by student on 16.04.2024.
//

import Foundation
import UIKit

class MainModuleConfigurator {
    func createMainModule() -> UIViewController {
        let view = MainViewController()
        let router = MainRouter()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
}
