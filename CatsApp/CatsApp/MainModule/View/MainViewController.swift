//
//  MainViewController.swift
//  CatsApp
//
//  Created by Максим Япринцев on 05.04.2024.
//

import UIKit

class MainViewController: UIViewController, ModuleTransitionable {
    
    @IBOutlet weak var catsTable: UITableView!
    
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
    func setupInitialState() {
        DispatchQueue.main.async {
            self.catsTable.reloadData()
        }
    }
    
    func setupErrorState(error: Error) {
        showError(error: error)
    }
}

// MARK: - Private methods
private extension MainViewController {
    func configureAppearence() {
        catsTable.dataSource = self
        catsTable.delegate = self
        catsTable.register(UINib(nibName: "\(CustomTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(CustomTableViewCell.self)")
        catsTable.separatorStyle = .none

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


extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.cats?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CustomTableViewCell.self)", for: indexPath)
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.center = cell.contentView.center
            cell.contentView.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        
        
        guard let imageUrlString = presenter.cats?[indexPath.row].url,
            let imageUrl = URL(string: imageUrlString) else {
            return cell
        }
            
        if let cell = cell as? CustomTableViewCell {
            cell.photoURL = imageUrl
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height / 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
