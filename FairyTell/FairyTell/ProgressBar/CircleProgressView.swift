//
//  Circle.swift
//  CreativeFoundationsModel
//
//  Created by Mohamed Kaid on 11/27/25.
//

import SwiftUI

struct CircleProgressView: View {
    var progress: Double   // 0.0 to 1.0
    
    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 12)
            
            // Progress circle
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.blue,
                    style: StrokeStyle(lineWidth: 12, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)
            
            // Percentage text
            Text("\(Int(progress * 100))%")
                .font(.headline)
        }
        .frame(width: 120, height: 120)
    }
}
