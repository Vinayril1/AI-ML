import SwiftUI

struct WisdomStorytellingView: View {
    var body: some View {
        NavigationStack {
            List {
                // Daily Wisdom
                Section {
                    let daily = WisdomData.dailyWisdom()
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Today's Wisdom", systemImage: "sun.max.fill")
                            .font(.subheadline.bold())
                            .foregroundStyle(.orange)
                        Text(daily.text)
                            .font(.subheadline)
                            .italic()
                        Text("— \(daily.author), \(daily.source)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(daily.application)
                            .font(.caption)
                            .foregroundStyle(.indigo)
                            .padding(.top, 4)
                    }
                    .padding(.vertical, 4)
                }

                // Sections
                Section {
                    NavigationLink(destination: GitaWisdomView()) {
                        Label("Bhagavad Gita — Leadership Wisdom", systemImage: "sparkle")
                    }
                    NavigationLink(destination: ProverbsView()) {
                        Label("Proverbs with Real Scenarios", systemImage: "text.quote")
                    }
                    NavigationLink(destination: AuthorQuotesView()) {
                        Label("Bestseller Authors & Thinkers", systemImage: "book.closed.fill")
                    }
                    NavigationLink(destination: HistorianPoetView()) {
                        Label("Historians, Poets & Visionaries", systemImage: "scroll.fill")
                    }
                    NavigationLink(destination: StorytellingTechniquesView()) {
                        Label("Storytelling Techniques", systemImage: "theatermasks")
                    }
                    NavigationLink(destination: StorytellingPracticeView()) {
                        Label("Practice Storytelling", systemImage: "play.fill")
                    }
                }
            }
            .navigationTitle("Wisdom & Storytelling")
        }
    }
}

// MARK: - Bhagavad Gita View

struct GitaWisdomView: View {
    var body: some View {
        List {
            ForEach(WisdomData.gitaVerses) { verse in
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "sparkle")
                            .foregroundStyle(.orange)
                        Text(verse.source)
                            .font(.caption.bold())
                            .foregroundStyle(.orange)
                    }
                    Text(verse.text)
                        .font(.subheadline)
                        .italic()
                    Divider()
                    Label("How to Apply", systemImage: "lightbulb.fill")
                        .font(.caption.bold())
                        .foregroundStyle(.indigo)
                    Text(verse.application)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 6)
            }
        }
        .navigationTitle("Bhagavad Gita")
    }
}

// MARK: - Proverbs View

struct ProverbsView: View {
    let categories = ["Planning", "Action", "Quality", "Leadership", "Strategy", "Communication"]

