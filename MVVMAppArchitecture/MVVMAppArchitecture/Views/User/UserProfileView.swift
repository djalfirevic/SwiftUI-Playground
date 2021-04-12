//
//  UserProfileView.swift
//  MVVMAppArchitecture
//
//  Created by Djuro on 4/12/21.
//

import SwiftUI

struct UserProfileView: View {
    @StateObject private var viewModel = UserProfileViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text(viewModel.username)
                    Spacer()
                }
                Spacer()
            }
            .padding(25)
            .onAppear {
                self.viewModel.onAppear()
            }
            .navigationTitle("Profile")
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
