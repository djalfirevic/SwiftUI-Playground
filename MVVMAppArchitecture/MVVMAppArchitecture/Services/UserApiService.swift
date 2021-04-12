//
//  UserApiService.swift
//  MVVMAppArchitecture
//
//  Created by Djuro on 4/12/21.
//

import Foundation

protocol UserApiServiceProtocol {
    func fetchUser(completion: (User) -> Void)
}

final class UserApiService: UserApiServiceProtocol {
    func fetchUser(completion: (User) -> Void) {
        completion(.init(username: "James"))
    }
}
