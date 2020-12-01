//
//  MainScreenCellModel.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 1/12/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import Foundation

struct MainScreenCellModel {
    var id: String
    var title: String
    var count: Int
    var updateClosure: ((_ isIncrease: Bool, _ indexPath: IndexPath, _ idCounter: String) -> Void)?
}

