//
//  UIBarButtonItem+Extension.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 29/11/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    func setup(with text: String? = nil, state: UIBarButtonState) {
        self.tintColor = state.tintColor
        self.setTitleTextAttributes(state.font, for: state.state)
        guard let text = text else { return }
        setText(with: text)
    }
    
    private func setText(with text: String) {
        self.title = text
    }
}
