//
//  DetailPresenter.swift
//  CatsApp
//
//  Created by Максим Япринцев on 08.04.2024.
//

import Foundation

// MARK: - Output

protocol DetailViewProtocol: AnyObject {
    func setCat(catInfo: CatInfo?)
}

// MARK: - Input

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, networkService: NetworkService, cat: Cat?)
    func setCat()
    var catInfo: CatInfo? { get set }
}

class DetailPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    var cat: Cat?
    var catInfo: CatInfo?
    let configurator = DetailModuleConfigurator()
    
    required init(view: DetailViewProtocol, networkService: NetworkService, cat: Cat?) {
        self.view = view
        self.networkService = networkService
        //self.router = router
        self.cat = cat
        getCatInfo()
        
    }
    
    func setCat() {
        self.view?.setCat(catInfo: catInfo)
    }
    
    func getCatInfo() {
        networkService.getInfo(forURL: URLStorage.idCatURL.url, id: cat?.id, model: CatInfo.self) { [weak self] result in
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

extension DetailPresenter: DetailModuleInput {
    
    func configureModule(cat: Cat) {
        configurator.createDetailModule(cat: cat)
    }
    
    
}
