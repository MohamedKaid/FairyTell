//
//  OnboardingView.swift
//  FairyTell
//

import SwiftUI
import Foundation

struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    @AppStorage("userName") private var storedUserName: String = ""
    @AppStorage("userPrompt") private var storedUserPrompt: String = ""
    @AppStorage("avatarWasSelected") private var avatarWasSelected: Bool = false
    
    @State private var hasCompletedSurvey: Bool = false
    @State private var currentPage = 0
    @State private var userPrompt: String = ""
    @State private var userName: String = ""
    
    private var lastPageIndex: Int { 2 }
    
    private var isCurrentPageValid: Bool {
        switch currentPage {
        case 0:
            return true
        case 1:
            let hasName = !userName
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .isEmpty
            return hasName && avatarWasSelected
        case 2:
            return hasCompletedSurvey
        default:
            return true
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                if currentPage == 0 {
                    IntroInfoView()
                        .transition(.slide)
                } else if currentPage == 1 {
                    MainAvatarView(userName: $userName)
                        .transition(.slide)
                } else {
                    SurveyView(questions: SurveyQuestions) { prompt in
                        userPrompt = prompt
                        hasCompletedSurvey = true
                    }
                    .transition(.move(edge: .leading))
                }
            }
            .animation(.easeInOut, value: currentPage)

            
            VStack(spacing: 16) {
                // dots
                HStack(spacing: 8) {
                    ForEach(0...lastPageIndex, id: \.self) { index in
                        Circle()
                            .fill(index == currentPage ? Color.primary : Color.gray.opacity(0.3))
                            .frame(width: 8, height: 8)
                    }
                }
                
                let canContinue = isCurrentPageValid
                
                Button {
                    if currentPage < lastPageIndex {
                        withAnimation {
                            currentPage += 1
                        }
                    } else {
                        storedUserName = userName
                        storedUserPrompt = userPrompt
                        hasSeenOnboarding = true
                    }
                } label: {
                    Text(currentPage == lastPageIndex ? "Get Started" : "Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .bold()
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(canContinue ? Color.black : Color.gray.opacity(0.4))
                        )
                        .foregroundStyle(.white)
                }
                .disabled(!canContinue)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
            .background(
                Color(.systemBackground)
                    .ignoresSafeArea(edges: .bottom)
            )
        }
        .onAppear {
            avatarWasSelected = false
        }
    }
}
