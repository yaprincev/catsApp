//
//  Router.swift
//  CatsApp
//
//  Created by Максим Япринцев on 08.04.2024.
//

import Foundation
import UIKit

protocol RouterProtocol {
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
    var navigationController: UINavigationController? { get set }
    func initialViewController()
    //func showDetail(cat: Cat?)
}

class Router: RouterProtocol {
    var assemblyBuilder: AssemblyBuilderProtocol?
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        let configurator = MainModuleConfigurator()
        if let navigationController = navigationController {
            //guard let mainViewController =
              //      configurator.createMainModule(router: self)
                    //assemblyBuilder?.createMainModule(router: self) else { return }
            let mainViewController = configurator.createMainModule()
            navigationController.viewControllers = [mainViewController]
        }
    }
    

    
    
}
