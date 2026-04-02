import Foundation
import SwiftUI

// MARK: - Exercise Record

struct ExerciseRecord: Codable, Identifiable {
    let id: UUID
    let timestamp: Date
    let category: String
    let exerciseName: String
    let scores: ScoreResult

    init(category: String, exerciseName: String, scores: ScoreResult) {
        self.id = UUID()
        self.timestamp = Date()
        self.category = category
        self.exerciseName = exerciseName
        self.scores = scores
    }
}

// MARK: - Progress Summary

struct ProgressSummary {
    let totalExercises: Int
    let categoryCounts: [String: Int]
    let bestScores: [String: Double]
    let categoryAverages: [String: Double]
    let currentStreak: Int
    let recentScores: [Double]
    let bestOverall: Double
}

// MARK: - Progress Store

class ProgressStore: ObservableObject {
    @Published private(set) var records: [ExerciseRecord] = []

    private let storageKey = "communication_coach_progress"

    init() {
        load()
    }

    // MARK: - Persistence

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([ExerciseRecord].self, from: data)
        else { return }
        records = decoded
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(records) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }

    // MARK: - Record

    func recordExercise(category: String, exerciseName: String, scores: ScoreResult) {
        let record = ExerciseRecord(category: category, exerciseName: exerciseName, scores: scores)
        records.append(record)
        save()
    }

    // MARK: - Summary

    var summary: ProgressSummary {
        var categoryCounts: [String: Int] = [:]
        var bestScores: [String: Double] = [:]
        var categoryTotals: [String: (sum: Double, count: Int)] = [:]

        for record in records {
            categoryCounts[record.category, default: 0] += 1
            let overall = record.scores.overall
            if overall > (bestScores[record.category] ?? 0) {
                bestScores[record.category] = overall
            }
            let current = categoryTotals[record.category] ?? (0, 0)
            categoryTotals[record.category] = (current.sum + overall, current.count + 1)
        }

        var categoryAverages: [String: Double] = [:]
        for (cat, totals) in categoryTotals {
            categoryAverages[cat] = (totals.sum / Double(totals.count)).rounded(toPlaces: 1)
        }

        // Streak
        let calendar = Calendar.current
        var streakDays = Set<String>()
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        for record in records {
            streakDays.insert(fmt.string(from: record.timestamp))
        }

        var streak = 0
        var day = Date()
        while streakDays.contains(fmt.string(from: day)) {
            streak += 1
            day = calendar.date(byAdding: .day, value: -1, to: day)!
        }

        let recentScores = records.suffix(10).map(\.scores.overall)
        let bestOverall = bestScores.values.max() ?? 0

        return ProgressSummary(
            totalExercises: records.count,
            categoryCounts: categoryCounts,
            bestScores: bestScores,
            categoryAverages: categoryAverages,
            currentStreak: streak,
            recentScores: Array(recentScores),
            bestOverall: bestOverall
        )
    }

    // MARK: - Recommendations

    var recommendations: [String] {
        if records.isEmpty {
            return [
                "Start with a Presentation exercise to establish your baseline.",
                "Try a Negotiation scenario to practice vendor discussions.",
                "Complete a Leadership exercise for stakeholder management.",
            ]
        }

        var recs: [String] = []
        let allCategories = ["Presentation", "Negotiation", "Communication", "Leadership"]
        let sum = summary

        for cat in allCategories where sum.categoryCounts[cat] == nil {
            recs.append("You haven't tried \(cat) exercises yet — give it a go!")
        }

        for (cat, avg) in sum.categoryAverages where avg < 60 {
            recs.append("Your average in \(cat) is \(Int(avg))/100 — focus here.")
        }

        if sum.currentStreak == 0 {
            recs.append("Practice daily to build a streak — consistency is key!")
        }

        if recs.isEmpty {
            recs.append("Great progress! Try increasing difficulty for more challenge.")
        }

        return Array(recs.prefix(5))
    }
}
