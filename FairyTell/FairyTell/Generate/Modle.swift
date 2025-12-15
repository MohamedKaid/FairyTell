//
//  Modle.swift
//  FairyTell
//
//  Created by Mohamed Kaid on 12/2/25.
//

import Foundation
import FoundationModels

@Generable
struct Modle: Identifiable {
    var id = UUID().uuidString

    @Guide(description: "Briefly in less then 5 words describe the user's creative goal, for example: 'write a song', 'finish a poem', or 'come up with a logo idea'.")
    var creativeGoal: String


    @Guide(description: "Explain in one short sentence why this task can help them get more creative or inspired.")
    var whyItHelps: String

    @Guide(description: "Estimate how many minutes this task might take. Use a small integer like 5, 10, 20, or 30.")
    var estimatedMinutes: Int

    @Guide(description: "Give a single emoji that matches the mood of this creativity task, like 🎧, 🎨, ✍️, or 🌧️.")
    var vibeEmoji: String
}
