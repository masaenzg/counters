//
//  CreateItemScreenViewController.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 28/11/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//
import UIKit

final class CreateItemScreenViewController: BaseViewController {
    
    @IBOutlet weak var textField: TextField!
    var presenter: CreateItemScreenPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupNavigationBar()
        setupTextfield()
    }
    
    private func setupNavigationBar() {
        setupNavigationButtons()
        navigationItem.title = "Create a Counter"
    }
    
    private func setupNavigationButtons() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        setupNavigationLeftButton()
        setupNavigationRightButton()
    }
    
    private func setupNavigationLeftButton() {
        let barButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        barButton.setup(state: .enabled)
        navigationItem.leftBarButtonItem = barButton
    }
    
    private func setupNavigationRightButton() {
        let barButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        barButton.setup(state: .enabled)
        //barButton.setup(state: .disbaled)
        //barButton.isEnabled = false
        navigationItem.rightBarButtonItem = barButton
    }
    
    private func setupTextfield() {
        textField.tintColor = ThemeManager.shared.theme.tintColor
        textField.rightView = createLoader()
        showLoader(isVisible: false)
        textField.becomeFirstResponder()
    }
    
    func showLoader(isVisible: Bool) {
        textField.rightViewMode = isVisible ? .always : .never
    }
    
    private func createLoader() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = UIColor.Pallete.silver
        activityIndicator.startAnimating()
        return activityIndicator
    }
    
    @objc
    func cancelTapped() {
        presenter?.sendToCloseComponent()
    }
    
    @objc
    func saveTapped() {
        showLoader(isVisible: true)
    }
}

extension CreateItemScreenViewController: CreateItemScreenViewProtocol {}

