//
//  FairyWisdom.swift
//  FairyTell
//

import SwiftUI
import FoundationModels

struct FairyWisdom: View {
    @StateObject private var viewModel = ChatModle()
    @FocusState private var isTextEditorFocused: Bool
    @State var push: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.blu, Color.black, Color.lav]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea(.all)
                VStack(alignment: .center, spacing: 20) {
                    
                    Text("What do you need help with:")
                        .font(.title)
                        .foregroundStyle(Color.white)
                    
                    TextField("Enter prompt",text: $viewModel.userInput, axis:.vertical)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                        )
                        .foregroundStyle(Color.primary)
                        .focused($isTextEditorFocused)
                    
                    Button {
                        Task {
                            await viewModel.runModel()
                        }
                        push=true
                    } label: {
                        Label("Send", systemImage: "paperplane")
                            .font(.headline)
                    }
                    .buttonStyle(.bordered)
                    .tint(Color.white)
                    .disabled(viewModel.isLoading)   // disable while loading
                    
                    NavigationLink(
                        destination: WisdomView(viewModel: viewModel),
                        
                        isActive: $push
                    ){EmptyView()}
                        .hidden()
                    
                    
                    //         display the output from the foundations model
                    //                    if let error = viewModel.errorMessage {
                    //                        Text(error)
                    //                            .foregroundStyle(.red)
                    //                    }
                    //
                    //                    ScrollView(.vertical) {
                    //                        Text("Tasklist")
                    //                            .font(Font.largeTitle)
                    //                        Text(viewModel.output)
                    //                            .padding()
                    //                            .foregroundStyle(.black)
                    //                    }
                    
                }
                .padding()
                .onTapGesture {
                    isTextEditorFocused = false
                }
            }
            
            .popover(isPresented: $viewModel.isLoading) {
                loadingView(animationName: "WalkingLadyMagic")
            }
        }
    }
    
}
