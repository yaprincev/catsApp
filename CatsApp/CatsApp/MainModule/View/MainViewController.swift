//
//  MainViewController.swift
//  CatsApp
//
//  Created by Максим Япринцев on 05.04.2024.
//

import UIKit

final class MainViewController: UIViewController, ModuleTransitionable {

    // MARK: - Outlets
    
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var catsTable: UITableView!
    
    // MARK: - Private properties
    
    private var catsModel: [CatModel]?
    
    // MARK: - View output
    
    var output: MainViewOutput?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearence()
        output?.viewWasLoaded()
    }
    
    // MARK: - Actions

    @IBAction func refreshButtonWasTapped(_ sender: Any) {
        errorView.isHidden = true
        output?.getCats()
    }
    
}

// MARK: - View input

extension MainViewController: MainViewInput {
    
    func setupInitialState(cats: [CatModel]?) {
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
        catsTable.register(cell: CustomMainTableViewCell.self)
        catsTable.separatorStyle = .none
        errorView.isHidden = true
    }
    
    func showError(error: Error) {
        DispatchQueue.main.async {
            self.errorView.isHidden = false
            self.errorLabel.text = error.localizedDescription
            self.errorLabel.backgroundColor = .red
            self.configureRefreshButton()
        }
    }
    
    func configureRefreshButton() {
        refreshButton.setTitle("Pull to refresh", for: .normal)
        refreshButton.setTitleColor(.black, for: .normal)
    }
    
}

// MARK: - UITableView

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.catsModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CustomMainTableViewCell.self)", for: indexPath)
        if let cell = cell as? CustomMainTableViewCell {
            cell.setPhoto(catModel: self.catsModel?[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height / 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.catImageDidTap(cat: catsModel?[safe: indexPath.row])
    }
    
}

