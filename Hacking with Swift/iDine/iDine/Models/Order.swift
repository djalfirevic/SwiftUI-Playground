//
//  Order.swift
//  iDine
//
//  Created by Djuro Alfirevic on 5/19/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

class Order {
    
    // MARK: - Properties
    var items = [MenuItem]()

    // MARK: - Computed Properties
    var total: Int {
        if items.count > 0 {
            return items.reduce(0) { $0 + $1.price }
        } else {
            return 0
        }
    }

    // MARK: - Public API
    func add(item: MenuItem) {
        items.append(item)
    }

    func remove(item: MenuItem) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
    
}
