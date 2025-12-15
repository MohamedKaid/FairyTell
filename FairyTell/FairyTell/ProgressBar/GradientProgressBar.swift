//
//  Grediant.swift
//  CreativeFoundationsModel
//
//  Created by Mohamed Kaid on 11/27/25.
//

import SwiftUI

struct GradientProgressBar: View {
    var progress: Double   // 0.0 to 1.0
    
    @State private var animateGradient = false
    
    var body: some View {
        GeometryReader { geo in
            let clampedProgress = max(0, min(progress, 1))
            
            ZStack(alignment: .leading) {
                // Background track
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                
                // Filled part with animated gradient
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            colors: [
                                .blue,
                                .purple,
                                .pink
                            ],
                            startPoint: animateGradient ? .topLeading : .bottomLeading,
                            endPoint: animateGradient ? .bottomTrailing : .topTrailing
                        )
                    )
                    .frame(width: geo.size.width * clampedProgress)
                    .animation(.easeInOut, value: clampedProgress)
            }
        }
        .frame(height: 20)
        .onAppear {
            // Animate the gradient direction back and forth
            withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
                animateGradient = true
            }
        }
    }
}
