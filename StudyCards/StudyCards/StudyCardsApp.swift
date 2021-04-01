//
//  StudyCardsApp.swift
//  StudyCards
//
//  Created by Djuro on 4/1/21.
//

import SwiftUI
import Firebase

@main
struct StudyCardsApp: App {

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            CardListView(cardListViewModel: CardListViewModel())
        }
    }
}
