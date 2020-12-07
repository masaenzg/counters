//
//  AlertCustomView.swift
//  Counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 6/12/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

class AlertCustomView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    var didTapButton: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
        
    func setupView() {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(AlertCustomView.viewID, owner: self, options: nil)?.first as? UIView else { return }
        self.addSubview(contentView)
        contentView.frame = self.bounds
        setupLabels()
    }
    
    func setupData(with model: AlertCustomViewModel) {
        titleLabel.text = model.title
        messageLabel.text = model.message
        actionButton.setupButton(with: model.buttonTitle, cornerRadius: 8)
        didTapButton = model.closure
    }
    
    private func setupLabels() {
        titleLabel.font = ThemeManager.shared.theme.appFont.semiBold.loadFont(size: .subHeader)
        messageLabel.font = ThemeManager.shared.theme.appFont.regular.loadFont(size: .content)
        titleLabel.textColor = ThemeManager.shared.theme.titleColor
        messageLabel.textColor = ThemeManager.shared.theme.contentColor
    }
    
    @IBAction func actionForButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.didTapButton?()
            self.isHidden = true
        }
    }

}
