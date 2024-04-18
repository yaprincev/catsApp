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
    private var catsModel: [CatEntity]?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearence()
        presenter.viewWasLoaded()
    }
}

// MARK: - Input protocol

extension MainViewController: MainViewProtocol {
    
    func setupInitialState(cats: [CatEntity]?) {
        catsModel = cats
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
    
    func showError(error: Error) {
       
        view.addSubview(self.errorLabel)
        errorLabel.text = error.localizedDescription
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
        errorLabel.topAnchor.constraint(equalTo: self.view.topAnchor),
        errorLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 35),
        errorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
        errorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
            ])
        errorLabel.backgroundColor = .red
    }
}

// MARK: - UITableView


extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.catsModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CustomTableViewCell.self)", for: indexPath)
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.center = cell.contentView.center
            cell.contentView.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        
        
        guard let imageUrlString = self.catsModel?[indexPath.row].url,
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
        presenter.catsImageDidTap(cat: presenter.cats?[indexPath.row])
    }
    
}
