//
//  Storyboarded.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 28/11/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate(from storyboard: Storyboards) -> Self?
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(from storyboard: Storyboards) -> Self? {
        let fullName = NSStringFromClass(self)
        guard let className = fullName.components(separatedBy: ".").last else { return nil }
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as? Self
    }
}

