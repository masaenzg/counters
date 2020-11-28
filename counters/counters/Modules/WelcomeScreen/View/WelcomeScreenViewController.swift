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
        setupLabels()
        setupTableView()
        setupButton()
    }
    
    func setupLabels() {
        setupTitlelabel()
        setupSubtitleLabel()
    }
    
    private func setupTitlelabel() {
        
    }
    
    private func setupSubtitleLabel() {
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        registerCellForTableView()
    }
    
    private func registerCellForTableView() {
        tableView.registerUINib(nibName: WelcomeTableViewCell.viewID)
    }
    
    private func setupButton() {
        nextButton.setupBigButton(with: "Continue")
    }
}

extension WelcomeScreenViewController: WelcomeScreenViewProtocol {}

extension WelcomeScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WelcomeTableViewCell.viewID, for: indexPath) as? WelcomeTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 87
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}
