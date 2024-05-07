//
//  MainViewController.swift
//  CatsApp
//
//  Created by Максим Япринцев on 05.04.2024.
//

import UIKit
import ReactiveDataDisplayManager

final class MainViewController: UIViewController, ModuleTransitionable {

    // MARK: - Outlets
    
    @IBOutlet private weak var refreshButton: UIButton!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var imageTable: UITableView!
    
    // MARK: - Private properties
    
    private lazy var adapter = imageTable.rddm.baseBuilder
        .add(plugin: .selectable())
        .add(plugin: .accessibility())
        .build()
    private var models: [CatModel]?
    
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
        output?.refreshData()
    }
    
}

// MARK: - View input

extension MainViewController: MainViewInput {
    
    func setupInitialState(cats: [CatModel]?) {
        models = cats
        DispatchQueue.main.async {
            self.fillAdapter()
        }
    }
    
    func setupErrorState(error: Error) {
        showError(error: error)
    }
    
}

// MARK: - Private methods

private extension MainViewController {
    
    func configureAppearence() {
        imageTable.separatorStyle = .none
        errorView.isHidden = true
        refreshButton.isHidden = true
    }
    
    func showError(error: Error) {
        errorView.isHidden = false
        refreshButton.isHidden = false
        errorLabel.text = error.localizedDescription
        errorLabel.backgroundColor = .red
        configureRefreshButton()
    }
    
    func configureRefreshButton() {
        refreshButton.setTitle("Pull to refresh", for: .normal)
        refreshButton.setTitleColor(.black, for: .normal)
    }
    
    func fillAdapter() {
        guard let catModels = models else { return }
        
        for model in catModels {
            let generator = CustomMainTableViewCell.rddm.baseGenerator(with: model)
            
            generator.didSelectEvent += { [weak self] in
                self?.output?.imageDidTap(cat: model)
            }
            
            adapter.addCellGenerator(generator)
        }
        
        adapter.forceRefill()
    }
    
}
