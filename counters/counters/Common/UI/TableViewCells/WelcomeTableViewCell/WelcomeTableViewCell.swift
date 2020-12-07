//
//  WelcomeTableViewCell.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 28/11/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

class WelcomeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentlabel: UILabel!
    @IBOutlet weak var imageContentView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupInformation(with data: WelcomeScreenCellModel) {
        titleLabel.text = data.title
        contentlabel.text = data.content
        imageContentView.backgroundColor = data.viewColor
        iconImageView?.image = data.icon
    }
    
    private func setupUI() {
        self.selectionStyle = .none
        imageContentView.layer.cornerRadius = 10
        setupLabels()
    }
    
    private func setupLabels() {
        titleLabel.font = ThemeManager.shared.theme.appFont.semiBold.loadFont(size: .content)
        contentlabel.font = ThemeManager.shared.theme.appFont.regular.loadFont(size: .content)
        titleLabel.textColor = ThemeManager.shared.theme.cellTitleColor
        contentlabel.textColor = ThemeManager.shared.theme.cellContentColor
    }
}
