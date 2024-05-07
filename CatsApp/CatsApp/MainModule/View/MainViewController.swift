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
        fillAdapter()
        DispatchQueue.main.async {
       //     self.imageTable.reloadData()
        }
    }
    
    func setupErrorState(error: Error) {
        showError(error: error)
    }
    
}

// MARK: - Private methods

private extension MainViewController {
    
    func configureAppearence() {
       // imageTable.dataSource = self
        //imageTable.delegate = self
       // imageTable.register(cell: CustomMainTableViewCell.self)
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

// MARK: - UITableView

/*extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(cell: CustomMainTableViewCell.self, indexPath: indexPath) as? CustomMainTableViewCell else { return UITableViewCell() }
        cell.setPhoto(model: self.models?[safe: indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height / 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.imageDidTap(cat: models?[safe: indexPath.row])
    }
    
}

*/
