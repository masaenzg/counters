//
//  WelcomeScreenViewController.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 27/11/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

final class WelcomeScreenViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    var presenter: WelcomeScreenPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        presenter?.sendToMainScreen()
    }
    
    private func setupUI() {
        self.view.backgroundColor = ThemeManager.shared.theme.backgroundColor
        setupLabels()
        setupTableView()
        setupButton()
    }
    
    func setupLabels() {
        setupTitlelabel()
        setupSubtitleLabel()
    }
    
    private func setupTitlelabel() {
        let firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: ThemeManager.shared.theme.titleColor,
                                                              .font: ThemeManager.shared.theme.appFont.heavy.loadFont(size: .header)]
        let secondAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: ThemeManager.shared.theme.tintColor,
                                                               .font: ThemeManager.shared.theme.appFont.heavy.loadFont(size: .header)]
        let titlePartOne = NSMutableAttributedString(string: AppStrings.WelcomeScreen.titlePartOne,
                                                     attributes: firstAttributes)
        let titlePartTwo = NSAttributedString(string: AppStrings.WelcomeScreen.titlePartTwo,
                                              attributes: secondAttributes)
        titlePartOne.append(titlePartTwo)
        titleLabel.attributedText = titlePartOne
    }
    
    private func setupSubtitleLabel() {
        subTitleLabel.text = AppStrings.WelcomeScreen.subtitle
        subTitleLabel.font = ThemeManager.shared.theme.appFont.regular.loadFont(size: .content)
        subTitleLabel.textColor = ThemeManager.shared.theme.subtitleColor
    }
    
    private func setupTableView() {
        tableView.backgroundColor = ThemeManager.shared.theme.backgroundColor
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        registerCellForTableView()
    }
    
    private func registerCellForTableView() {
        tableView.registerUINib(nibName: WelcomeTableViewCell.viewID)
    }
    
    private func setupButton() {
        nextButton.setupButton(with: AppStrings.WelcomeScreen.buttonText)
    }
}

extension WelcomeScreenViewController: WelcomeScreenViewProtocol {}

extension WelcomeScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfRows() ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WelcomeTableViewCell.viewID, for: indexPath) as? WelcomeTableViewCell,
            let data = presenter?.getCounterRow(index: indexPath.row) else {
                return UITableViewCell()
        }
        cell.setupInformation(with: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}
