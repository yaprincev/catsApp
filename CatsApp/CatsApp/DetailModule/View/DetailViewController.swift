//
//  DetailViewController.swift
//  CatsApp
//
//  Created by Максим Япринцев on 08.04.2024.
//

import UIKit

class DetailViewController: UIViewController {

    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setCat()
        // Do any additional setup after loading the view.
    }
}

extension DetailViewController: DetailViewProtocol {
    func setCat(cat: Cat?) {
        print(cat?.id)
    }
    
    
}
