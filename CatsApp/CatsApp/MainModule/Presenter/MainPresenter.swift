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
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getCats()
    func tapOnTheCat(cat: Cat?)
    var cats: [Cat]? { get set }
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol
    var cats: [Cat]?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getCats()
    }
    // func tapOnTheCat(cat: Cat?) { }
    
    func getCats() {
        networkService.getCats { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let cats):
                self.cats = cats
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
}
