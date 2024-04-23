//
//  CustomTableViewCell.swift
//  CatsApp
//
//  Created by student on 17.04.2024.
//

import UIKit

final class CustomMainTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var catsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearence()
    }
    
}

extension CustomMainTableViewCell {
    
    func configureAppearence() {
        catsImage.layer.cornerRadius = 15
        catsImage.contentMode = .scaleAspectFill
        catsImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setPhoto(catModel: CatModel?) {
        guard let cat = catModel else { return }
        guard let url = cat.url else { return }
        catsImage.loadImage(from: url)
        self.contentView.addSubview(catsImage)
    }
    
}
