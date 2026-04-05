import Foundation
import SwiftUI

// MARK: - Main Data Store

@MainActor
class TelecomDataStore: ObservableObject {
    @Published var services: [TelecomService] = ServiceCatalog.allServices
    @Published var isRefreshing = false
    @Published var lastRefresh: Date?
    @Published var refreshErrors: [String] = []

    private let storageKey = "telecom_wisdom_services"
    private let lastRefreshKey = "telecom_wisdom_last_refresh"
    private let refreshInterval: TimeInterval = 24 * 60 * 60 // 24 hours

    init() {
        loadCachedData()
    }

    // MARK: - Persistence

    private func loadCachedData() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let cached = try? JSONDecoder().decode([TelecomService].self, from: data) {
            // Merge cached with built-in: use cached if it has more/newer data
            var merged = ServiceCatalog.allServices
            for (i, service) in merged.enumerated() {
                if let cachedService = cached.first(where: { $0.id == service.id }) {
                    // Keep built-in data but append any live-fetched items
                    let liveResearch = cachedService.researchItems.filter { $0.id.contains("_live_") }
                    let liveMeetings = cachedService.meetingDiscussions.filter { $0.id.contains("_live_") }
                    merged[i].researchItems.append(contentsOf: liveResearch)
                    merged[i].meetingDiscussions.append(contentsOf: liveMeetings)
                    merged[i].lastUpdated = cachedService.lastUpdated
                }
            }
            services = merged
        }
        if let lastDate = UserDefaults.standard.object(forKey: lastRefreshKey) as? Date {
            lastRefresh = lastDate
        }
    }

    private func saveCache() {
        if let data = try? JSONEncoder().encode(services) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
        UserDefaults.standard.set(lastRefresh, forKey: lastRefreshKey)
    }

    // MARK: - Auto-Refresh

    func refreshAllIfNeeded() async {
        guard shouldRefresh() else { return }
        await refreshAll()
    }

    private func shouldRefresh() -> Bool {
        guard let last = lastRefresh else { return true }
        return Date().timeIntervalSince(last) > refreshInterval
    }

    func refreshAll() async {
        isRefreshing = true
        refreshErrors = []

        let fetcher = ContentFetcher.shared

        var updatedServices: [TelecomService] = []
        for service in services {
            let updated = await fetcher.refreshService(service)
            updatedServices.append(updated)
        }

        services = updatedServices
        lastRefresh = Date()
        isRefreshing = false
        saveCache()
    }

    func refreshService(id: String) async {
        guard let index = services.firstIndex(where: { $0.id == id }) else { return }
        isRefreshing = true
        let fetcher = ContentFetcher.shared
        let updated = await fetcher.refreshService(services[index])
        services[index] = updated
        isRefreshing = false
        saveCache()
    }

    // MARK: - Accessors

    func service(byId id: String) -> TelecomService? {
        services.first { $0.id == id }
    }

    func services(for category: ServiceCategory) -> [TelecomService] {
        services.filter { $0.category == category }
    }

    var lastRefreshText: String {
        guard let last = lastRefresh else { return "Never" }
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: last, relativeTo: Date())
    }
}
