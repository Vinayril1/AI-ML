import SwiftUI

struct ProgressDashboardView: View {
    @EnvironmentObject var progressStore: ProgressStore

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                let summary = progressStore.summary

                if summary.totalExercises == 0 {
                    emptyState
                } else {
                    statsOverview(summary: summary)
                    categoryBreakdown(summary: summary)
                    scoreTrend(summary: summary)
                    recommendationsSection
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Progress")
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "chart.bar.doc.horizontal")
                .font(.system(size: 60))
                .foregroundStyle(.tertiary)
            Text("No Exercises Yet")
                .font(.title3.bold())
            Text("Complete your first exercise to start tracking progress.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            VStack(alignment: .leading, spacing: 8) {
                Text("Recommended Starting Points:")
                    .font(.subheadline.bold())
                ForEach(progressStore.recommendations, id: \.self) { rec in
                    Label(rec, systemImage: "arrow.right.circle.fill")
                        .font(.caption)
                        .foregroundStyle(.indigo)
                }
            }
            .padding()
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
        .padding(.top, 40)
    }

    // MARK: - Stats Overview

    private func statsOverview(summary: ProgressSummary) -> some View {
        HStack(spacing: 12) {
            DashboardStatCard(
                icon: "checkmark.circle.fill",
                value: "\(summary.totalExercises)",
                label: "Total",
                color: .green
            )
            DashboardStatCard(
                icon: "flame.fill",
                value: "\(summary.currentStreak)",
                label: "Day Streak",
                color: .orange
            )
            DashboardStatCard(
                icon: "trophy.fill",
                value: "\(Int(summary.bestOverall))",
                label: "Best Score",
                color: .yellow
            )
        }
    }

    // MARK: - Category Breakdown

    private func categoryBreakdown(summary: ProgressSummary) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Category Breakdown")
                .font(.headline)

            let categories = [
                ("Presentation", "person.wave.2.fill", Color.green),
                ("Negotiation", "handshake.fill", Color.orange),
                ("Communication", "envelope.fill", Color.purple),
                ("Leadership", "star.fill", Color.red),
            ]

            ForEach(categories, id: \.0) { cat, icon, color in
                let count = summary.categoryCounts[cat] ?? 0
                let avg = summary.categoryAverages[cat]
                let best = summary.bestScores[cat]

                HStack(spacing: 12) {
                    Image(systemName: icon)
                        .foregroundStyle(color)
                        .frame(width: 30)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(cat)
                            .font(.subheadline.bold())
                        Text("\(count) exercises")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    if let avg {
                        VStack(alignment: .trailing, spacing: 2) {
                            Text("Avg: \(Int(avg))")
                                .font(.caption.bold())
                            if let best {
                                Text("Best: \(Int(best))")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    } else {
                        Text("—")
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                    }
                }
                .padding()
                .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 10))
            }
        }
    }

    // MARK: - Score Trend

    private func scoreTrend(summary: ProgressSummary) -> some View {
        Group {
            if !summary.recentScores.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Recent Scores")
                        .font(.headline)

                    ForEach(Array(summary.recentScores.enumerated()), id: \.offset) { index, score in
                        HStack(spacing: 8) {
                            Text("\(index + 1)")
                                .font(.caption.bold())
                                .frame(width: 20, alignment: .trailing)
                                .foregroundStyle(.secondary)

                            GeometryReader { geo in
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(barColor(score))
                                    .frame(width: max(geo.size.width * score / 100, 4))
                            }
                            .frame(height: 20)

                            Text("\(Int(score))")
                                .font(.caption.bold())
                                .foregroundStyle(barColor(score))
                                .frame(width: 30, alignment: .trailing)
                        }
                    }
                }
                .padding()
                .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            }
        }
    }

    // MARK: - Recommendations

    private var recommendationsSection: some View {
        let recs = progressStore.recommendations
        return Group {
            if !recs.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Label("Recommendations", systemImage: "lightbulb.fill")
                        .font(.headline)
                        .foregroundStyle(.orange)
                    ForEach(recs, id: \.self) { rec in
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "arrow.right.circle.fill")
                                .foregroundStyle(.indigo)
                                .font(.caption)
                                .padding(.top, 2)
                            Text(rec)
                                .font(.subheadline)
                        }
                    }
                }
                .padding()
                .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            }
        }
    }

    private func barColor(_ score: Double) -> Color {
        if score >= 75 { return .green }
        if score >= 50 { return .orange }
        return .red
    }
}

struct DashboardStatCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
            Text(value)
                .font(.title2.bold())
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
    }
}
