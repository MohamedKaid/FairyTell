//
//  p.swift
//  CreativeFoundationsModel
//
//  Created by Mohamed Kaid on 11/27/25.
//
import SwiftUI

struct SegmentedProgressBar: View {
    var progress: Double      // 0.0 to 1.0
    var segments: Int = 5     // how many blocks
    
    var body: some View {
        let clampedProgress = max(0, min(progress, 1))
        let filledSegments = Int((clampedProgress * Double(segments)).rounded(.down))
        
        HStack(spacing: 6) {
            ForEach(0..<segments, id: \.self) { index in
                RoundedRectangle(cornerRadius: 6)
                    .fill(index < filledSegments ? Color.green : Color.gray.opacity(0.2))
                    .frame(height: 16)
                    .animation(.easeInOut, value: filledSegments)
            }
        }
    }
}
