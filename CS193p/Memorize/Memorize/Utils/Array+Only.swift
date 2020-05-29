//
//  Array+Only.swift
//  Memorize
//
//  Created by Djuro Alfirevic on 5/29/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
