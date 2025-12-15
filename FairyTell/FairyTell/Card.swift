//
//  Card.swift
//  FairyTell
//
//  Created by Mohamed Kaid on 12/3/25.
//

import SwiftUI
import Foundation

struct Card: View {
    var assetName: String
    var cardName: String
    
    var body: some View {
        VStack {
            VStack(spacing: 12) {
                Image(assetName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 400)
                    .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                    .shadow(radius: 6)
                
                Text(cardName)
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(.white.opacity(0.45), lineWidth: 1)
            )
//            .background(
//                RoundedRectangle(cornerRadius: 22, style: .continuous)
//                    .fill(
//                        LinearGradient(
//                            colors: [
//                                Color(.systemBackground),
//                                Color(.secondarySystemBackground)
//                            ],
//                            startPoint: .topLeading,
//                            endPoint: .bottomTrailing
//                        )
//                    )
//                    .shadow(color: .black.opacity(0.12), radius: 10, x: 0, y: 6)
//            )
//            .overlay(
//                RoundedRectangle(cornerRadius: 22, style: .continuous)
//                    .stroke(Color.black.opacity(0.06), lineWidth: 1)
//            )
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

#Preview {
    ZStack {
        Color(.systemGroupedBackground).ignoresSafeArea()
        Card(assetName: "Fairy2", cardName: "Let’s Chat")
    }
}
