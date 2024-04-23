//
//  MainPresenter.swift
//  CatsApp
//
//  Created by Максим Япринцев on 05.04.2024.
//

import Foundation

//  MARK: - Output protocol

final class MainPresenter: MainViewOutput {
    weak var view: MainViewInput?
    var router: MainRouter?
    let networkService: NetworkServiceProtocol?
    var cats: [CatModel] = []
    
    required init(view: MainViewInput, networkService: NetworkServiceProtocol, router: MainRouter) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    func catsImageDidTap(cat: CatModel?) {
        router?.navigateToDetail(cat: cat)
    }
    
    func viewWasLoaded() {
        getCats()
    }
    
    func getCats() {
        networkService?.getInfo(forURL: URLStorage.imageCatURL.url, id: nil, model: [CatEntity].self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let cats):
                for cat in cats {
                    let catModel = CatModel(cat: cat)
                    self.cats.append(catModel)
                }
                
                self.view?.setupInitialState(cats: self.cats)
            case .failure(let error):
                self.view?.setupErrorState(error: error)
            }
        }
    }
    
}
