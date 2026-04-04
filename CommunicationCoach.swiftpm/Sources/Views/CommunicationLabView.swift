import SwiftUI

struct CommunicationLabView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink(destination: EmailPracticeView()) {
                        Label("Email Writing", systemImage: "envelope.fill")
                    }
                    NavigationLink(destination: MeetingPracticeView()) {
                        Label("Meeting Facilitation", systemImage: "person.3.fill")
                    }
                    NavigationLink(destination: ExplanationPracticeView()) {
                        Label("Explain It Simply", systemImage: "bubble.left.and.bubble.right.fill")
                    }
                    NavigationLink(destination: VocabularyView()) {
                        Label("Vocabulary Builder", systemImage: "text.book.closed.fill")
                    }
                }
            }
            .navigationTitle("Communication Lab")
        }
    }
}

// MARK: - Email Practice

struct EmailPracticeView: View {
    @EnvironmentObject var progressStore: ProgressStore
    @State private var selectedLevel: DifficultyLevel = .beginner
    @State private var exercise: EmailExercise?
    @State private var responseText = ""
    @State private var showResults = false
    @State private var scores: ScoreResult?
    @State private var emailChecks: [(String, Bool)] = []
    @State private var feedback: [String] = []

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if exercise == nil {
                    VStack(spacing: 20) {
                        LevelPicker(selectedLevel: $selectedLevel)
                        Button {
                            let lvl: DifficultyLevel = selectedLevel == .expert ? .advanced : selectedLevel
                            exercise = CommunicationExerciseData.emailExercises.filter { $0.level == lvl }.randomElement()
                                ?? CommunicationExerciseData.emailExercises[0]
                        } label: {
                            Label("Start Exercise", systemImage: "play.fill")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.purple, in: RoundedRectangle(cornerRadius: 12))
                                .foregroundStyle(.white)
                        }
                    }
                } else if showResults, let scores {
                    VStack(spacing: 20) {
                        Text("Results: \(exercise?.title ?? "")")
                            .font(.headline)
                        ScoreCardView(scores: scores)
                        QualityChecksView(checks: emailChecks)
                        FeedbackListView(title: "Feedback", tips: feedback)

                        if let exercise {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Good Example Elements")
                                    .font(.headline)
                                ForEach(exercise.goodElements, id: \.self) { elem in
                                    Label(elem, systemImage: "checkmark.circle")
                                        .font(.caption)
                                        .foregroundStyle(.green)
                                }
                            }
                            .padding()
                            .background(Color.green.opacity(0.06), in: RoundedRectangle(cornerRadius: 12))
                        }

                        Button {
                            self.exercise = nil; responseText = ""; showResults = false
                            self.scores = nil; feedback = []; emailChecks = []
                        } label: {
                            Label("Try Another", systemImage: "arrow.counterclockwise")
                                .frame(maxWidth: .infinity).padding()
                                .background(.indigo, in: RoundedRectangle(cornerRadius: 12))
                                .foregroundStyle(.white)
                        }
                    }
                } else if let exercise {
                    VStack(alignment: .leading, spacing: 16) {
                        ScenarioHeaderView(title: exercise.title, level: exercise.level, category: nil)
                        Text(exercise.scenario).font(.body)
                        Text("Audience: \(exercise.audience)")
                            .font(.caption).foregroundStyle(.secondary)
                        KeyPointsView(title: "Guidelines", points: exercise.guidelines, icon: "checklist", color: .purple)
                        ResponseEditorView(placeholder: "Write your email here...\nStart with Subject: line", text: $responseText)
                        Button { submitEmail() } label: {
                            Label("Get Feedback", systemImage: "sparkles")
                                .font(.headline).frame(maxWidth: .infinity).padding()
                                .background(responseText.isEmpty ? Color.gray : Color.purple, in: RoundedRectangle(cornerRadius: 12))
                                .foregroundStyle(.white)
                        }
                        .disabled(responseText.isEmpty)
                    }
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Email Writing")
    }

    private func submitEmail() {
        let engine = ScoringEngine.shared
        let analysis = engine.analyze(responseText)
        var computedScores = engine.computeScores(analysis)
        let emailEval = engine.evaluateEmail(responseText)

        computedScores.overall = ((computedScores.overall + Double(emailEval.score)) / 2).rounded(toPlaces: 1)

        self.scores = computedScores
        self.emailChecks = emailEval.checks
        self.feedback = emailEval.feedback
        self.showResults = true

        progressStore.recordExercise(category: "Communication", exerciseName: exercise?.title ?? "Email", scores: computedScores)
    }
}

// MARK: - Meeting Practice

