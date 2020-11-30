//
//  String+Extension.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 29/11/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit


extension String {
    func loadFont(size: FontSize) -> UIFont {
        guard let font = UIFont(name: self, size: size.rawValue) else {
            return UIFont.systemFont(ofSize: size.rawValue)
        }
        return font
    }
}
