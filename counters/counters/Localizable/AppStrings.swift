//
//  AppStrings.swift
//  Counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 7/12/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import Foundation

struct AppStrings {
    struct Alerts {
        static var defaultBody: String { return "Alert.defaultBody".localizable }
        static var deleteErrorTitle: String { return "Alert.deleteErrorTitle".localizable }
        static var deleteManyErrorTitle: String { return "Alert.deleteManyErrorTitle".localizable }
        static var createErrorTitle: String { return "Alert.createErrorTitle".localizable }
        static var updateErrorTitle: String { return "Alert.updateErrorTitle".localizable }
        static var dismissOption: String { return "Alert.dismissOption".localizable }
        static var retryOption: String { return "Alert.retryOption".localizable }
    }
    
    struct WelcomeScreen {
        static var titlePartOne: String { return "WelcomeScreen.titlePartOne".localizable }
        static var titlePartTwo: String { return "WelcomeScreen.titlePartTwo".localizable }
        static var subtitle: String { return "WelcomeScreen.subtitle".localizable }
        static var addAnythingTitle: String { return "WelcomeScreen.addAnythingTitle".localizable }
        static var addAnythingContent: String { return "WelcomeScreen.addAnythingContent".localizable }
        static var counToSelfTitle: String { return "WelcomeScreen.counToSelfTitle".localizable }
        static var counToSelfContent: String { return "WelcomeScreen.counToSelfContent".localizable }
        static var countYourTitle: String { return "WelcomeScreen.countYourTitle".localizable }
        static var countYourContent: String { return "WelcomeScreen.countYourContent".localizable }
        static var buttonText: String { return "WelcomeScreen.buttonText".localizable }
    }
    
    struct MainScreen {
        static var title: String { return "MainScreen.title".localizable }
        static var searchTitle: String { return "MainScreen.searchTitle".localizable }
        static var alertEmptyRowsTitle: String { return "MainScreen.alertEmptyRowsTitle".localizable }
        static var alertEmptyRowsContent: String { return "MainScreen.alertEmptyRowsContent".localizable }
        static var alertEmptyRowsButtonText: String { return "MainScreen.alertEmptyRowsButtonText".localizable }
        static var alertLoadFailTitle: String { return "MainScreen.alertLoadFailTitle".localizable }
        static var alertLoadFailContent: String { return "MainScreen.alertLoadFailContent".localizable }
        static var alertLoadFailButtonText: String { return "MainScreen.alertLoadFailButtonText".localizable }
        static var selectAllButtontext: String { return "MainScreen.selectAllButtontext".localizable }
        static var deleteActionSheetText: String { return "MainScreen.deleteActionSheetText".localizable }
        static var cancelActionSheetText: String { return "MainScreen.cancelActionSheetText".localizable }
        static var counters: String { return "MainScreen.counters".localizable }
        static var counter: String { return "MainScreen.counter".localizable }
    }
    
    struct CreateItemScreen {
        static var title: String { return "CreateItemScreen.title".localizable }
    }
}
