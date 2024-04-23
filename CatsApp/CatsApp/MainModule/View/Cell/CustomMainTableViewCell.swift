//
//  CustomTableViewCell.swift
//  CatsApp
//
//  Created by student on 17.04.2024.
//

import UIKit

final class CustomMainTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var catsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearence()
    }
    
}

// MARK: -  TableViewCell

extension CustomMainTableViewCell {
    
    func configureAppearence() {
        catsImage.layer.cornerRadius = 15
        catsImage.contentMode = .scaleAspectFill
        catsImage.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
    }
    
    func setPhoto(catModel: CatModel?) {
        guard let cat = catModel else { return }
        guard let url = cat.url else { return }
        ImageLoader().loadImage(from: url) { [weak self] result in
            if case let .success(image) = result {
                DispatchQueue.main.async {
                    self?.catsImage.image = image
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                }
            }
        }
    }
    
}
