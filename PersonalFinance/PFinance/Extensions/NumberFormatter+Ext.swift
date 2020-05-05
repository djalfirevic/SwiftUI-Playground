//
//  Number+Ext.swift
//  PFinance
//
//  Created by Djuro Alfirevic on 5/5/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import Foundation

extension NumberFormatter {
    static func currency(from value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let formattedValue = formatter.string(from: NSNumber(value: value)) ?? ""
        
        return "$" + formattedValue
    }
}
