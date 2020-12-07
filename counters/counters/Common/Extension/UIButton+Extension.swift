//
//  UIButton+Extension.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 28/11/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setBackground(with color: UIColor, for state: UIControl.State) {
        let backgroundImage = createImageBackground(with: color)
        self.setBackgroundImage(backgroundImage, for: state)
    }
    
    func setCornerRadius(with value: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = value
    }
    
    func setupButton(with text: String, cornerRadius: CGFloat = 10) {
        let backgroundColor = ThemeManager.shared.theme.enabledColor
        setCornerRadius(with: cornerRadius)
        setBackground(with: backgroundColor, for: .normal)
        setBackground(with: backgroundColor, for: .highlighted)
        setTextForBigButton(with: text)
    }
    
    func setTextForBigButton(with text: String) {
        let font = ThemeManager.shared.theme.appFont.semiBold.loadFont(size: .content)
        let attributedString = setAttributedString(with: font,
                                                        for: text,
                                                        color: .white)
        self.setAttributedTitle(attributedString, for: .normal)
        self.setAttributedTitle(attributedString, for: .highlighted)
    }
    
    private func createImageBackground(with color: UIColor) -> UIImage? {
        let rect = CGRect(x: .zero, y: .zero, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    private func setAttributedString(with font: UIFont, for text: String, color: UIColor) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
}

