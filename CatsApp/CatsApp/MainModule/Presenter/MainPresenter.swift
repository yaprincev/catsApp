//
//  MainPresenter.swift
//  CatsApp
//
//  Created by Максим Япринцев on 05.04.2024.
//

import Foundation

// MARK: - Presenter

final class MainPresenter {
    weak var view: MainViewInput?
    var router: MainRouterInput?
    var input: DetailModuleInput?
    
    // MARK: - Private properties
    
    private let networkService: NetworkServiceProtocol?
    private var cats: [CatModel] = []
    
    // MARK: - Init
    
    init(view: MainViewInput, networkService: NetworkServiceProtocol, router: MainRouterInput) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
}

// MARK: - Private methods

private extension MainPresenter {
    
    func getCats() {
        networkService?.getInfo(forURL: URLStorage.imageCatURL.url, id: nil, model: [CatEntity].self) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
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
    
}

// MARK: - View output

extension MainPresenter: MainViewOutput {
    
    func refreshData() {
        getCats()
    }
    
    func imageDidTap(cat: CatModel?) {
        router?.navigateToDetail(cat: cat, moduleOutput: self)
    }
    
    func viewWasLoaded() {
        getCats()
    }
    
}

extension MainPresenter: DetailModuleOutput {
    
    func backButtonDidTap() {
        input?.backToMain()
    }
    
}
