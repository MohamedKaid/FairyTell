//
//  star.swift
//  CreativeFoundationsModel
//
//  Created by Mohamed Kaid on 11/27/25.
//

import SwiftUI

struct StarProgressView: View {
    var progress: Double   // 0.0 to 1.0
    
    var body: some View {
        let clampedProgress = max(0, min(progress, 1))
        
        GeometryReader { geo in
            ZStack {
                // Outline / background star
                Image(systemName: "star")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray.opacity(0.3))
                
                // Filled part of the star
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.yellow)
                    .mask(
                        // Mask rectangle that grows from bottom to top
                        Rectangle()
                            .frame(height: geo.size.height * clampedProgress)
                            .offset(y: geo.size.height * (1 - clampedProgress))
                    )
                    .animation(.easeInOut, value: clampedProgress)
            }
        }
        .frame(width: 60, height: 60)
    }
}
