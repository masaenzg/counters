//
//  UIColor+Extension.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 28/11/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

extension UIColor {
    static func fromHex(rgbValue: UInt32, alpha: Double = 1.0) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8) / 256.0
        let blue = CGFloat(rgbValue & 0xFF) / 256.0
        return UIColor(red: red, green: green, blue: blue, alpha: CGFloat(alpha) )
    }
    
    struct Pallete {
        static let orange = UIColor.fromHex(rgbValue: 0xFF9500)
        static let customRed = UIColor.fromHex(rgbValue: 0xFF3B30)
        static let customGreen = UIColor.fromHex(rgbValue: 0x4CD964)
        static let customYellow = UIColor.fromHex(rgbValue: 0xFFCC00)
        static let mediumGray = UIColor.fromHex(rgbValue: 0xEDEDED)
        static let lightGray = UIColor.fromHex(rgbValue: 0xC7C7CC)
        static let darkSilver = UIColor.fromHex(rgbValue: 0x888B90)
        static let lightSilver = UIColor.fromHex(rgbValue: 0xC4C4C4)
        static let silver = UIColor.fromHex(rgbValue: 0xDCDCDF)
        static let mediumBlack = UIColor.fromHex(rgbValue: 0x2B2B2B)
        static let lightBlack = UIColor.fromHex(rgbValue: 0x4A4A4A)
    }
}

