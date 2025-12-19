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
                VStack(alignment: .center){
                    Text("Your answer")
                        .font(.largeTitle)
                    Text(viewModel.output)
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.black, lineWidth: 2)
                        )
                        .foregroundStyle(Color.black)
                    
                    
                }
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
//    WisdomView(viewModel: ChatModle)
//}
