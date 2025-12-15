//
//  SurveyView.swift
//  FairyTell
//

import SwiftUI

struct SurveyView: View {
    let questions: [Question]
    let onComplete: (String) -> Void      // send the final prompt to another view

    @State private var currentIndex: Int = 0
    @State private var selectedAnswers: [Int]   // -1 means "no answer yet"

    init(questions: [Question], onComplete: @escaping (String) -> Void) {
        self.questions = questions
        self.onComplete = onComplete
        _selectedAnswers = State(initialValue: Array(repeating: -1, count: questions.count))
    }

    private var isLastQuestion: Bool {
        currentIndex == questions.count - 1
    }

    var body: some View {
        VStack(spacing: 24) {

            // Progress / header
            VStack(spacing: 8) {
                Text("Tell the fairy about your creativity")
                    .font(.title3)
                    .bold()

                Text("Question \(currentIndex + 1) of \(questions.count)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                // Simple progress bar
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.gray.opacity(0.2))
                        Capsule()
                            .fill(Color.accentColor)
                            .frame(width: geo.size.width * CGFloat(currentIndex + 1) / CGFloat(questions.count))
                    }
                }
                .frame(height: 8)
            }
            .padding(.horizontal)

            // Current question card
            QuestionCard(
                question: questions[currentIndex],
                selectedIndex: $selectedAnswers[currentIndex]
            )
            // 👇 Auto-advance when the user picks an answer
            .onChange(of: selectedAnswers[currentIndex]) { newValue in
                guard newValue != -1 else { return }

                // Small delay so the user can see their choice register
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    if isLastQuestion {
                        let prompt = buildPrompt()
                        onComplete(prompt)
                        // We stay on the last question visually; parent handles "Get Started"
                    } else {
                        withAnimation(.easeInOut) {
                            currentIndex += 1
                        }
                    }
                }
            }

        }
        
    }

    private func buildPrompt() -> String {
        func answer(_ index: Int) -> String {
            let selected = selectedAnswers[index]
            return questions[index].choices[selected]
        }

        return """
        You are a creativity activity generator in an iOS app.

        The user has this creativity profile:

        • Creativity Block: \(answer(0))
        • Inspiration Window: \(answer(1))
        • Creative Style: \(answer(2))
        • What Helps Them When Stuck: \(answer(3))
        • Creative Goal: \(answer(4))

        Using this profile, generate ONE short creative micro-activity that will help this user
        move past their block and toward their goal, and fill the following fields:

        • creativeGoal:
          - A short activity phrase (3–6 words), like "midnight color sketch burst"
            or "three-word idea sprint".
          - It must be concrete and actionable, not a full sentence.

        • whyItHelps:
          - One short sentence explaining why this activity helps THIS user, based on their profile.

        • estimatedMinutes:
          - A small integer like 5, 10, 15, 20, or 30 representing how long the activity takes.

        • vibeEmoji:
          - A single emoji that matches the mood, like 🎨, ✍️, 💡, 🌙, ⚡️.

        Always base the activity on the user's profile above.
        """
    }
}
