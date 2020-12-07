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
    @IBOutlet weak var alertCustomView: AlertCustomView!
    @IBOutlet weak var searchResultLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var presenter: MainScreenPresenterProtocol?
    var isInfoLoaded: Bool = false {
        didSet {
            tableView.isHidden = !isInfoLoaded
            alertCustomView.isHidden = isInfoLoaded
            changeNavButtonState(isEnabled: isInfoLoaded)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        presenter?.loadCounters()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupUI() {
        setupNavigationBar()
        setupTableView()
        setupToolBar()
        setupLabel()
    }
    
    private func setupNavigationBar() {
        self.view.backgroundColor = ThemeManager.shared.theme.secondaryBackgroundColor
        setupSearchBar()
        setupNavigationButton()
        navigationItem.rightBarButtonItem = nil
        navigationItem.title = AppStrings.MainScreen.title
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
        search.searchBar.placeholder = AppStrings.MainScreen.searchTitle
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
    
    private func setupLabel() {
        searchResultLabel.font = ThemeManager.shared.theme.appFont.regular.loadFont(size: .counterValue)
        searchResultLabel.textColor = ThemeManager.shared.theme.contentColor
        searchResultLabel.text = AppStrings.MainScreen.notResultsFound
        searchResultLabel.isHidden = true
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
        let barButton = UIBarButtonItem(title: AppStrings.MainScreen.selectAllButtontext, style: .plain, target: self, action: #selector(selectAllTapped))
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
    
    private func animate(with completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.3, animations: completion)
    }
    
    private func changeNavButtonState(isEnabled: Bool) {
        guard let button = navigationItem.leftBarButtonItem else { return }
        button.isEnabled = isEnabled
        button.setup(state: isEnabled ? .boldEnabled : .disbaled)
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
        presenter?.sendToActionSheet()
    }
    
    @objc
    func selectAllTapped() {
        let allRows = tableView.numberOfRows(inSection: .zero)
        for row in 0..<allRows {
            presenter?.addCounter(with: row)
            tableView.selectRow(at: NSIndexPath(row: row, section: .zero) as IndexPath,
                                           animated: false,
                                           scrollPosition: UITableView.ScrollPosition.none)
        }
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
    
    func showAlerCustomView(with model: AlertCustomViewModel) {
        alertCustomView.setupData(with: model)
    }
    
    func loadedInfo(with isLoaded: Bool) {
        isInfoLoaded = isLoaded
    }
    
    func resultLabelStatus(with isVivible: Bool) {
        searchResultLabel.isHidden = !isVivible
    }
    
    func startActivity() {
        activityIndicator.startAnimating()
    }
    
    func stopActivity() {
        activityIndicator.stopAnimating()
    }
}

extension MainScreenViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        presenter?.searchCounter(with: text)
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
