//
//  CustomTableViewCell.swift
//  CatsApp
//
//  Created by student on 17.04.2024.
//

import UIKit
import ReactiveDataDisplayManager

final class CustomMainTableViewCell: UITableViewCell, CalculatableHeightItem {
 
        // MARK: - Outlets
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var dataImage: UIImageView!
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearence()
    }
    
    // MARK: - CalculatableHeightItem
    
    static func getHeight(forWidth width: CGFloat, with model: CatModel?) -> CGFloat {
        return CGFloat(50)
    }
    
}

// MARK: -  TableViewCell

private extension CustomMainTableViewCell {
    
    func configureAppearence() {
        dataImage.layer.cornerRadius = 15
        dataImage.contentMode = .scaleAspectFill
        dataImage.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
    }
    
}

// MARK: - ConfigurableItem

extension CustomMainTableViewCell: ConfigurableItem {

    func configure(with model: CatModel?) {
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


