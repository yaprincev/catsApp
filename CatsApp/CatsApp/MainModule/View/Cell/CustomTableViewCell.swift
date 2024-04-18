//
//  CustomTableViewCell.swift
//  CatsApp
//
//  Created by student on 17.04.2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var catsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearence()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CustomTableViewCell {
    
    func configureAppearence() {
        catsImage.layer.cornerRadius = 15
        catsImage.contentMode = .scaleAspectFill
        catsImage.translatesAutoresizingMaskIntoConstraints = false
    }
    func setPhoto(catModel: CatEntity?) {
        guard let cat = catModel else { return }
        guard let url = URL(string: cat.url) else { return }
        catsImage.loadImage(from: url)
        self.contentView.addSubview(catsImage)
    }
}
