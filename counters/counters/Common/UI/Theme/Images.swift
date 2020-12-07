//
//  Images.swift
//  Counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 7/12/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

protocol Images {
    static var peopleIcon: UIImage? { get }
    static var numberIcon: UIImage? { get }
    static var lightBulbIcon: UIImage? { get }
}

struct AppImages: Images {
    static var peopleIcon: UIImage? {
        return UIImage(named: "people")
    }
    
    static var numberIcon: UIImage? {
        return UIImage(named: "number")
    }
    
    static var lightBulbIcon: UIImage? {
        return UIImage(named: "lightBulb")
    }
}
