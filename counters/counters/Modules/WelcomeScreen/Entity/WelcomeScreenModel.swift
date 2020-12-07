//
//  WelcomeScreenModel.swift
//  Counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 7/12/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

struct WelcomeScreenModel {
    static func getInformation() -> [WelcomeScreenCellModel] {
        var model:  [WelcomeScreenCellModel] = []
        
        let add = WelcomeScreenCellModel(title: AppStrings.WelcomeScreen.addAnythingTitle,
                                         content: AppStrings.WelcomeScreen.addAnythingContent,
                                         icon: AppImages.numberIcon,
                                         viewColor: UIColor.Pallete.customRed)
        let count = WelcomeScreenCellModel(title: AppStrings.WelcomeScreen.counToSelfTitle,
                                           content: AppStrings.WelcomeScreen.counToSelfContent,
                                           icon: AppImages.peopleIcon,
                                           viewColor: UIColor.Pallete.customYellow)
        let countYour = WelcomeScreenCellModel(title: AppStrings.WelcomeScreen.countYourTitle,
                                           content: AppStrings.WelcomeScreen.countYourContent,
                                           icon: AppImages.lightBulbIcon,
                                           viewColor: UIColor.Pallete.customGreen)

        model.append(add)
        model.append(count)
        model.append(countYour)
        
        return model
    }
}
