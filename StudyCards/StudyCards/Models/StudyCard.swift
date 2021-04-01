//
//  StudyCard.swift
//  StudyCards
//
//  Created by Djuro on 4/1/21.
//

import FirebaseFirestoreSwift

struct StudyCard: Identifiable, Codable {
    @DocumentID var id: String?
    var question: String
    var answer: String
    var passed: Bool = false
}
