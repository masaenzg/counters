//
//  ErrorAPI.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 1/12/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import Foundation

enum ErrorAPI: Error {
    case internetConnectionFailed
    case notDataFount
    case unableParse
}
