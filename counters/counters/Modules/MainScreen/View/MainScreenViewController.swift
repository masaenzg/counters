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
    @IBOutlet weak var tableView: UITableView!
    var presenter: MainScreenPresenterProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.loadCounters()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupNavigationBar()
        setupTableView()
        setupToolBar()
    }
    
    private func setupNavigationBar() {
        self.view.backgroundColor = ThemeManager.shared.theme.secondaryBackgroundColor
        setupSearchBar()
        setupNavigationButton()
        navigationItem.rightBarButtonItem = nil
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
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = ThemeManager.shared.theme.secondaryBackgroundColor
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        registerCellForTableView()
    }
    
    private func registerCellForTableView() {
        tableView.registerUINib(nibName: MainScreenTableViewCell.viewID)
    }
    
    private func setupToolBar() {
        let emptyToolBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemTapped))
        toolBarButton.setup(state: .enabled)
        toolBar.items = [emptyToolBarButton, toolBarButton]
    }
    
    private func setupNavigationBarForEditMode() {
        setupNavigationDoneButton()
        setupNavigationSelectAllButton()
    }
    
    private func setupNavigationDoneButton() {
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        barButton.setup(state: .boldEnabled)
        navigationItem.leftBarButtonItem = barButton
    }
    
    private func setupNavigationSelectAllButton() {
        let barButton = UIBarButtonItem(title: "Select All", style: .plain, target: self, action: #selector(editTapped))
        barButton.setup(state: .enabled)
        navigationItem.rightBarButtonItem = barButton
    }
    
    private func setupToolBarForEditMode() {
        let emptyToolBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let deleteBarButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTapped))
        let shareBarButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(addItemTapped))
        deleteBarButton.setup(state: .enabled)
        shareBarButton.setup(state: .enabled)
        toolBar.items = [deleteBarButton, emptyToolBarButton, shareBarButton]
    }
    
    private func setupActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.view.tintColor = ThemeManager.shared.theme.tintColor
        let deleteAction = UIAlertAction(title: "Borrar", style: .destructive) { [weak self] (_) in
            self?.presenter?.deleteCounters()
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        actionSheet.addAction(deleteAction)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    private func animate(with completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.3, animations: completion)
    }
    
    @objc
    func editTapped() {
        animate {
            self.tableView.isEditing = true
            self.setupNavigationBarForEditMode()
            self.setupToolBarForEditMode()
        }
    }
    
    @objc
    func addItemTapped() {
        presenter?.sendToCreateItem()
    }
    
    @objc
    func doneTapped() {
        animate {
            self.tableView.isEditing = false
            self.setupNavigationBar()
            self.setupToolBar()
        }
    }
    
    @objc
    func deleteTapped() {
        setupActionSheet()
    }
}

extension MainScreenViewController: MainScreenViewProtocol {
    func updateView() {
        tableView.reloadData()
    }
    
    func updateCounter(with indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }

    func finishEditing() {
        doneTapped()
    }
}

extension MainScreenViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
}

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfRows() ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainScreenTableViewCell.viewID, for: indexPath) as? MainScreenTableViewCell,
            let row = presenter?.getCounterRow(index: indexPath.row) else {
                return UITableViewCell()
        }
        cell.setupCell(data: row, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            presenter?.addCounter(with: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            presenter?.removeCounter(with: indexPath.row)
        }
    }
}
