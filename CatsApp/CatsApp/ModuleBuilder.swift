//
//  ModuleBuilder.swift
//  CatsApp
//
//  Created by Максим Япринцев on 06.04.2024.
//

import Foundation
import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule() -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    
}
