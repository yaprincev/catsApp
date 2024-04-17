//
//  MainPresenter.swift
//  CatsApp
//
//  Created by Максим Япринцев on 05.04.2024.
//

import Foundation

// MARK: - Input

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

// MARK: - Output

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: MainRouter)
    func getCats()
    func tapOnTheCat(cat: Cat?)
    var cats: [Cat]? { get set }
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    var router: MainRouter?
    let networkService: NetworkServiceProtocol!
    var cats: [Cat]?
    
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: MainRouter) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getCats()
    }
    
    func tapOnTheCat(cat: Cat?) {
        router?.navigateToDetail(cat: cat)
        //detailModule?.configureModule(cat: cat)
    }
    
    func getCats() {
       
        networkService.getInfo(forURL: URLStorage.imageCatURL.url, id: nil, model: [Cat].self) { [weak self] result in
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
