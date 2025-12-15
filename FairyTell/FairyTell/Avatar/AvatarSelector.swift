//
//  avatarSelector.swift
//  AvatarGenerator
//
//  Created by Alexus WIlliams on 11/26/25.
//

import SwiftUI

//struct Avatar: Identifiable, Hashable {
//   let id = UUID()
//    let imageName: String
//    }

struct AvatarSelector: View {
    let avatars: [Avatar]
    @Binding var selectedAvatar: Avatar?
    
    let columns = [GridItem(.adaptive(minimum: 70), spacing: 16)]
    
    
    var body: some View {
        HStack{
            ForEach(avatars) { avatar in
                Button {
                    selectedAvatar = avatar
                } label: {
                    Image(avatar.assetName)
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 150, maxWidth: 150, minHeight: 150, maxHeight: 150)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(
                                    selectedAvatar == avatar ? Color.blue : Color.clear,
                                    lineWidth: 4
                                )
                        )
                        .shadow(radius: selectedAvatar == avatar ? 6:0)
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
    }
}

struct AvatarSelectionScreen: View {
    @State private var selectedAvatar: Avatar? = nil
    let avatarOptions = [
        Avatar(assetName: "avatar1"),
        Avatar(assetName: "avatar2"),
        Avatar(assetName: "avatar3"),
        Avatar(assetName: "avatar4"),
        Avatar(assetName: "avatar5"),
        Avatar(assetName: "avatar6")
       
    ]
    var body: some View {
        VStack(alignment:.leading, spacing: 20) {
           
            
            AvatarSelector(avatars: avatarOptions,
                           selectedAvatar: $selectedAvatar)
            
            if let avatar = selectedAvatar {
                Text("Selected: \(avatar.assetName)")
                    .font(.headline)
            }
            Spacer()
        }
        .padding()
    }
}


#Preview {
    AvatarSelector(avatars: [Avatar(assetName: "avatar1"), Avatar(assetName: "avatar2"), Avatar(assetName: "avatar3"), Avatar(assetName: "avatar4"), Avatar(assetName: "avatar5")], selectedAvatar: .constant(nil))
}
#Preview{
    AvatarSelectionScreen()
}
