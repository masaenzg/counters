//
//  Encodable+Extension.swift
//  counters
//
//  Created by Manuel Adolfo Saenz Grijalba on 30/11/20.
//  Copyright © 2020 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import Foundation

extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}
