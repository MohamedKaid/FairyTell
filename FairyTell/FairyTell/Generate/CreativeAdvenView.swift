import SwiftUI

struct CreativeAdvenView: View {
    @State private var selectedBar: BarStyle = .Circle
    @State private var done: [Bool] = []
    @State private var navigate: Bool = false
    let tasks: [String]
    
    private var completedCount: Int {
        done.filter { $0 }.count
    }
    
    
    private var progressValue: Double {
        guard !tasks.isEmpty else { return 0 }
        return Double(completedCount) / Double(tasks.count)
    }
    
    
    private func isDone(_ index: Int) -> Bool {
        guard index < done.count else { return false }
        return done[index]
    }
    
    
    private func toggleDone(at index: Int) {
        if index >= done.count {
            let extra = index - done.count + 1
            done.append(contentsOf: Array(repeating: false, count: extra))
        }
        withAnimation {
            done[index].toggle()
        }
    }
    
    
    
    var body: some View {
        ZStack(){
            LinearGradient(gradient: Gradient(colors: [Color.blu, Color.black, Color.lav]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(.all)
            VStack(spacing: 12) {
                
                VStack(alignment: .center, spacing: 15) {
                    HStack {
                        Text("Progress:")
                            .font(.title)
                        
                        Spacer()
                        
                        Menu {
                            ForEach(BarStyle.allCases) { style in
                                Button(style.rawValue) {
                                    selectedBar = style   // <- this is the key line
                                }
                            }
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: "line.horizontal.3")
                                Text("Bar Style")
                            }
                            .font(.subheadline)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue.opacity(0.5), lineWidth: 1)
                            )
                        }
                        
                    }
                    
                    // Progress Bar
                    switch selectedBar {
                    case .Block:
                        BlockProgressBar(progress: progressValue)
                    case .Capsule:
                        CapsuleProgressBar(progress: progressValue)
                    case .Circle:
                        CircleProgressView(progress: progressValue)
                    case .Gradient:
                        GradientProgressBar(progress: progressValue)
                    case .Segmented:
                        SegmentedProgressBar(progress: progressValue)
                    case .Star:
                        StarProgressView(progress: progressValue)
                    }
                    
                    
                    
                    Text("Current style: \(selectedBar.rawValue)")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    
                    Text("\(completedCount) of \(tasks.count) completed")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)
                .padding(.top)
                
                // Checklist section
                List {
                    ForEach(tasks.indices, id: \.self) { i in
                        HStack {
                            // Toggle button
                            Button {
                                toggleDone(at: i)
                            } label: {
                                Image(systemName: isDone(i) ? "checkmark.circle.fill" : "circle")
                                    .font(.title2)
                                    .foregroundColor(isDone(i) ? .green : .gray)
                            }
                            .buttonStyle(.plain)
                            
                            // Task text
                            Text(tasks[i])
                                .strikethrough(isDone(i))
                                .foregroundColor(isDone(i) ? .gray : .primary)
                        }
                        .padding(.vertical, 6)
                    }
                }
                .listStyle(.insetGrouped)
                
                Button {
                    navigate = true
                } label: {
                    Text("Ask the fairy anything!")
                        .fontWeight(.bold)
                        .padding()
                }
                .buttonStyle(.glassProminent)
                .tint(.blu)
                .frame(maxWidth: .infinity)
                
                NavigationLink(
                    destination: FairyWisdom(),
                    isActive: $navigate
                ) {
                    EmptyView()
                }
                
            }
            .onAppear {
                if done.count != tasks.count {
                    done = Array(repeating: false, count: tasks.count)
                }
            }
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    CreativeAdvenView(tasks: ["A","","","",""])
}
