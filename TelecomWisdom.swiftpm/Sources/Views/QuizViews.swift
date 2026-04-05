import SwiftUI

struct QuizHomeView: View {
    @EnvironmentObject var quizStore: QuizStore
    @State private var selectedService: String? = nil
    @State private var selectedCategory: QuizCategory? = nil
    @State private var selectedDifficulty: QuizDifficulty = .intermediate
    @State private var questionCount = 10
    @State private var showQuiz = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    statsCard
                    configSection
                    startButton
                    if !quizStore.results.isEmpty {
                        historySection
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Quiz")
            .navigationDestination(isPresented: $showQuiz) {
                QuizSessionView(
                    serviceId: selectedService,
                    category: selectedCategory,
                    difficulty: selectedDifficulty,
                    questionCount: questionCount
                )
            }
        }
    }

    private var statsCard: some View {
        HStack(spacing: 12) {
            QuizStatCard(icon: "checkmark.circle.fill", value: "\(quizStore.totalQuizzesTaken)", label: "Quizzes", color: .green)
            QuizStatCard(icon: "chart.bar.fill", value: quizStore.totalQuizzesTaken > 0 ? "\(Int(quizStore.averageScore))%" : "—", label: "Average", color: .blue)
            QuizStatCard(icon: "star.fill", value: quizStore.bestScore > 0 ? "\(Int(quizStore.bestScore))%" : "—", label: "Best", color: .yellow)
        }
    }

    private var configSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Configure Quiz")
                .font(.headline)

            // Service filter
            VStack(alignment: .leading, spacing: 6) {
                Text("Topic")
                    .font(.subheadline.bold())
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        FilterChip(title: "All Topics", isSelected: selectedService == nil) {
                            selectedService = nil
                        }
                        ForEach(ServiceCatalog.allServices) { service in
                            let hasQuestions = !QuizCatalog.questions(for: service.id).isEmpty
                            if hasQuestions {
                                FilterChip(title: service.name, isSelected: selectedService == service.id) {
                                    selectedService = service.id
                                }
                            }
                        }
                    }
                }
            }

            // Category filter
            VStack(alignment: .leading, spacing: 6) {
                Text("Category")
                    .font(.subheadline.bold())
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        FilterChip(title: "All", isSelected: selectedCategory == nil) {
                            selectedCategory = nil
                        }
                        ForEach(QuizCategory.allCases, id: \.rawValue) { cat in
                            FilterChip(title: cat.rawValue, isSelected: selectedCategory == cat) {
                                selectedCategory = cat
                            }
                        }
                    }
                }
            }

            // Difficulty
            VStack(alignment: .leading, spacing: 6) {
                Text("Difficulty")
                    .font(.subheadline.bold())
                Picker("Difficulty", selection: $selectedDifficulty) {
                    ForEach(QuizDifficulty.allCases, id: \.rawValue) { d in
                        Text(d.rawValue).tag(d)
                    }
                }
                .pickerStyle(.segmented)
            }

            // Question count
            VStack(alignment: .leading, spacing: 6) {
                Text("Questions: \(questionCount)")
                    .font(.subheadline.bold())
                Picker("Count", selection: $questionCount) {
                    Text("5").tag(5)
                    Text("10").tag(10)
                    Text("15").tag(15)
                    Text("All").tag(50)
                }
                .pickerStyle(.segmented)
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 14))
    }

    private var startButton: some View {
        let available = QuizCatalog.questions(for: selectedService, category: selectedCategory, difficulty: selectedDifficulty).count
        return VStack(spacing: 6) {
            Button {
                showQuiz = true
            } label: {
                Label("Start Quiz", systemImage: "play.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(available > 0 ? Color.blue : Color.gray, in: RoundedRectangle(cornerRadius: 12))
                    .foregroundStyle(.white)
            }
            .disabled(available == 0)
            Text("\(available) questions available")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var historySection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recent Results")
                .font(.headline)
            ForEach(quizStore.results.suffix(5).reversed()) { result in
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(result.serviceId ?? "Mixed")
                            .font(.caption.bold())
                        Text(result.date.formatted(.dateTime.month().day().hour().minute()))
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                    }
                    Spacer()
                    Text("\(result.correctAnswers)/\(result.totalQuestions)")
                        .font(.subheadline)
                    Text("\(Int(result.percentage))%")
                        .font(.subheadline.bold())
                        .foregroundStyle(result.percentage >= 70 ? .green : result.percentage >= 50 ? .orange : .red)
                }
                .padding(.vertical, 6)
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 14))
    }
}

