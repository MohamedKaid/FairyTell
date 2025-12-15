//
//  FairyTellApp.swift
//  FairyTell
//
//  Created by Mohamed Kaid on 12/2/25.
//

import SwiftUI

@main
struct FairyTellApp: App {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
        
        var body: some Scene {
            WindowGroup {
                if hasSeenOnboarding {
                    ContentView()
                        .preferredColorScheme(.light)
                } else {
                    OnboardingView()
                        .preferredColorScheme(.light)
                }
            }
        }
    }
