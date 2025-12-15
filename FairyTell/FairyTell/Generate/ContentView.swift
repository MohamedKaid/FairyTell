//
//  GenerateView.swift
//  FairyTell
//
//  Created by Mohamed Kaid on 12/3/25.
//

import SwiftUI
import FoundationModels

struct ContentView: View {
    
    @State private var tap: Bool = false
    @State private var taskList: [Modle] = []
    @State private var tasks: [String] = []
    @State private var isLoading: Bool = false
    
    @AppStorage("userPrompt") private var userPrompt: String = ""
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @AppStorage("userName") private var storedUserName: String = ""
    @AppStorage("userPrompt") private var storedUserPrompt: String = ""
    @AppStorage("avatarWasSelected") private var avatarWasSelected: Bool = false

    @State private var showResetAlert: Bool = false

    
    let currentTopic: String = "Creativity"
    let modelSession = LanguageModelSession()
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blu, Color.black, Color.lav]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea(.all)
                
                VStack(alignment: .center) {
                    Spacer()
                    // Title
                    Text("Creative Fairy")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    
                    HStack{
                        Button {
                            Task {
                                await generate5Tasks()
                                tap = true
                            }
                        } label: {
                            Card(assetName: "Fairy3", cardName: "Lets Create")
                        }
                        .foregroundStyle(.white)
                        .disabled(modelSession.isResponding || isLoading)
                    }
                    
                    
                    
                    if isLoading {
                        ProgressView("Generating your creative tasks...")
                            .foregroundStyle(.white)
                            .padding(.top, 20)
                    } else if tasks.isEmpty {
                        Text("Tap \"The Fairy\" to get your creativity back!")
                            .foregroundStyle(.white)
                    } else {
                        NavigationLink(
                            destination: CreativeAdvenView(tasks: tasks),
                            isActive: $tap
                        ) {
                            EmptyView()
                        }
                        .hidden()
                    }
                    Spacer()
                    Button("Reset Fairy Personality") {
                        // Clear UserDefaults domain
                        if let bundleID = Bundle.main.bundleIdentifier {
                            UserDefaults.standard.removePersistentDomain(forName: bundleID)
                            UserDefaults.standard.synchronize()
                        }
                        
                        // Also clear any important @AppStorage-backed values
                        hasSeenOnboarding = false
                        storedUserName = ""
                        storedUserPrompt = ""
                        avatarWasSelected = false
                        
                        // Clear in-memory state for this screen
                        taskList.removeAll()
                        tasks.removeAll()
                        tap = false
                        isLoading = false
                        
                        // Show confirmation instead of killing the app
                        showResetAlert = true
                    }
                    .buttonStyle(.glassProminent)
                    .tint(.red)
                    .alert("Reset complete", isPresented: $showResetAlert) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text("Your fairy has been reborn!")
                    }
                }
                
            }
            
            .popover(isPresented: $isLoading) {
                loadingView(animationName: "AngryWizardWalking")
            }
        }
    }

    
    func clearAllRecommendations() {
        taskList.removeAll()
        tasks.removeAll()
    }
    
   
    
    @MainActor
    func generate5Tasks() async {
        isLoading = true
        
        // 🧹 Option 2: start clean every time the user taps the card
        clearAllRecommendations()
        tap = false   // just to make sure the NavigationLink isn't active from a previous run
        
        var newTaskList: [Modle] = []
        var newTasks: [String] = []
        
        let basePrompt = userPrompt.isEmpty
            ? """
              You are a creativity activity generator. The user has a creativity block and wants small, playful, real-world activities to get unstuck. Generate ONE micro-activity and fill the Modle fields as described.
              """
            : userPrompt
        
        for _ in 0..<5 {
            do {
                let result = try await modelSession.respond(
                    to: """
                    The user has the following creativity profile and preferences:

                    \(userPrompt)

                    Based on this profile, give the user one unique, real-world task that sparks creativity for their goal. 
                    The task must be concrete, practical, and noticeably different from common suggestions. 
                    Avoid repeating formats or themes. Make it feel personal and directed at the user.
                    Name the task with a short, specific activity phrase (not just a generic goal like "explore new styles").
                    """,
                    generating: Modle.self
                )
        
                let modelOutput = result.content
                newTaskList.append(modelOutput)
                newTasks.append(modelOutput.creativeGoal)
            } catch {
                print("generate5Tasks error:", error)
                break
            }
        }
        
        taskList = newTaskList
        tasks = newTasks
        isLoading = false
    }
}

#Preview {
    ContentView()
}
