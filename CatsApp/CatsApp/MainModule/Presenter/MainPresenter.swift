//
//  MainPresenter.swift
//  CatsApp
//
//  Created by Максим Япринцев on 05.04.2024.
//

import Foundation

// MARK: - Presenter

final class MainPresenter {
    
    // MARK: - Properties
    
    weak var view: MainViewInput?
    var router: MainRouterInput?
    
    // MARK: - Detail Module Input
    
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
                    self.cats = cats.map{ CatModel(cat: $0) }
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
        input = router?.navigateToDetail(cat: cat, moduleOutput: self)
    }
    
    func viewWasLoaded() {
        getCats()
    }
    
}

// MARK: - Detail module Output

extension MainPresenter: DetailModuleOutput {
    
    func backButtonDidTap() {
        input?.backToMain()
    }
    
}
