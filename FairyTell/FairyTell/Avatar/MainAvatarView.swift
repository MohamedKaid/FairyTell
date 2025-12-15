//
//  MainAvatarView.swift
//  FairyTell
//

import SwiftUI

struct MainAvatarView: View {
    @Binding var userName: String
    @FocusState private var isTextFieldFocused: Bool
    
    // 👇 shared with OnboardingView via the same key
    @AppStorage("avatarWasSelected") private var avatarWasSelected: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Let’s get to know you")
                        .font(.title2.bold())
                    
                    Text("Enter your name and choose an avatar. This is how the fairy will see you in the app.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 16)
                
                // Name Card
                VStack(alignment: .leading, spacing: 12) {
                    Text("Your name")
                        .font(.headline)
                    
                    HStack(spacing: 10) {
                        Image(systemName: "person.fill")
                            .foregroundStyle(.secondary)
                        
                        TextField("Enter your name", text: $userName)
                            .textInputAutocapitalization(.words)
                            .disableAutocorrection(true)
                            .focused($isTextFieldFocused)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color(.systemBackground))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color(.secondarySystemBackground))
                )
                
                // Avatar Card
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Choose your avatar")
                            .font(.headline)
                        
                        Spacer()
                    }
                    
                    Text("Scroll to browse and pick the one that feels most like you.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            // Your own component that handles selection
                            AvatarSelectionScreen()
                        }
                        .padding(.vertical, 4)
                        // 👇 this runs FOR ANY TAP inside the avatar strip
                        .simultaneousGesture(
                            TapGesture().onEnded {
                                avatarWasSelected = true
                                print("Avatar tapped, avatarWasSelected = \(avatarWasSelected)")
                            }
                        )
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color(.secondarySystemBackground))
                )
                
                Spacer(minLength: 20)
            }
            .padding(.horizontal, 20)
        }
        .scrollIndicators(.hidden)
        .onTapGesture {
            isTextFieldFocused = false
        }
    }
}

#Preview {
    MainAvatarView(userName: .constant("Mohamed"))
}
