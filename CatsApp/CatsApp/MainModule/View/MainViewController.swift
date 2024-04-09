//
//  MainViewController.swift
//  CatsApp
//
//  Created by Максим Япринцев on 05.04.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var presenter: MainViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.isScrollEnabled = true
        collectionView.contentInset = .init(top: 10, left: 10, bottom: 10, right: 16)

    }
}



extension MainViewController: MainViewProtocol {
    func success() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func failure(error: Error) {
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.cats?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        for subview in cell.contentView.subviews {
            if let imageView = subview as? UIImageView {
                imageView.image = nil
            }
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = cell.contentView.center
        cell.contentView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        
        
        guard let imageUrlString = presenter.cats?[indexPath.row].url,
                let imageUrl = URL(string: imageUrlString) else {
            return cell
        }
            
        let imageView = UIImageView(frame: cell.contentView.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.loadImage(from: imageUrl)
        cell.contentView.addSubview(imageView)
            
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 30, height: view.frame.width - 20 * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = presenter.cats?[indexPath.row].id
        presenter.tapOnTheCat(cat: presenter.cats?[indexPath.row])
    }
}
