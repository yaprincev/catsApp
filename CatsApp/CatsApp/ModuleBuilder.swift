//
//  ModuleBuilder.swift
//  CatsApp
//
//  Created by Максим Япринцев on 06.04.2024.
//

import Foundation
import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(cat: Cat?, router: RouterProtocol) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(cat: Cat?, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkService()
        let presenter = DetailPresenter(view: view, networkService: networkService, router: router, cat: cat)
        view.presenter = presenter
        return view
    }
    
}
