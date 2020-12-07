//
//  BaseViewController.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 28/11/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, Storyboarded {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(with model: AlertActionModel) {
        let alert = UIAlertController(title: model.title, message: model.message, preferredStyle: .alert)
        alert.view.tintColor = ThemeManager.shared.theme.tintColor
        let leftAction = UIAlertAction(title: model.leftActionText, style: .cancel, handler: model.leftActionClosure)
        alert.addAction(leftAction)
        if let rightActionText = model.rightActionText {
            let rightAction = UIAlertAction(title: rightActionText, style: .default, handler: { (_) in
                alert.dismiss(animated: true, completion: nil)
            })
            alert.addAction(rightAction)
        }
        self.present(alert, animated: true, completion: nil)
    }
}
