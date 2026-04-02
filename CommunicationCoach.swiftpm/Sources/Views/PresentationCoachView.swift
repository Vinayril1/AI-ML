import SwiftUI

struct PresentationCoachView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink(destination: PresentationPracticeView()) {
                        Label("Practice a Scenario", systemImage: "play.fill")
                    }
                    NavigationLink(destination: PresentationScenariosListView()) {
                        Label("Browse All Scenarios", systemImage: "list.bullet")
                    }
                    NavigationLink(destination: PresentationTipsView()) {
                        Label("Presentation Tips", systemImage: "lightbulb.fill")
                    }
                }
            }
            .navigationTitle("Presentation Coach")
        }
    }
}

// MARK: - Practice View

struct PresentationPracticeView: View {
    @EnvironmentObject var progressStore: ProgressStore
    @State private var selectedLevel: DifficultyLevel = .intermediate
    @State private var scenario: PresentationScenario?
    @State private var responseText = ""
    @State private var showResults = false
    @State private var scores: ScoreResult?
    @State private var feedback: [String] = []
    @State private var analysisDetails: TextAnalysis?

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
                scenario = PresentationData.randomScenario(level: selectedLevel)
            } label: {
                Label("Start Scenario", systemImage: "play.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.green, in: RoundedRectangle(cornerRadius: 12))
                    .foregroundStyle(.white)
            }
        }
    }

    private var practiceView: some View {
        Group {
            if let scenario {
                VStack(alignment: .leading, spacing: 16) {
                    ScenarioHeaderView(title: scenario.title, level: scenario.level, category: nil)

                    Text(scenario.scenario)
                        .font(.body)

                    HStack {
                        Label(scenario.audience, systemImage: "person.2.fill")
                        Spacer()
                        Label(scenario.timeLimit, systemImage: "clock.fill")
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)

                    KeyPointsView(
                        title: "Key Points to Cover",
                        points: scenario.keyPoints,
                        icon: "target",
                        color: .green
                    )

                    ResponseEditorView(
                        placeholder: "Deliver your presentation here...\n\nTip: Include an opening, structured body with transitions, and a strong conclusion.",
                        text: $responseText
                    )

                    Button {
                        submitResponse()
                    } label: {
                        Label("Get Feedback", systemImage: "sparkles")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(responseText.isEmpty ? Color.gray : Color.green, in: RoundedRectangle(cornerRadius: 12))
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

            if let analysis = analysisDetails {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Analysis")
                        .font(.headline)
                    HStack {
                        AnalysisItem(label: "Words", value: "\(analysis.wordCount)")
                        AnalysisItem(label: "Sentences", value: "\(analysis.sentenceCount)")
                        AnalysisItem(label: "Avg Length", value: "\(Int(analysis.avgSentenceLength))")
                    }
                    if !analysis.techTermsUsed.isEmpty {
                        Text("Tech terms: \(analysis.techTermsUsed.joined(separator: ", "))")
                            .font(.caption)
                            .foregroundStyle(.indigo)
                    }
                    if !analysis.strongPhrases.isEmpty {
                        Text("Strong phrases: \(analysis.strongPhrases.joined(separator: ", "))")
                            .font(.caption)
                            .foregroundStyle(.green)
                    }
                }
                .padding()
                .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            }

            FeedbackListView(title: "Feedback & Tips", tips: feedback)

            Button {
                scenario = nil
                responseText = ""
                showResults = false
                self.scores = nil
                self.feedback = []
                self.analysisDetails = nil
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
        var computedScores = engine.computeScores(analysis, exerciseType: "presentation")
        let presEval = engine.evaluatePresentation(responseText)

        computedScores.structure = max(computedScores.structure, presEval.structureScore)
        computedScores.overall = Double(computedScores.clarity) * 0.25 +
            Double(computedScores.structure) * 0.20 +
            Double(computedScores.technicalAccuracy) * 0.20 +
            Double(computedScores.persuasiveness) * 0.20 +
            Double(computedScores.conciseness) * 0.15
        computedScores.overall = computedScores.overall.rounded(toPlaces: 1)

        var tips = engine.generateFeedback(analysis, scores: computedScores)
        tips.append(contentsOf: presEval.feedback)

        self.scores = computedScores
        self.feedback = tips
        self.analysisDetails = analysis
        self.showResults = true

        progressStore.recordExercise(
            category: "Presentation",
            exerciseName: scenario?.title ?? "Practice",
            scores: computedScores
        )
    }
}

struct AnalysisItem: View {
    let label: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title3.bold())
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(Color(.tertiarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 8))
    }
}

// MARK: - Scenarios List

struct PresentationScenariosListView: View {
    var body: some View {
        List {
            ForEach(DifficultyLevel.allCases) { level in
                Section("Level \(level.rawValue): \(level.title)") {
                    ForEach(PresentationData.scenarios(for: level)) { scenario in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(scenario.title)
                                .font(.subheadline.bold())
                            Text(scenario.audience)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text(scenario.timeLimit)
                                .font(.caption2)
                                .foregroundStyle(.tertiary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("All Scenarios")
    }
}

// MARK: - Tips View

struct PresentationTipsView: View {
    var body: some View {
        List {
            ForEach(PresentationData.tips, id: \.category) { section in
                Section(section.category) {
                    ForEach(section.tips, id: \.self) { tip in
                        Text(tip)
                            .font(.subheadline)
                            .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("Presentation Tips")
    }
}
