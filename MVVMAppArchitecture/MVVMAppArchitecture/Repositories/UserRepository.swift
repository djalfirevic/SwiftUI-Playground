//
//  UserRepository.swift
//  MVVMAppArchitecture
//
//  Created by Djuro on 4/12/21.
//

import Foundation

protocol UserRepositoryProtocol {
    func fetchUser(completion: (User) -> Void)
}

final class UserRepository: UserRepositoryProtocol {
    private let apiService: UserApiServiceProtocol
    //private let storageService: UserStorageServiceProtocol
    
    init(apiService: UserApiServiceProtocol = UserApiService()) {
        self.apiService = apiService
    }
    
    func fetchUser(completion: (User) -> Void) {
        apiService.fetchUser(completion: completion)
    }
}
