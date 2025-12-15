//
//  BarStyle.swift
//  FairyTell
//
//  Created by Mohamed Kaid on 12/2/25.
//

import Foundation


enum BarStyle: String, CaseIterable, Identifiable {
    case Block, Capsule, Circle, Gradient, Segmented, Star
    
    var id: String { rawValue }
}




