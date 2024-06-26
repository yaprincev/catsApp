//
//  DetailPresenter.swift
//  CatsApp
//
//  Created by Максим Япринцев on 08.04.2024.
//

import Foundation

// MARK: - Presenter

final class DetailPresenter {
    
    // MARK:  - Properties
    
    weak var view: DetailViewInput?
    var cat: CatModel?
    var router: DetailRouterInput?
    
    // MARK: - Detail Module Output
    
    var output: DetailModuleOutput?
    
    // MARK: - Private properties
    
    private let networkService: NetworkServiceProtocol?
    private var catInfo: CatInfoModel?
    
    // MARK: - Init
    
    init(view: DetailViewInput, networkService: NetworkService, cat: CatModel?) {
        self.view = view
        self.networkService = networkService
        self.cat = cat
    }
    
}

// MARK: - Private methods

private extension DetailPresenter {
    
    func getCatInfo() {
        networkService?.getInfo(forURL: URLStorage.idCatURL.url, id: cat?.id, model: CatInfoEntity.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let catInfo):
                self.catInfo = CatInfoModel(catInfo: catInfo)
                DispatchQueue.main.async {
                    self.view?.setInfo(catInfo: self.catInfo)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

//  MARK: - View output

extension DetailPresenter: DetailViewOutput {
    
    func mainButtonDidTap() {
        output?.backButtonDidTap()
    }
    
    func viewWasLoaded() {
        getCatInfo()
    }
    
}

// MARK: - Detail module output

extension DetailPresenter: DetailModuleInput {
    
    func backToMain() {
        router?.backToMain()
    }

}

