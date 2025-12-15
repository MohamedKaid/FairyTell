//
//  VerticalGradientExample.swift
//  AvatarGenerator
//
//  Created by Alexus WIlliams on 12/2/25.
//

import SwiftUI

struct VerticalGradientExample: View {
    @State private var rotationAngle: Angle = .zero
    
    var body: some View {
        
        VStack {
            Text("FairyTell")
                .font(.custom("SignPainterHouseScript", size: 20))
                .padding()
            
            Text("AI created using iOS Foundation Models Framework")
                
            
            Image("Fairy")
                .resizable()
                .frame(width: 200, height: 200)
                .rotationEffect(rotationAngle)
                .animation(.linear(duration: 2).repeatForever(autoreverses: true), value: rotationAngle)
                .onAppear{
                    withAnimation(.linear(duration:2).repeatCount(0, autoreverses: true)){
                        rotationAngle = .degrees(360)
                                                
                    }
                }
            
        }
    }
}
    #Preview {
        VerticalGradientExample()
    }

    

