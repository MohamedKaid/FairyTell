//
//  chatModle.swift
//  FairyTell
//
//  Created by Mohamed Kaid on 12/3/25.
//

import FoundationModels
import Foundation
internal import Combine

@MainActor
class ChatModle: ObservableObject {
    @Published var userInput = ""
    @Published var output = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
   
    
    private let model = SystemLanguageModel.default
    
    func runModel() async {
        guard model.isAvailable else {
            errorMessage = "Model is not available, on this device you might need to update your device"
            return
        }
        
        isLoading = true
        errorMessage = nil

        let prompt = userInput.isEmpty ? "Hello, how are you?" : userInput
        
       
        let session = LanguageModelSession()
        
        do {
            let response = try await session.respond(to: prompt)
            self.output = response.content
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
