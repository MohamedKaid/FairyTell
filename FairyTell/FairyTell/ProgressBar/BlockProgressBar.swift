//
//  Block.swift
//  CreativeFoundationsModel
//
//  Created by Mohamed Kaid on 11/27/25.
//

import SwiftUI

struct BlockProgressBar: View {
    var progress: Double
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.green)
                    .frame(width: geo.size.width * progress)
                    .animation(.easeInOut, value: progress)
            }
        }
        .frame(height: 25)
    }
}

