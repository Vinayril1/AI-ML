import SwiftUI

// MARK: - Level Picker

struct LevelPicker: View {
    @Binding var selectedLevel: DifficultyLevel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Difficulty Level")
                .font(.headline)
            Picker("Level", selection: $selectedLevel) {
                ForEach(DifficultyLevel.allCases) { level in
                    Text(level.title).tag(level)
                }
            }
            .pickerStyle(.segmented)
            Text(selectedLevel.subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Score Card

struct ScoreCardView: View {
    let scores: ScoreResult

    var body: some View {
        VStack(spacing: 16) {
            // Overall Score Circle
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 10)
                    .frame(width: 100, height: 100)
                Circle()
                    .trim(from: 0, to: scores.overall / 100)
                    .stroke(overallColor, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(-90))
                VStack(spacing: 2) {
                    Text("\(Int(scores.overall))")
                        .font(.title.bold())
                    Text("Overall")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }

            // Dimension Scores
            VStack(spacing: 10) {
                ForEach(scores.asDictionary, id: \.dimension) { item in
                    HStack {
                        Image(systemName: item.dimension.iconName)
                            .foregroundStyle(scoreColor(item.score))
                            .frame(width: 24)
                        Text(item.dimension.displayName)
                            .font(.subheadline)
                        Spacer()
                        ProgressView(value: Double(item.score), total: 100)
                            .tint(scoreColor(item.score))
                            .frame(width: 100)
                        Text("\(item.score)")
                            .font(.subheadline.bold())
                            .foregroundStyle(scoreColor(item.score))
                            .frame(width: 30, alignment: .trailing)
                    }
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 16))
    }

    private var overallColor: Color {
        if scores.overall >= 75 { return .green }
        if scores.overall >= 50 { return .orange }
        return .red
    }

    private func scoreColor(_ score: Int) -> Color {
        if score >= 80 { return .green }
        if score >= 60 { return .yellow }
        if score >= 40 { return .orange }
        return .red
    }
}

// MARK: - Feedback List

struct FeedbackListView: View {
    let title: String
    let tips: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(title, systemImage: "lightbulb.fill")
                .font(.headline)
                .foregroundStyle(.orange)
            ForEach(Array(tips.enumerated()), id: \.offset) { index, tip in
                HStack(alignment: .top, spacing: 8) {
                    Text("\(index + 1).")
                        .font(.subheadline.bold())
                        .foregroundStyle(.secondary)
                    Text(tip)
                        .font(.subheadline)
                }
            }
        }
        .padding()
        .background(Color.orange.opacity(0.06), in: RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Scenario Card

struct ScenarioHeaderView: View {
    let title: String
    let level: DifficultyLevel
    let category: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("Level \(level.rawValue)")
                    .font(.caption.bold())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(levelColor.opacity(0.15), in: Capsule())
                    .foregroundStyle(levelColor)
                if let category {
                    Text(category)
                        .font(.caption.bold())
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Color.indigo.opacity(0.15), in: Capsule())
                        .foregroundStyle(.indigo)
                }
            }
            Text(title)
                .font(.title3.bold())
        }
    }

    private var levelColor: Color {
        switch level {
        case .beginner: return .green
        case .intermediate: return .blue
        case .advanced: return .orange
        case .expert: return .red
        }
    }
}

// MARK: - Response Text Editor

struct ResponseEditorView: View {
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Your Response")
                .font(.headline)
            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundStyle(.tertiary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                }
                TextEditor(text: $text)
                    .frame(minHeight: 200)
                    .scrollContentBackground(.hidden)
            }
            .padding(4)
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            HStack {
                Text("\(text.split(separator: " ").count) words")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                if !text.isEmpty {
                    Button("Clear") { text = "" }
                        .font(.caption)
                }
            }
        }
    }
}

// MARK: - Quality Checks

struct QualityChecksView: View {
    let checks: [(String, Bool)]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Quality Checks")
                .font(.headline)
            ForEach(Array(checks.enumerated()), id: \.offset) { _, check in
                HStack(spacing: 10) {
                    Image(systemName: check.1 ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundStyle(check.1 ? .green : .red)
                    Text(check.0)
                        .font(.subheadline)
                    Spacer()
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Key Points List

struct KeyPointsView: View {
    let title: String
    let points: [String]
    let icon: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: icon)
                .font(.subheadline.bold())
                .foregroundStyle(color)
            ForEach(points, id: \.self) { point in
                HStack(alignment: .top, spacing: 8) {
                    Circle()
                        .fill(color.opacity(0.5))
                        .frame(width: 6, height: 6)
                        .padding(.top, 6)
                    Text(point)
                        .font(.subheadline)
                }
            }
        }
    }
}
