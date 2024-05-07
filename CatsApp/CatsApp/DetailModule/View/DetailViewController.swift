//
//  DetailViewController.swift
//  CatsApp
//
//  Created by Максим Япринцев on 08.04.2024.
//

import UIKit

final class DetailViewController: UIViewController, ModuleTransitionable {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var mainButton: UIButton!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var originLabel: UILabel!
    @IBOutlet private weak var describtionLabel: UILabel!
    
    // MARK: - View output
    
    var output: DetailViewOutput?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewWasLoaded()
        configureMainButton()
    }
    
    // MARK: - Actions
    
    @IBAction func backToMain(_ sender: Any) {
        output?.mainButtonDidTap()
    }
    
}

// MARK: - Private methods

private extension DetailViewController {
 
    func configureMainButton() {
        mainButton.setTitle("Back to main", for: .normal)
    }
    
}

// MARK: - View input

extension DetailViewController: DetailViewInput {
    
    func setInfo(catInfo: CatInfoModel?) {
        nameLabel.text = catInfo?.breeds.first?.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.textAlignment = .center
        if let origin = catInfo?.breeds.first?.origin {
            originLabel.text = "Country: \(origin)"
        } else {
            originLabel.text = "Country: not found"
        }
        originLabel.font = UIFont.systemFont(ofSize: 14)
        describtionLabel.text = catInfo?.breeds.first?.description
        describtionLabel.font = UIFont.systemFont(ofSize: 14)
        describtionLabel.numberOfLines = 0
    }
    
}
