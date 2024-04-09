//
//  DetailPresenter.swift
//  CatsApp
//
//  Created by Максим Япринцев on 08.04.2024.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func setCat(cat: Cat?)
}

protocol DetailViewPresenterProtocl: AnyObject {
    init(view: DetailViewProtocol, networkService: NetworkService, router: RouterProtocol, cat: Cat?)
    func setCat()
}

class DetailPresenter: DetailViewPresenterProtocl {
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    var cat: Cat?
    
    required init(view: DetailViewProtocol, networkService: NetworkService, router: RouterProtocol, cat: Cat?) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.cat = cat
    }
    
    func setCat() {
        self.view?.setCat(cat: cat)
    }
    
    
}
