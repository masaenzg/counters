//
//  Theme.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 28/11/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

protocol Theme {
    var backgroundColor: UIColor { get }
    var secondaryBackgroundColor: UIColor { get }
    var tintColor: UIColor { get }
    var disabledColor: UIColor { get }
    var enabledColor: UIColor { get }
    var hasValueColor: UIColor { get }
    var emptyValueColor: UIColor { get }
    var cellTitleColor: UIColor { get }
    var cellContentColor: UIColor { get }
    var appFont: Font { get }
}
