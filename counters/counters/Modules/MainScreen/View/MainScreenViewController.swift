//
//  MainScreenViewController.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 27/11/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

final class MainScreenViewController: BaseViewController {
    
    @IBOutlet weak var toolBar: UIToolbar!
    var presenter: MainScreenPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupNavigationBar()
        setupToolBar()
    }
    
    private func setupNavigationBar() {
        setupSearchBar()
        setupNavigationButton()
        navigationItem.title = "Demo"
    }
    
    private func setupNavigationButton() {
        let barButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        barButton.setup(state: .enabled)
        navigationItem.leftBarButtonItem = barButton
    }
    
    private func setupSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.tintColor = ThemeManager.shared.theme.tintColor
        search.obscuresBackgroundDuringPresentation = true
        search.searchBar.placeholder = "Search"
        navigationItem.searchController = search
    }
    
    private func setupToolBar() {
        let emptyToolBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemTapped))
        toolBarButton.setup(state: .enabled)
        toolBar.items = [emptyToolBarButton, toolBarButton]
    }
    
    @objc
    func editTapped() {
        
    }
    
    @objc
    func addItemTapped() {
        presenter?.sendToCreateItem()
    }
}

extension MainScreenViewController: MainScreenViewProtocol {}

extension MainScreenViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
}
