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
        barButton.setup(state: .disbaled)
        barButton.isEnabled = false
        navigationItem.rightBarButtonItem = barButton
    }
    
    private func changeSaveButtonState(isEnabled: Bool) {
        guard let button = navigationItem.rightBarButtonItem else { return }
        button.isEnabled = isEnabled
        button.setup(state: isEnabled ? .boldEnabled : .disbaled)
    }
    
    private func setupTextfield() {
        textField.delegate = self
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
        presenter?.saveItem(with: textField.text)
    }
}

extension CreateItemScreenViewController: CreateItemScreenViewProtocol {}

extension CreateItemScreenViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        changeSaveButtonState(isEnabled: (text.count > 5))
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        changeSaveButtonState(isEnabled: (count >= 5))
        return true
    }
}
