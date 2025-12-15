//
//  LoadingView.swift
//  FairyTell
//
//  Created by Mohamed Kaid on 12/5/25.
//

//
//  loadingView.swift
//  introFoundationsModle
//
//  Created by Mohamed Kaid on 11/21/25.
//

import SwiftUI
import Lottie

struct loadingView: View {
//    @ObservedObject var viewModel: ViewModel
//    @Binding var isPresented: Bool
//    @State var animationList = ["AngryWizardWalking"]
    @State var animationName: String

    

    
    var body: some View {
        LottieView(animation: .named(animationName))
            .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
    }
    
    
    
//    var randomAnimation: String {
//        animationList.randomElement() ?? "loading"
//    }
}





#Preview {
    loadingView(animationName: "KickflipWizard")
}
