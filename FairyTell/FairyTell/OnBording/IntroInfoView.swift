//
//  IntroInfoView.swift
//  FairyTell
//
//  Created by Mohamed Kaid on 12/5/25.
//

import SwiftUI

struct IntroInfoView: View {
    var body: some View {
        VStack(spacing: 24) {
            
            Spacer(minLength: 40)
            
           
            VStack(spacing: 12) {
                Text("Welcome to FairyTell")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                
                Text("A tiny fairy helps you stay creative with small, playful tasks made just for you.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            
            Image("Fairy")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 220)
                .padding(.top, 10)
            
            
            VStack(alignment: .leading, spacing: 8) {
                Label("Set your name and avatar", systemImage: "person.crop.circle")
                Label("Answer a few fun questions", systemImage: "sparkles")
                Label("Get tiny creative missions", systemImage: "checkmark.circle")
            }
            .font(.title3)
            .foregroundStyle(.black)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color(.secondarySystemBackground))
            )
            .padding(.horizontal, 24)
            
            Spacer()
        }
    }
}

#Preview {
    IntroInfoView()
}
