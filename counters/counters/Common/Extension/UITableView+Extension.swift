//
//  UITableView+Extension.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 28/11/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

extension UITableView {
    func registerUINib(nibName: String, bundle: Bundle = .main) {
        register(UINib(nibName: nibName, bundle: bundle),
                 forCellReuseIdentifier: nibName)
    }
}
