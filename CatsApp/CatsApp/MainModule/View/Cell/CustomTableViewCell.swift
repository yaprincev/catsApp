//
//  CustomTableViewCell.swift
//  CatsApp
//
//  Created by student on 17.04.2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var catsImage: UIImageView!
    
    var photoURL: URL! {
        didSet {
            setPhoto(url: photoURL)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearence()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

private extension CustomTableViewCell {
    
    func configureAppearence() {
        catsImage.layer.cornerRadius = 15
        catsImage.contentMode = .scaleAspectFill
        catsImage.translatesAutoresizingMaskIntoConstraints = false
    }
    func setPhoto(url: URL) {
        catsImage.loadImage(from: url)
        self.contentView.addSubview(catsImage)
    }
}
