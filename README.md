# FairyTell  
AI-powered creativity guidance built with SwiftUI and Apple’s Foundation Models

FairyTell is an iOS app that helps users break through creative blocks by generating personalized, real-world creativity tasks and guiding them through progress in a focused, motivating way.

---

## What FairyTell Does

### AI-Generated Creativity Tasks
- Built using Apple’s Foundation Models framework
- Generates five unique micro-activities per session
- Tasks are personalized based on the user’s creativity profile
- Each task includes:
  - A clear creative goal
  - An explanation of why the task helps
  - An estimated completion time
  - A mood indicator

Tasks are generated individually to ensure variety and reduce repetition.

---

### Personalization
- User preferences are stored locally using `@AppStorage`
- AI prompts adapt to the user’s creative profile
- A reset option allows users to retrain their creative preferences without reinstalling the app

---

### Progress Tracking
- Interactive task checklist
- Animated completion states
- Multiple progress visualization styles that can be switched at runtime:
  - Block
  - Capsule
  - Circle
  - Gradient
  - Segmented
  - Star

Progress updates dynamically as tasks are completed.

---

### Ask the Fairy Mode
- Free-form AI interaction for creative guidance
- Supports open-ended prompts and follow-up questions
- Asynchronous AI responses with loading feedback

---

### User Experience
- Built entirely with SwiftUI and NavigationStack
- Clean, lightweight interface
- Loading overlays during AI generation
- Safe async state management

---

## Tech Stack

- SwiftUI
- Apple Foundation Models
- Generable AI models
- Async / Await
- AppStorage (UserDefaults)

---

## Getting Started

1. Clone the repository  
2. Open the project in Xcode  
3. Run on a supported device  

iOS 17+ and Xcode 15+ recommended.

---

## Future Improvements

- Task history and streak tracking
- Rich task presentation with additional context
- Sharing completed creative sessions
- Adaptive task difficulty based on engagement

---

## Author

Mohamed Kaid

---

## License

MIT License
