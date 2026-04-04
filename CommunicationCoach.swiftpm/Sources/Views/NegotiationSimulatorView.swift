import SwiftUI

struct NegotiationSimulatorView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink(destination: NegotiationPracticeView()) {
                        Label("Practice a Scenario", systemImage: "play.fill")
                    }
                    NavigationLink(destination: NegotiationScenariosListView()) {
                        Label("Browse All Scenarios", systemImage: "list.bullet")
                    }
                    NavigationLink(destination: NegotiationTacticsView()) {
                        Label("Negotiation Tactics", systemImage: "brain")
                    }
                }
            }
            .navigationTitle("Negotiation Simulator")
        }
    }
}

// MARK: - Practice View

struct NegotiationPracticeView: View {
    @EnvironmentObject var progressStore: ProgressStore
    @State private var selectedLevel: DifficultyLevel = .intermediate
    @State private var scenario: NegotiationScenario?
    @State private var responseText = ""
    @State private var showResults = false
    @State private var scores: ScoreResult?
    @State private var feedback: [String] = []
    @State private var tone = ""
    @State private var hasData = false
    @State private var hasBATNA = false
    @State private var voiceCritique: [String] = []

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if scenario == nil {
                    selectView
                } else if showResults, let scores {
                    resultsView(scores: scores)
                } else {
                    practiceView
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Practice")
    }

    private var selectView: some View {
        VStack(spacing: 20) {
            LevelPicker(selectedLevel: $selectedLevel)
            Button {
                scenario = NegotiationData.randomScenario(level: selectedLevel)
            } label: {
                Label("Start Scenario", systemImage: "play.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.orange, in: RoundedRectangle(cornerRadius: 12))
                    .foregroundStyle(.white)
            }
        }
    }

    private var practiceView: some View {
        Group {
            if let scenario {
                VStack(alignment: .leading, spacing: 16) {
                    ScenarioHeaderView(title: scenario.title, level: scenario.level, category: scenario.category)

                    Text(scenario.scenario)
                        .font(.body)

                    // Your Position
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your Position")
                            .font(.subheadline.bold())
                            .foregroundStyle(.blue)
                        Group {
                            Label(scenario.budget, systemImage: "dollarsign.circle")
                            Label(scenario.leverage, systemImage: "bolt.fill")
                        }
                        .font(.caption)

                        KeyPointsView(title: "Must-Haves", points: scenario.mustHaves, icon: "exclamationmark.circle.fill", color: .red)
                        KeyPointsView(title: "Nice-to-Haves", points: scenario.niceToHaves, icon: "star.circle.fill", color: .blue)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.06), in: RoundedRectangle(cornerRadius: 12))

                    // Counterpart's opening
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundStyle(.orange)
                            Text("Counterpart Says:")
                                .font(.subheadline.bold())
                        }
                        Text(scenario.openingMessage)
                            .font(.subheadline)
                            .italic()
                    }
                    .padding()
                    .background(Color.orange.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))

                    HStack {
                        Image(systemName: "scope")
                            .foregroundStyle(.purple)
                        Text("Practice: \(scenario.tacticsToPractice.joined(separator: ", "))")
                            .font(.caption)
                            .foregroundStyle(.purple)
                    }

                    VoiceResponseEditorView(
                        placeholder: "Speak or type your negotiation response...\n\nTip: Be assertive but collaborative. Use data. Reference your BATNA.",
                        text: $responseText
                    )

                    Button {
                        submitResponse()
                    } label: {
                        Label("Get Feedback", systemImage: "sparkles")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(responseText.isEmpty ? Color.gray : Color.orange, in: RoundedRectangle(cornerRadius: 12))
                            .foregroundStyle(.white)
                    }
                    .disabled(responseText.isEmpty)
                }
            }
        }
    }

    private func resultsView(scores: ScoreResult) -> some View {
        VStack(spacing: 20) {
            Text("Results: \(scenario?.title ?? "")")
                .font(.headline)

            ScoreCardView(scores: scores)

            // Negotiation-specific
            VStack(alignment: .leading, spacing: 10) {
                Text("Negotiation Analysis")
                    .font(.headline)
                Label(tone, systemImage: "theatermasks.fill")
                    .font(.subheadline)

                QualityChecksView(checks: [
                    ("Uses Data/Evidence", hasData),
                    ("References Alternatives (BATNA)", hasBATNA),
                ])
            }

            FeedbackListView(title: "Feedback & Tips", tips: feedback)

            if !voiceCritique.isEmpty {
                FeedbackListView(title: "Critical Voice Analysis", tips: voiceCritique)
            }

            Button {
                scenario = nil
                responseText = ""
                showResults = false
                self.scores = nil
                self.feedback = []
                self.voiceCritique = []
            } label: {
                Label("Try Another", systemImage: "arrow.counterclockwise")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.indigo, in: RoundedRectangle(cornerRadius: 12))
                    .foregroundStyle(.white)
            }
        }
    }

    private func submitResponse() {
        let engine = ScoringEngine.shared
        let analysis = engine.analyze(responseText)
        var computedScores = engine.computeScores(analysis, exerciseType: "negotiation")
        let negEval = engine.evaluateNegotiation(responseText)

        computedScores.persuasiveness = max(computedScores.persuasiveness, negEval.score)
        computedScores.overall = Double(computedScores.clarity) * 0.25 +
            Double(computedScores.structure) * 0.20 +
            Double(computedScores.technicalAccuracy) * 0.20 +
            Double(computedScores.persuasiveness) * 0.20 +
            Double(computedScores.conciseness) * 0.15
        computedScores.overall = computedScores.overall.rounded(toPlaces: 1)

        var tips = engine.generateFeedback(analysis, scores: computedScores)
        tips.append(contentsOf: negEval.feedback)

        self.scores = computedScores
        self.feedback = tips
        self.tone = negEval.tone
        self.hasData = negEval.hasData
        self.hasBATNA = negEval.hasBATNA
        self.voiceCritique = engine.criticalVoiceAnalysis(responseText)
        self.showResults = true

        progressStore.recordExercise(
            category: "Negotiation",
            exerciseName: scenario?.title ?? "Practice",
            scores: computedScores
        )
    }
}

// MARK: - Scenarios List

struct NegotiationScenariosListView: View {
    var body: some View {
        List {
            ForEach(NegotiationData.scenarios, id: \.title) { scenario in
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("L\(scenario.level.rawValue)")
                            .font(.caption2.bold())
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(.blue.opacity(0.15), in: Capsule())
                        Text(scenario.category)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    Text(scenario.title)
                        .font(.subheadline.bold())
                    Text(scenario.counterpart)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("All Scenarios")
    }
}

// MARK: - Tactics View

struct NegotiationTacticsView: View {
    var body: some View {
        List {
            ForEach(NegotiationData.tactics) { tactic in
                VStack(alignment: .leading, spacing: 10) {
                    Text(tactic.name)
                        .font(.headline)
                    Text(tactic.description)
                        .font(.subheadline)
                    Group {
                        Label("Example", systemImage: "quote.bubble.fill")
                            .font(.caption.bold())
                            .foregroundStyle(.blue)
                        Text(tactic.example)
                            .font(.caption)
                    }
                    Group {
                        Label("Telecom Tip", systemImage: "antenna.radiowaves.left.and.right")
                            .font(.caption.bold())
                            .foregroundStyle(.orange)
                        Text(tactic.telecomTip)
                            .font(.caption)
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle("Negotiation Tactics")
    }
}
