//
//  MainViewController.swift
//  CatsApp
//
//  Created by Максим Япринцев on 05.04.2024.
//

import UIKit

class MainViewController: UIViewController, ModuleTransitionable {
    
    // MARK: - View
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Presenter
    
    var presenter: MainViewPresenterProtocol!
    private var errorLabel = UILabel()
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearence()
    }
}


extension MainViewController: MainViewProtocol {
    func success() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func failure(error: Error) {
        showError(error: error)
    }
}

// MARK: - Private methods

private extension MainViewController {
    func configureAppearence() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.isScrollEnabled = true
        collectionView.contentInset = .init(top: 10, left: 10, bottom: 10, right: 16)
    }
    func setUpImageView(imageView: UIImageView) {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
    }
    
    func showError(error: Error) {
        DispatchQueue.main.async {
            self.view.addSubview(self.errorLabel)
            self.errorLabel.text = error.localizedDescription
            self.errorLabel.numberOfLines = 0
            self.errorLabel.textAlignment = .center
            self.errorLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.errorLabel.topAnchor.constraint(equalTo: self.view.topAnchor),
                self.errorLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 35),
                self.errorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
                self.errorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
            ])
            self.errorLabel.backgroundColor = .red
        }
    }
}

// MARK: - UICollectionView

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
        setUpImageView(imageView: imageView)
        imageView.loadImage(from: imageUrl)
        cell.contentView.addSubview(imageView)
            
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 30, height: view.frame.width - 20 * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.tapOnTheCat(cat: presenter.cats?[indexPath.row])
    }
}


