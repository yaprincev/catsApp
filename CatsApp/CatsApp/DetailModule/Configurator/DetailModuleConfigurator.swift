//
//  DetailModuleConfigurator.swift
//  CatsApp
//
//  Created by student on 16.04.2024.
//

import Foundation
import UIKit


class DetailModuleConfigurator {
    func createDetailModule(cat: Cat?, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkService()
        let presenter = DetailPresenter(view: view, networkService: networkService, router: router, cat: cat)
        view.presenter = presenter
        return view
    }
}
