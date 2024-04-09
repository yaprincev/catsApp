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
    func showDetail(cat: Cat?)
}

class Router: RouterProtocol {
    var assemblyBuilder: AssemblyBuilderProtocol?
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetail(cat: Cat?) {
        print(1)
        if let navigationController = navigationController {
            guard let detailViewController = assemblyBuilder?.createDetailModule(cat: cat, router: self) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    
    
}
