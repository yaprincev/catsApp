//
//  DetailPresenter.swift
//  CatsApp
//
//  Created by Максим Япринцев on 08.04.2024.
//

import Foundation

// MARK: - Presenter

final class DetailPresenter {
    weak var view: DetailViewInput?
    let networkService: NetworkServiceProtocol?
    var cat: CatModel?
    var catInfo: CatInfo?
    let configurator = DetailModuleConfigurator()
    
    init(view: DetailViewInput, networkService: NetworkService, cat: CatModel?) {
        self.view = view
        self.networkService = networkService
        self.cat = cat
    }
    
    func getCatInfo() {
        networkService?.getInfo(forURL: URLStorage.idCatURL.url, id: cat?.id, model: CatInfo.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let catInfo):
                self.catInfo = catInfo
                setCat()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

//  MARK: - View output

extension DetailPresenter: DetailViewOutput {
    
    func setCat() {
        self.view?.setCat(catInfo: catInfo)
    }
    
    func viewWasLoaded() {
        getCatInfo()
    }
    
}


