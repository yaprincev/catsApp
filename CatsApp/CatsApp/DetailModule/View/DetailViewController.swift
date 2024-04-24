//
//  DetailViewController.swift
//  CatsApp
//
//  Created by Максим Япринцев on 08.04.2024.
//

import UIKit

final class DetailViewController: UIViewController, ModuleTransitionable {

    // MARK: - Outlets
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var originLabel: UILabel!
    @IBOutlet private weak var describtionLabel: UILabel!
    
    // MARK: - Presenter
    
    var output: DetailViewOutput?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewWasLoaded()
    }
    
}

// MARK: - View input

extension DetailViewController: DetailViewInput {
    
    func setCat(catInfo: CatInfo?) {
        DispatchQueue.main.async {
            self.nameLabel.text = catInfo?.breeds.first?.name
            self.nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
            self.nameLabel.textAlignment = .center
            if let origin = catInfo?.breeds.first?.origin {
                self.originLabel.text = "Country: \(origin)"
            } else {
                self.originLabel.text = "Country: not found"
            }
            self.originLabel.font = UIFont.systemFont(ofSize: 14)
            self.describtionLabel.text = catInfo?.breeds.first?.description
            self.describtionLabel.font = UIFont.systemFont(ofSize: 14)
            self.describtionLabel.numberOfLines = 0
        }
    }
    
}
