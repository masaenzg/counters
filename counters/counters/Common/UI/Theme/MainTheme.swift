//
//  MainTheme.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 28/11/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

struct MainTheme: Theme {
    var backgroundColor: UIColor = UIColor.white
    var secondaryBackgroundColor: UIColor = UIColor.Pallete.mediumGray
    var tintColor: UIColor = UIColor.Pallete.orange
    var disabledColor: UIColor = UIColor.Pallete.lightGray
    var enabledColor: UIColor = UIColor.Pallete.orange
    var hasValueColor: UIColor = UIColor.Pallete.orange
    var emptyValueColor: UIColor = UIColor.Pallete.silver
    var cellTitleColor: UIColor = UIColor.black
    var cellContentColor: UIColor = UIColor.Pallete.mediumBlack
    var appFont: Font = SFProDisplay()
}
