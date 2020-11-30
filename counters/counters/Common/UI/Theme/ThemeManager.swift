//
//  ThemeManager.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 28/11/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

class ThemeManager {
    var theme: Theme = MainTheme()
    
    static var shared: ThemeManager = {
        let themeManager = ThemeManager()
        return themeManager
    }()
    
    func setTheme(with theme: Theme) {
        self.theme = theme
    }
}
