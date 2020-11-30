//
//  UIBarButtonState.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 30/11/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

enum UIBarButtonState {
    case enabled
    case disbaled
    
    var tintColor: UIColor {
        switch self {
        case .enabled:
            return ThemeManager.shared.theme.enabledColor
        default:
            return ThemeManager.shared.theme.disabledColor
        }
    }
    
    var font: [NSAttributedString.Key: Any] {
        switch self {
        case .enabled:
            return [.font: ThemeManager.shared.theme.appFont.regular.loadFont(size: .content)]
        default:
            return [.font: ThemeManager.shared.theme.appFont.semiBold.loadFont(size: .content)]
        }
    }
    
    var state: UIControl.State {
        switch self {
        case .enabled:
            return .normal
        default:
            return .disabled
        }
    }
}