    var body: some View {
        List {
            ForEach(categories, id: \.self) { category in
                let filtered = WisdomData.proverbs.filter { $0.category == category }
                if !filtered.isEmpty {
                    Section(category) {
                        ForEach(filtered) { proverb in
                            VStack(alignment: .leading, spacing: 8) {
                                Text("\"\(proverb.proverb)\"")
                                    .font(.subheadline.bold())
                                Text(proverb.meaning)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Divider()
                                Label("Real Scenario", systemImage: "building.2.fill")
                                    .font(.caption.bold())
                                    .foregroundStyle(.teal)
                                Text(proverb.scenario)
                                    .font(.caption)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
        }
        .navigationTitle("Proverbs & Scenarios")
    }
}

// MARK: - Author Quotes

struct AuthorQuotesView: View {
    var body: some View {
        List {
            ForEach(WisdomData.authorQuotes) { quote in
                VStack(alignment: .leading, spacing: 8) {
                    Text(quote.text)
                        .font(.subheadline)
                        .italic()
                    HStack {
                        Text("— \(quote.author)")
                            .font(.caption.bold())
                        Spacer()
                        Text(quote.source)
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                    }
                    .foregroundStyle(.secondary)
                    Divider()
                    Label("Apply It", systemImage: "lightbulb.fill")
                        .font(.caption.bold())
                        .foregroundStyle(.indigo)
                    Text(quote.application)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 6)
            }
        }
        .navigationTitle("Authors & Thinkers")
    }
}

// MARK: - Historians & Poets

struct HistorianPoetView: View {
    var body: some View {
        List {
            ForEach(WisdomData.historianPoetQuotes) { quote in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: quote.category == "Poets" ? "text.quote" : "scroll.fill")
                            .foregroundStyle(quote.category == "Poets" ? .purple : .brown)
                        Text(quote.category)
                            .font(.caption2.bold())
                            .foregroundStyle(.secondary)
                    }
                    Text(quote.text)
                        .font(.subheadline)
                        .italic()
                    Text("— \(quote.author), \(quote.source)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Divider()
                    Text(quote.application)
                        .font(.caption)
                        .foregroundStyle(.indigo)
                }
                .padding(.vertical, 6)
            }
        }
        .navigationTitle("Historians & Poets")
    }
}

// MARK: - Storytelling Techniques

struct StorytellingTechniquesView: View {
    var body: some View {
        List {
            ForEach(WisdomData.storytellingTechniques) { technique in
                VStack(alignment: .leading, spacing: 10) {
                    Text(technique.name)
                        .font(.headline)
                    Text(technique.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Steps")
                            .font(.caption.bold())
                            .foregroundStyle(.teal)
                        ForEach(Array(technique.steps.enumerated()), id: \.offset) { i, step in
                            HStack(alignment: .top, spacing: 8) {
                                Text("\(i + 1).")
                                    .font(.caption.bold())
                                    .foregroundStyle(.teal)
                                Text(step)
                                    .font(.caption)
                            }
                        }
                    }

                    Divider()
                    Label("Telecom Example", systemImage: "antenna.radiowaves.left.and.right")
                        .font(.caption.bold())
                        .foregroundStyle(.orange)
                    Text(technique.telecomExample)
                        .font(.caption)
                        .italic()
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle("Storytelling Techniques")
    }
}

// MARK: - Storytelling Practice

struct StorytellingPracticeView: View {
    @EnvironmentObject var progressStore: ProgressStore
    @State private var technique: StorytellingTechnique?
    @State private var responseText = ""
    @State private var showResults = false
    @State private var scores: ScoreResult?
    @State private var feedback: [String] = []
    @State private var voiceCritique: [String] = []

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if technique == nil {
                    startView
                } else if showResults, let scores {
                    resultsView(scores: scores)
                } else {
                    practiceView
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Practice Storytelling")
    }

    private var startView: some View {
        VStack(spacing: 16) {
            Image(systemName: "theatermasks")
                .font(.system(size: 50))
                .foregroundStyle(.teal)
            Text("Storytelling Practice")
                .font(.title3.bold())
            Text("You'll get a random storytelling technique and a telecom scenario. Use the technique to craft a compelling narrative.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Button {
                technique = WisdomData.storytellingTechniques.randomElement()
            } label: {
                Label("Start Challenge", systemImage: "play.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.teal, in: RoundedRectangle(cornerRadius: 12))
                    .foregroundStyle(.white)
            }
        }
    }

    private var practiceView: some View {
        Group {
            if let technique {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Technique", systemImage: "theatermasks")
                            .font(.caption.bold())
                            .foregroundStyle(.teal)
                        Text(technique.name)
                            .font(.title3.bold())
                        Text(technique.description)
                            .font(.subheadline)
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Follow These Steps")
                            .font(.subheadline.bold())
                            .foregroundStyle(.teal)
                        ForEach(Array(technique.steps.enumerated()), id: \.offset) { i, step in
                            HStack(alignment: .top, spacing: 8) {
                                Text("\(i + 1).")
                                    .font(.subheadline.bold())
                                    .foregroundStyle(.teal)
                                Text(step)
                                    .font(.subheadline)
                            }
                        }
                    }
                    .padding()
                    .background(Color.teal.opacity(0.06), in: RoundedRectangle(cornerRadius: 12))

                    Text("Scenario: Use this technique to present a 5G/6G topic of your choice — a project update, a vendor pitch, or a keynote opening.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .italic()

                    VoiceResponseEditorView(
                        placeholder: "Craft your story using the \(technique.name) technique...\n\nSpeak naturally — use voice input for a more realistic experience.",
                        text: $responseText
                    )

                    Button { submit() } label: {
                        Label("Get Feedback", systemImage: "sparkles")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(responseText.isEmpty ? Color.gray : Color.teal, in: RoundedRectangle(cornerRadius: 12))
                            .foregroundStyle(.white)
                    }
                    .disabled(responseText.isEmpty)
                }
            }
        }
    }

    private func resultsView(scores: ScoreResult) -> some View {
        VStack(spacing: 20) {
            Text("Storytelling Results")
                .font(.headline)
            ScoreCardView(scores: scores)
            FeedbackListView(title: "Communication Feedback", tips: feedback)
            if !voiceCritique.isEmpty {
                FeedbackListView(title: "Critical Voice Analysis", tips: voiceCritique)
            }
            if let technique {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Reference Example")
                        .font(.headline)
                    Text(technique.telecomExample)
                        .font(.subheadline)
                        .italic()
                        .foregroundStyle(.secondary)
                }
                .padding()
                .background(Color.teal.opacity(0.06), in: RoundedRectangle(cornerRadius: 12))
            }
            Button {
                self.technique = nil; responseText = ""; showResults = false
                self.scores = nil; feedback = []; voiceCritique = []
            } label: {
                Label("Try Another", systemImage: "arrow.counterclockwise")
                    .frame(maxWidth: .infinity).padding()
                    .background(.indigo, in: RoundedRectangle(cornerRadius: 12)).foregroundStyle(.white)
            }
        }
    }

    private func submit() {
        let engine = ScoringEngine.shared
        let analysis = engine.analyze(responseText)
        let computedScores = engine.computeScores(analysis, exerciseType: "presentation")
        self.scores = computedScores
        self.feedback = engine.generateFeedback(analysis, scores: computedScores)
        self.voiceCritique = engine.criticalVoiceAnalysis(responseText)
        self.showResults = true
        progressStore.recordExercise(
            category: "Storytelling",
            exerciseName: technique?.name ?? "Practice",
            scores: computedScores
        )
    }
}
