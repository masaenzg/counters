//
//  AlertActionModel.swift
//  Counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 5/12/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

struct AlertActionModel {
    var title: String
    var message: String
    var leftActionClosure: ((UIAlertAction) -> Void)?
    var rightActionText: String? = nil
    var leftActionText: String 
}
