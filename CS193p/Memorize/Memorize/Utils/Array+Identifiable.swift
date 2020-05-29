//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Djuro Alfirevic on 5/29/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        
        return 0 // TODO: bogus
    }
}
