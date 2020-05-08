//
//  DataStore.swift
//  DesignCode
//
//  Created by Meng To on 2020-01-31.
//  Copyright © 2020 Meng To. All rights reserved.
//

import SwiftUI
import Combine

class DataStore: ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        Api().getPosts { (posts) in
            self.posts = posts
        }
    }
}
