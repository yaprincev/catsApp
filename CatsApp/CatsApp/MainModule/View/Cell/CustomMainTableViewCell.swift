//
//  CustomTableViewCell.swift
//  CatsApp
//
//  Created by student on 17.04.2024.
//

import UIKit

final class CustomMainTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var dataImage: UIImageView!
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearence()
    }
    
}

// MARK: -  TableViewCell

extension CustomMainTableViewCell {
    
    func configureAppearence() {
        dataImage.layer.cornerRadius = 15
        dataImage.contentMode = .scaleAspectFill
        dataImage.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
    }
    
    func setPhoto(model: CatModel?) {
        guard let cat = model else { return }
        guard let url = cat.url else { return }
        ImageLoader().loadImage(from: url, defaultImage: UIImage(named: "defaultImage")) { [weak self] result in
            if let image = result {
                DispatchQueue.main.async {
                    self?.dataImage.image = image
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                }
            }
        }
    }
    
}
