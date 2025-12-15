//
//  Bar.swift
//  FairyTell
//
//  Created by Mohamed Kaid on 12/2/25.
//

import Foundation

struct Bar: Hashable {
    var name: String
    var style: BarStyle = .Circle

    func barChoice() -> String {
        return style.rawValue
    }
}

