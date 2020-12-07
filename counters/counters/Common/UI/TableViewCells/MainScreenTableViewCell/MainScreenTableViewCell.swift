//
//  MainScreenTableViewCell.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 1/12/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

class MainScreenTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var counterTitleLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var separatorView: UIView!
    var cellData: MainScreenCellModel?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }
    
    func setupUI() {
        self.backgroundColor = ThemeManager.shared.theme.secondaryBackgroundColor
        self.selectionStyle = .gray
        self.accessoryType = .checkmark
        self.tintColor = ThemeManager.shared.theme.tintColor
        setupVIews()
        setupLabels()
    }
    
    func setupVIews() {
        containerView.layer.cornerRadius = 8
        separatorView.backgroundColor = UIColor.Pallete.lightSilver.withAlphaComponent(0.2)
    }
    
    func setupLabels() {
        counterLabel.font = ThemeManager.shared.theme.appFont.semiBold.loadFont(size: .counterValue)
        counterTitleLabel.font = ThemeManager.shared.theme.appFont.regular.loadFont(size: .content)
    }
    
    func setupCell(data: MainScreenCellModel, indexPath: IndexPath) {
        cellData = data
        self.indexPath = indexPath
        counterTitleLabel.text = data.title
        stepper.value = Double(data.count)
        counterLabel.text = String(data.count)
        counterLabel.textColor = data.count == .zero ? ThemeManager.shared.theme.emptyValueColor : ThemeManager.shared.theme.hasValueColor
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
    }
    
    @objc
    func stepperValueChanged(_ sender: UIStepper) {
        guard let data = cellData,
            let indexPath = indexPath else { return }
        var isIncrement = false
        
        if Int(sender.value) > data.count {
            isIncrement = true
        }
        data.updateClosure?(isIncrement, indexPath, data.id)
    }
}
