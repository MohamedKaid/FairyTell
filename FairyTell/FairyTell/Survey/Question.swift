//
//  Question.swift
//  FairyTell
//
//  Created by Mohamed Kaid on 12/4/25.
//

import Foundation

struct Question: Identifiable, Hashable {
    let id = UUID()
    let text: String
    let choices: [String]
}