struct MeetingPracticeView: View {
    @EnvironmentObject var progressStore: ProgressStore
    @State private var selectedLevel: DifficultyLevel = .beginner
    @State private var exercise: MeetingExercise?
    @State private var responseText = ""
    @State private var showResults = false
    @State private var scores: ScoreResult?
    @State private var feedback: [String] = []

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if exercise == nil {
                    VStack(spacing: 20) {
                        LevelPicker(selectedLevel: $selectedLevel)
                        Button {
                            let lvl: DifficultyLevel = [.advanced, .expert].contains(selectedLevel) ? .advanced : selectedLevel
                            exercise = CommunicationExerciseData.meetingExercises.filter { $0.level == lvl }.randomElement()
                                ?? CommunicationExerciseData.meetingExercises[0]
                        } label: {
                            Label("Start Exercise", systemImage: "play.fill")
                                .font(.headline).frame(maxWidth: .infinity).padding()
                                .background(.purple, in: RoundedRectangle(cornerRadius: 12))
                                .foregroundStyle(.white)
                        }
                    }
                } else if showResults, let scores {
                    VStack(spacing: 20) {
                        ScoreCardView(scores: scores)
                        FeedbackListView(title: "Feedback", tips: feedback)
                        Button {
                            self.exercise = nil; responseText = ""; showResults = false; self.scores = nil; self.feedback = []
                        } label: {
                            Label("Try Another", systemImage: "arrow.counterclockwise")
                                .frame(maxWidth: .infinity).padding()
                                .background(.indigo, in: RoundedRectangle(cornerRadius: 12)).foregroundStyle(.white)
                        }
                    }
                } else if let exercise {
                    VStack(alignment: .leading, spacing: 16) {
                        ScenarioHeaderView(title: exercise.title, level: exercise.level, category: nil)
                        Text(exercise.scenario).font(.body)
                        KeyPointsView(title: "Skills", points: exercise.skillsPracticed, icon: "star.fill", color: .purple)
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Useful Phrases").font(.subheadline.bold()).foregroundStyle(.blue)
                            ForEach(exercise.keyPhrases, id: \.self) { phrase in
                                Text(phrase).font(.caption).italic()
                            }
                        }
                        .padding().background(Color.blue.opacity(0.06), in: RoundedRectangle(cornerRadius: 12))

                        ResponseEditorView(placeholder: "Write your facilitation plan...", text: $responseText)
                        Button { submitMeeting() } label: {
                            Label("Get Feedback", systemImage: "sparkles")
                                .font(.headline).frame(maxWidth: .infinity).padding()
                                .background(responseText.isEmpty ? Color.gray : Color.purple, in: RoundedRectangle(cornerRadius: 12))
                                .foregroundStyle(.white)
                        }
                        .disabled(responseText.isEmpty)
                    }
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Meeting Facilitation")
    }

    private func submitMeeting() {
        let engine = ScoringEngine.shared
        let analysis = engine.analyze(responseText)
        let computedScores = engine.computeScores(analysis)
        self.scores = computedScores
        self.feedback = engine.generateFeedback(analysis, scores: computedScores)
        self.showResults = true
        progressStore.recordExercise(category: "Communication", exerciseName: exercise?.title ?? "Meeting", scores: computedScores)
    }
}

// MARK: - Explanation Challenge

struct ExplanationPracticeView: View {
    @EnvironmentObject var progressStore: ProgressStore
    @State private var challenge: ExplanationChallenge?
    @State private var responseText = ""
    @State private var showResults = false
    @State private var scores: ScoreResult?
    @State private var feedback: [String] = []

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if challenge == nil {
                    Button {
                        challenge = CommunicationExerciseData.explanationChallenges.randomElement()
                    } label: {
                        Label("Get a Challenge", systemImage: "play.fill")
                            .font(.headline).frame(maxWidth: .infinity).padding()
                            .background(.purple, in: RoundedRectangle(cornerRadius: 12)).foregroundStyle(.white)
                    }
                } else if showResults, let scores {
                    VStack(spacing: 20) {
                        ScoreCardView(scores: scores)
                        FeedbackListView(title: "Feedback", tips: feedback)
                        if let challenge {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Reference Example").font(.headline)
                                Text(challenge.goodExample).font(.subheadline).italic().foregroundStyle(.secondary)
                            }
                            .padding().background(Color.green.opacity(0.06), in: RoundedRectangle(cornerRadius: 12))
                        }
                        Button {
                            self.challenge = nil; responseText = ""; showResults = false; self.scores = nil; self.feedback = []
                        } label: {
                            Label("Try Another", systemImage: "arrow.counterclockwise")
                                .frame(maxWidth: .infinity).padding()
                                .background(.indigo, in: RoundedRectangle(cornerRadius: 12)).foregroundStyle(.white)
                        }
                    }
                } else if let challenge {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Explain: \(challenge.concept)").font(.title3.bold())
                        Label("To: \(challenge.explainTo)", systemImage: "person.fill").font(.subheadline)
                        Label(challenge.constraint, systemImage: "exclamationmark.triangle.fill")
                            .font(.caption).foregroundStyle(.orange)
                        ResponseEditorView(placeholder: "Explain the concept in simple terms...", text: $responseText)
                        Button { submitExplanation() } label: {
                            Label("Get Feedback", systemImage: "sparkles")
                                .font(.headline).frame(maxWidth: .infinity).padding()
                                .background(responseText.isEmpty ? Color.gray : Color.purple, in: RoundedRectangle(cornerRadius: 12))
                                .foregroundStyle(.white)
                        }
                        .disabled(responseText.isEmpty)
                    }
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Explain It Simply")
    }

    private func submitExplanation() {
        let engine = ScoringEngine.shared
        let analysis = engine.analyze(responseText)
        let computedScores = engine.computeScores(analysis)
        self.scores = computedScores
        self.feedback = engine.generateFeedback(analysis, scores: computedScores)
        self.showResults = true
        progressStore.recordExercise(category: "Communication", exerciseName: "Explain: \(challenge?.concept ?? "")", scores: computedScores)
    }
}

// MARK: - Vocabulary

struct VocabularyView: View {
    var body: some View {
        List {
            ForEach(CommunicationExerciseData.vocabulary, id: \.category) { section in
                Section(section.category) {
                    ForEach(section.terms) { term in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(term.term).font(.subheadline.bold()).foregroundStyle(.indigo)
                            Text(term.description).font(.caption)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("Vocabulary Builder")
    }
}
