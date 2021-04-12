//
//  UserProfileViewModel.swift
//  MVVMAppArchitecture
//
//  Created by Djuro on 4/12/21.
//

import Foundation

final class UserProfileViewModel: ObservableObject {
    @Published var username = ""
    
    private let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }
    
    func onAppear() {
        repository.fetchUser { user in
            self.username = user.username
        }
    }
}
