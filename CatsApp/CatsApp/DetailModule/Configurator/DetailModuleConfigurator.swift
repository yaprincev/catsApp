//
//  DetailModuleConfigurator.swift
//  CatsApp
//
//  Created by student on 16.04.2024.
//

import Foundation
import UIKit


class DetailModuleConfigurator {
    func createDetailModule(cat: CatEntity?) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkService()
        let router = DetailRouter()
        router.view = view
        let presenter = DetailPresenter(view: view, networkService: networkService, cat: cat)
        view.presenter = presenter
        return view
    }
}
