import Foundation
import SwiftUI

@MainActor
class QuizStore: ObservableObject {
    @Published var results: [QuizResult] = []

    private let storageKey = "telecom_wisdom_quiz_results"

    init() { load() }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([QuizResult].self, from: data)
        else { return }
        results = decoded
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(results) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }

    func recordResult(_ result: QuizResult) {
        results.append(result)
        save()
    }

    var totalQuizzesTaken: Int { results.count }

    var averageScore: Double {
        guard !results.isEmpty else { return 0 }
        return results.map(\.percentage).reduce(0, +) / Double(results.count)
    }

    var bestScore: Double {
        results.map(\.percentage).max() ?? 0
    }

    func averageForService(_ serviceId: String) -> Double {
        let filtered = results.filter { $0.serviceId == serviceId }
        guard !filtered.isEmpty else { return 0 }
        return filtered.map(\.percentage).reduce(0, +) / Double(filtered.count)
    }

    func weakAreas() -> [String] {
        var serviceScores: [String: [Double]] = [:]
        for result in results {
            if let sid = result.serviceId {
                serviceScores[sid, default: []].append(result.percentage)
            }
        }
        return serviceScores
            .filter { $0.value.reduce(0, +) / Double($0.value.count) < 60 }
            .map { $0.key }
    }
}
