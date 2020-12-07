//
//  AlertCustomViewModel.swift
//  Counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 6/12/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import Foundation

struct AlertCustomViewModel {
    var title: String
    var message: String
    var buttonTitle: String
    var closure: (() -> Void)?
}
