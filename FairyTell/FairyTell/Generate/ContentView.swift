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

    // ✅ Only ONE userPrompt key
    @AppStorage("userPrompt") private var userPrompt: String = ""

    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @AppStorage("userName") private var storedUserName: String = ""
    @AppStorage("avatarWasSelected") private var avatarWasSelected: Bool = false

    @State private var showResetAlert: Bool = false
    @State private var modelSession = LanguageModelSession()


    let currentTopic: String = "Creativity"
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blu, Color.black, Color.lav]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(alignment: .center) {
                    Spacer()

                    Text("Creative Fairy")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)

                    HStack {
                        Button {
                            Task {
                                modelSession = LanguageModelSession()
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
                        resetAppData()
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
                .padding()
            }
            .popover(isPresented: $isLoading) {
                loadingView(animationName: "AngryWizardWalking")
            }
        }
    }

    private func resetAppData() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }

        // Re-assert the important ones (optional but fine)
        hasSeenOnboarding = false
        storedUserName = ""
        userPrompt = ""
        avatarWasSelected = false

        // Clear runtime state
        taskList.removeAll()
        tasks.removeAll()
        tap = false
        isLoading = false
    }

    private func clearAllRecommendations() {
        taskList.removeAll()
        tasks.removeAll()
    }

    @MainActor
    func generate5Tasks() async {
        isLoading = true

        clearAllRecommendations()
        tap = false

        var newTaskList: [Modle] = []
        var newTasks: [String] = []

        
        let profileText = userPrompt.isEmpty
        ? """
        The user has a creativity block and wants small, playful, real-world activities to get unstuck.
        """
        : userPrompt

        var attempts = 0
        while newTasks.count < 5 && attempts < 10 {
            attempts += 1
            do {
                let result = try await modelSession.respond(
                    to: """
                    Creativity profile:
                    \(profileText)

                    You will generate ONE micro-task. This function will be called 5 times in a row.
                    Your job is to make each result feel different from the others in THIS run.

                    Hard rules (must follow):
                    - The task must be EASY, real-world, and doable in 5–15 minutes.
                    - It must be concrete: include a specific action + a clear output (a note, sketch, list, photo, voice memo, etc.).
                    - DO NOT reuse the same idea, format, or theme you used earlier in this run.
                    - Avoid repeating common advice patterns (no “explore new styles”, “try something new”, “take a walk”, “listen to music”, “brainstorm”, “mind map”, “free write”).
                    - Vary the format each time (writing / visual / movement / constraint game / observation).
                    - Name it as a short, specific activity phrase.

                    Return exactly one task using the Modle fields.
                    """,
                    generating: Modle.self
                )

                let modelOutput = result.content
                newTaskList.append(modelOutput)
                newTasks.append(modelOutput.creativeGoal)
            } catch {
                print("generate5Tasks error:", error)
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