// MARK: - Quiz Session

struct QuizSessionView: View {
    let serviceId: String?
    let category: QuizCategory?
    let difficulty: QuizDifficulty
    let questionCount: Int

    @EnvironmentObject var quizStore: QuizStore
    @Environment(\.dismiss) private var dismiss

    @State private var questions: [QuizQuestion] = []
    @State private var currentIndex = 0
    @State private var selectedAnswer: Int? = nil
    @State private var hasAnswered = false
    @State private var correctCount = 0
    @State private var answers: [Int?] = []
    @State private var startTime = Date()
    @State private var showResults = false

    var body: some View {
        Group {
            if showResults {
                resultsView
            } else if questions.isEmpty {
                Text("No questions available for this selection.")
                    .foregroundStyle(.secondary)
            } else {
                questionView
            }
        }
        .navigationTitle("Question \(currentIndex + 1)/\(questions.count)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Quit") { dismiss() }
            }
        }
        .onAppear { loadQuestions() }
    }

    private var questionView: some View {
        let q = questions[currentIndex]
        return ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Progress
                ProgressView(value: Double(currentIndex + 1), total: Double(questions.count))
                    .tint(.blue)

                // Difficulty & category badges
                HStack {
                    Text(q.difficulty.rawValue)
                        .font(.caption2.bold())
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(difficultyColor(q.difficulty).opacity(0.15), in: Capsule())
                        .foregroundStyle(difficultyColor(q.difficulty))
                    Text(q.category.rawValue)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }

                // Question
                Text(q.question)
                    .font(.body.bold())

                // Options
                ForEach(Array(q.options.enumerated()), id: \.offset) { index, option in
                    Button {
                        if !hasAnswered {
                            selectedAnswer = index
                            hasAnswered = true
                            if index == q.correctIndex { correctCount += 1 }
                            answers.append(index)
                        }
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: optionIcon(index: index, correct: q.correctIndex))
                                .foregroundStyle(optionColor(index: index, correct: q.correctIndex))
                            Text(option)
                                .font(.subheadline)
                                .foregroundStyle(.primary)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .padding()
                        .background(optionBackground(index: index, correct: q.correctIndex), in: RoundedRectangle(cornerRadius: 10))
                    }
                    .disabled(hasAnswered)
                }

                // Explanation (after answering)
                if hasAnswered {
                    VStack(alignment: .leading, spacing: 8) {
                        Label(selectedAnswer == q.correctIndex ? "Correct!" : "Incorrect", systemImage: selectedAnswer == q.correctIndex ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .font(.subheadline.bold())
                            .foregroundStyle(selectedAnswer == q.correctIndex ? .green : .red)

                        Text(q.explanation)
                            .font(.caption)

                        Text("Reference: \(q.reference)")
                            .font(.caption2)
                            .foregroundStyle(.blue)
                    }
                    .padding()
                    .background(Color(.tertiarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 10))

                    // Next button
                    Button {
                        if currentIndex < questions.count - 1 {
                            currentIndex += 1
                            selectedAnswer = nil
                            hasAnswered = false
                        } else {
                            finishQuiz()
                        }
                    } label: {
                        Text(currentIndex < questions.count - 1 ? "Next Question" : "See Results")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.blue, in: RoundedRectangle(cornerRadius: 12))
                            .foregroundStyle(.white)
                    }
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }

    private var resultsView: some View {
        let percentage = questions.isEmpty ? 0 : Double(correctCount) / Double(questions.count) * 100
        return ScrollView {
            VStack(spacing: 24) {
                // Score Circle
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 12)
                        .frame(width: 120, height: 120)
                    Circle()
                        .trim(from: 0, to: percentage / 100)
                        .stroke(percentage >= 70 ? Color.green : percentage >= 50 ? Color.orange : Color.red, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                        .frame(width: 120, height: 120)
                        .rotationEffect(.degrees(-90))
                    VStack {
                        Text("\(Int(percentage))%")
                            .font(.title.bold())
                        Text("\(correctCount)/\(questions.count)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                Text(percentage >= 80 ? "Excellent!" : percentage >= 60 ? "Good job!" : percentage >= 40 ? "Keep practicing!" : "Review the material")
                    .font(.title3.bold())

                // Review each question
                VStack(alignment: .leading, spacing: 12) {
                    Text("Review")
                        .font(.headline)
                    ForEach(Array(questions.enumerated()), id: \.offset) { i, q in
                        let userAnswer = i < answers.count ? answers[i] : nil
                        let isCorrect = userAnswer == q.correctIndex
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundStyle(isCorrect ? .green : .red)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(q.question)
                                    .font(.caption.bold())
                                if !isCorrect {
                                    Text("Your answer: \(userAnswer != nil ? q.options[userAnswer!] : "None")")
                                        .font(.caption2)
                                        .foregroundStyle(.red)
                                    Text("Correct: \(q.options[q.correctIndex])")
                                        .font(.caption2)
                                        .foregroundStyle(.green)
                                }
                            }
                        }
                    }
                }
                .padding()
                .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))

                Button { dismiss() } label: {
                    Text("Done")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue, in: RoundedRectangle(cornerRadius: 12))
                        .foregroundStyle(.white)
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Results")
    }

    // MARK: - Logic

    private func loadQuestions() {
        let pool = QuizCatalog.questions(for: serviceId, category: category, difficulty: difficulty)
        questions = Array(pool.shuffled().prefix(questionCount))
        startTime = Date()
    }

    private func finishQuiz() {
        let elapsed = Date().timeIntervalSince(startTime)
        let result = QuizResult(
            id: UUID(),
            date: Date(),
            serviceId: serviceId,
            category: category,
            totalQuestions: questions.count,
            correctAnswers: correctCount,
            timeTaken: elapsed
        )
        quizStore.recordResult(result)
        showResults = true
    }

    // MARK: - Styling

    private func optionIcon(index: Int, correct: Int) -> String {
        guard hasAnswered else { return "circle" }
        if index == correct { return "checkmark.circle.fill" }
        if index == selectedAnswer { return "xmark.circle.fill" }
        return "circle"
    }

    private func optionColor(index: Int, correct: Int) -> Color {
        guard hasAnswered else { return .secondary }
        if index == correct { return .green }
        if index == selectedAnswer { return .red }
        return .secondary
    }

    private func optionBackground(index: Int, correct: Int) -> Color {
        guard hasAnswered else {
            return Color(.secondarySystemGroupedBackground)
        }
        if index == correct { return Color.green.opacity(0.08) }
        if index == selectedAnswer && index != correct { return Color.red.opacity(0.08) }
        return Color(.secondarySystemGroupedBackground)
    }

    private func difficultyColor(_ d: QuizDifficulty) -> Color {
        switch d {
        case .beginner: return .green
        case .intermediate: return .blue
        case .advanced: return .orange
        case .expert: return .red
        }
    }
}

// MARK: - Reusable Components

struct QuizStatCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .foregroundStyle(color)
            Text(value)
                .font(.title3.bold())
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
    }
}

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? Color.blue : Color(.tertiarySystemGroupedBackground), in: Capsule())
                .foregroundStyle(isSelected ? .white : .primary)
        }
    }
}
