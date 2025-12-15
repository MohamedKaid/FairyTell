////
////  ContentView.swift
////  FairyTell
////
////  Created by Mohamed Kaid on 12/3/25.
////
//
//import SwiftUI
//
//
//struct ContentView1: View {
//    var body: some View {
//        NavigationStack{
//            NavigationStack{
//                ZStack{
//                    LinearGradient(gradient: Gradient(colors: [Color.blu, Color.black, Color.lav]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                        .ignoresSafeArea(.all)
//                    VStack{
//                        Text("FairyTell")
//                            .font(.custom("FairyDustB", size: 90))
//                            .foregroundStyle(.white)
//                            .scrollIndicators(.hidden)
//                        HStack{
//                            NavigationLink {
//                                GenerateView()
//                            } label: {
//                                Card(assetName: "Fairy3", cardName: "Lets Create")
//                            }
//                            .foregroundStyle(.white)
//                        }
//                        
//                        
//                        //reset the cach and close app by forcing a crash
//                        Button("Reset App Data") {
//                            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
//                            
//                        #if DEBUG
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                                exit(0)
//                            }
//                        #endif
//                        }
//                        .padding()
//                        .buttonStyle(.bordered)
//                        .tint(.white)
//                    }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
