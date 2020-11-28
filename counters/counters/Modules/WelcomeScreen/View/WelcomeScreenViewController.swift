//
//  WelcomeScreenViewController.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 27/11/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

final class WelcomeScreenViewController: BaseViewController {
    
    var presenter: WelcomeScreenPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension WelcomeScreenViewController: WelcomeScreenViewProtocol {}
