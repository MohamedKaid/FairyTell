//
//  c.swift
//  CreativeFoundationsModel
//
//  Created by Mohamed Kaid on 11/27/25.
//

import SwiftUI

struct CapsuleProgressBar: View {
    var progress: Double   // 0.0 to 1.0
    
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 20)
            
            Capsule()
                .fill(Color.blue)
                .frame(width: progress * 300, height: 20)   // 300 = total width
                .animation(.easeInOut, value: progress)
        }
    }
}
