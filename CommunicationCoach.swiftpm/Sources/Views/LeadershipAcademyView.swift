import SwiftUI

struct LeadershipAcademyView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink(destination: LeadershipPracticeView()) {
                        Label("Practice a Scenario", systemImage: "play.fill")
                    }
                    NavigationLink(destination: LeadershipScenariosListView()) {
                        Label("Browse All Scenarios", systemImage: "list.bullet")
                    }
                    NavigationLink(destination: LeadershipFrameworksView()) {
                        Label("Leadership Frameworks", systemImage: "rectangle.3.group.fill")
                    }
                }
            }
            .navigationTitle("Leadership Academy")
        }
    }
}

// MARK: - Practice

struct LeadershipPracticeView: View {
    @EnvironmentObject var progressStore: ProgressStore
    @State private var selectedLevel: DifficultyLevel = .intermediate
    @State private var scenario: LeadershipScenario?
    @State private var responseText = ""
    @State private var showResults = false
    @State private var scores: ScoreResult?
    @State private var feedback: [String] = []
    @State private var qualities: [(String, Bool)] = []

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
                scenario = LeadershipData.randomScenario(level: selectedLevel)
            } label: {
                Label("Start Scenario", systemImage: "play.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.red, in: RoundedRectangle(cornerRadius: 12))
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

                    HStack {
                        Label(scenario.leadershipSkill, systemImage: "star.fill")
                            .font(.caption)
                            .foregroundStyle(.red)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Label("Suggested Framework", systemImage: "rectangle.3.group.fill")
                            .font(.caption.bold())
                            .foregroundStyle(.indigo)
                        Text(scenario.framework)
                            .font(.caption)
                    }
                    .padding()
                    .background(Color.indigo.opacity(0.06), in: RoundedRectangle(cornerRadius: 10))

                    KeyPointsView(
                        title: "Key Considerations",
                        points: scenario.keyConsiderations,
                        icon: "exclamationmark.triangle.fill",
                        color: .orange
                    )

                    ResponseEditorView(
                        placeholder: "Write your leadership response...\n\nBe decisive, empathetic, structured, and data-driven.",
                        text: $responseText
                    )

                    Button {
                        submitResponse()
                    } label: {
                        Label("Get Feedback", systemImage: "sparkles")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(responseText.isEmpty ? Color.gray : Color.red, in: RoundedRectangle(cornerRadius: 12))
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

            // Leadership qualities
            QualityChecksView(checks: qualities)

            FeedbackListView(title: "Feedback & Tips", tips: feedback)

            Button {
                scenario = nil
                responseText = ""
                showResults = false
                self.scores = nil
                self.feedback = []
                self.qualities = []
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
        var computedScores = engine.computeScores(analysis)
        let leadEval = engine.evaluateLeadership(responseText)

        computedScores.persuasiveness = max(computedScores.persuasiveness, leadEval.score)
        computedScores.overall = Double(computedScores.clarity) * 0.25 +
            Double(computedScores.structure) * 0.20 +
            Double(computedScores.technicalAccuracy) * 0.20 +
            Double(computedScores.persuasiveness) * 0.20 +
            Double(computedScores.conciseness) * 0.15
        computedScores.overall = computedScores.overall.rounded(toPlaces: 1)

        var tips = engine.generateFeedback(analysis, scores: computedScores)
        tips.append(contentsOf: leadEval.feedback)

        self.scores = computedScores
        self.feedback = tips
        self.qualities = leadEval.qualities
        self.showResults = true

        progressStore.recordExercise(
            category: "Leadership",
            exerciseName: scenario?.title ?? "Practice",
            scores: computedScores
        )
    }
}

// MARK: - Scenarios List

struct LeadershipScenariosListView: View {
    var body: some View {
        List {
            ForEach(LeadershipData.scenarios) { scenario in
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("L\(scenario.level.rawValue)")
                            .font(.caption2.bold())
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(.red.opacity(0.15), in: Capsule())
                        Text(scenario.category)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    Text(scenario.title)
                        .font(.subheadline.bold())
                    Text(scenario.leadershipSkill)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("Framework: \(scenario.framework)")
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("All Scenarios")
    }
}

// MARK: - Frameworks

struct LeadershipFrameworksView: View {
    var body: some View {
        List {
            ForEach(LeadershipData.frameworks) { fw in
                VStack(alignment: .leading, spacing: 10) {
                    Text(fw.fullName)
                        .font(.headline)
                    Text(fw.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    ForEach(fw.steps, id: \.self) { step in
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "chevron.right.circle.fill")
                                .foregroundStyle(.red)
                                .font(.caption)
                                .padding(.top, 2)
                            Text(step)
                                .font(.subheadline)
                        }
                    }

                    Label(fw.whenToUse, systemImage: "clock.fill")
                        .font(.caption)
                        .foregroundStyle(.indigo)
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle("Frameworks")
    }
}
