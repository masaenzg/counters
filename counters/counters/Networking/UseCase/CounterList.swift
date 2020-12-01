//
//  CounterList.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 30/11/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import Foundation

struct CounterBody: Decodable {
    var id: String
    var title: String
    var count: Int
}
