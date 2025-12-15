//
//  QuestionCard.swift
//  FairyTell
//
//  Created by Mohamed Kaid on 12/4/25.
//

import SwiftUI

struct QuestionCard: View {
    let question: Question
    @Binding var selectedIndex: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(question.text)
                .font(.headline)

            ForEach(question.choices.indices, id: \.self) { index in
                HStack {
                    Image(systemName: selectedIndex == index ? "largecircle.fill.circle" : "circle")
                        .imageScale(.large)

                    Text(question.choices[index])

                    Spacer()
                }
                .padding(.vertical, 4)
                .onTapGesture {
                    selectedIndex = index
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
        )
        .padding()
    }
}


#Preview {
    QuestionCard(
        question: Question(
            text: "What usually blocks your creativity the most?",
            choices: [
                "Overthinking",
                "Not knowing where to start",
                "Lack of motivation",
                "Too many ideas"
            ]
        ),
        selectedIndex: .constant(0) // preview mock selection
    )
}


