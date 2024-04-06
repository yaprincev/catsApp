//
//  MainPresenter.swift
//  CatsApp
//
//  Created by Максим Япринцев on 05.04.2024.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol) //router: RouterProtocol
    func getCats()
    func tapOnTheCat(cat: Cat?)
    var cats: [Cat]? { get set }
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    // router: RouterProtocol?
    let networkService: NetworkServiceProtocol
    var cats: [Cat]?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getCats()
    }
}
