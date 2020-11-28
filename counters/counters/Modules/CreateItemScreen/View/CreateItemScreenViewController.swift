//
//  CreateItemScreenViewController.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 28/11/20.
//  Copyright (c) 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

final class CreateItemScreenViewController: BaseViewController {
    
    var presenter: CreateItemScreenPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CreateItemScreenViewController: CreateItemScreenViewProtocol {}
