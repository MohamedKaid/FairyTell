//
//  GenerateView.swift
//  FairyTell
//
//  FIX: Stable navigation (no hidden conditional NavigationLink)
//  - We removed the `NavigationLink(isActive:)` that only exists when tasks != empty.
//  - We use `.navigationDestination(isPresented:)` which is always attached to the stack.
//  - We only navigate AFTER tasks are generated successfully.
//  - We separated loading-popover state from `isLoading` to avoid UI side-effects.
//

import SwiftUI
import FoundationModels

struct ContentView: View {

    //Navigation
    @State private var showTasksScreen: Bool = false

    //Data
    @State private var taskList: [Modle] = []
    @State private var tasks: [String] = []

    //Loading
    @State private var isLoading: Bool = false
    @State private var showLoadingPopover: Bool = false

    
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

                    //Generate Button
                    Button {
                        Task {
                            beginLoadingUI()
                            await generate5Tasks()
                            endLoadingUI()
                            if !tasks.isEmpty {
                                showTasksScreen = true
                            }
                        }
                    } label: {
                        Card(assetName: "Fairy3", cardName: "Lets Create")
                    }
                    .foregroundStyle(.white)
                    .disabled(modelSession.isResponding || isLoading)

                    //Status Text
                    if isLoading {
                        ProgressView("Generating your creative tasks...")
                            .foregroundStyle(.white)
                            .padding(.top, 20)
                    } else if tasks.isEmpty {
                        Text("Tap \"The Fairy\" to get your creativity back!")
                            .foregroundStyle(.white)
                            .padding(.top, 12)
                    }

                    Spacer()

                    //Reset
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
            .navigationDestination(isPresented: $showTasksScreen) {
                CreativeAdvenView(tasks: tasks)
            }
            //popover is controlled
            .popover(isPresented: $showLoadingPopover) {
                loadingView(animationName: "AngryWizardWalking")
            }
        }
    }

    //Loading UI helpers (NEW)
    private func beginLoadingUI() {
        isLoading = true
        showLoadingPopover = true
        showTasksScreen = false
    }

    private func endLoadingUI() {
        isLoading = false
        showLoadingPopover = false
    }

    //Reset
    private func resetAppData() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }

        hasSeenOnboarding = false
        storedUserName = ""
        userPrompt = ""
        avatarWasSelected = false

        taskList.removeAll()
        tasks.removeAll()

        //reset navigation + popover too
        showTasksScreen = false
        showLoadingPopover = false
        isLoading = false
    }

    private func clearAllRecommendations() {
        taskList.removeAll()
        tasks.removeAll()
    }

    //Generation
    @MainActor
    func generate5Tasks() async {
        clearAllRecommendations()

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
    }
}

#Preview {
    ContentView()
}
