//
//  StorageController.swift
//  Architecture
//
//  Created by Djuro Alfirevic on 5/10/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import Foundation

final class StorageController {
    
    // MARK: - Properties
    private let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private var accountsFileURL: URL {
        return documentsDirectoryURL.appendingPathComponent("Accounts").appendingPathExtension("json")
    }
    
    // MARK: - Public API
    func save(_ accounts: [Account]) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(accounts) else { return }
        try? data.write(to: accountsFileURL)
    }
    
    func fetchAccounts() -> [Account] {
        guard let data = try? Data(contentsOf: accountsFileURL) else { return [] }
        
        let decoder = JSONDecoder()
        let accounts = try? decoder.decode([Account].self, from: data)
        return accounts ?? []
    }
    
}
