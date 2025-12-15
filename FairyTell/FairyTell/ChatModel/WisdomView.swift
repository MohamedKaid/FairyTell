//
//  WisdomView.swift
//  FairyTell
//

import SwiftUI
import FoundationModels

struct WisdomView: View {
    @ObservedObject var viewModel: ChatModle
    
    var body: some View {
        VStack {
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
            }
            
            ScrollView(.vertical) {
                Text("Tasklist")
                    .font(.largeTitle)
                Text(viewModel.output)
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.black, lineWidth: 2)
                    )
                    .foregroundStyle(Color.black)
                
                
            }
            
//            NavigationLink("View Saved Chats") {
//                ChatHistoryView(viewModel: viewModel)
//            }
//            .buttonStyle(.bordered)
//            .padding()
        }
    }
}

//#Preview {
//    WisdomView(output: "This is where the fairy’s answer will show up ✨")
//}
