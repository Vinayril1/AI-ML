import SwiftUI

struct UpdatesView: View {
    @EnvironmentObject var dataStore: TelecomDataStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    refreshStatusCard
                    autoUpdateInfo
                    serviceStatusList
                    manualRefreshSection
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Updates")
        }
    }

    private var refreshStatusCard: some View {
        VStack(spacing: 12) {
            Image(systemName: dataStore.isRefreshing ? "arrow.trianglehead.2.clockwise" : "checkmark.circle.fill")
                .font(.system(size: 36))
                .foregroundStyle(dataStore.isRefreshing ? .orange : .green)
                .symbolEffect(.rotate, isActive: dataStore.isRefreshing)

            if dataStore.isRefreshing {
                Text("Updating Content...")
                    .font(.headline)
                ProgressView()
            } else {
                Text("Content Up to Date")
                    .font(.headline)
            }

            if let last = dataStore.lastRefresh {
                Text("Last updated: \(last.formatted(.dateTime.month().day().hour().minute()))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } else {
                Text("Using built-in content")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 14))
    }

    private var autoUpdateInfo: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Auto-Update", systemImage: "clock.arrow.circlepath")
                .font(.headline)

            VStack(alignment: .leading, spacing: 6) {
                InfoRow(label: "Frequency", value: "Every 24 hours")
                InfoRow(label: "Sources", value: "arXiv, 3GPP FTP, GSMA")
                InfoRow(label: "Content", value: "Research papers, specs, meetings")
            }

            Text("Content refreshes automatically when you open the app if more than 24 hours have passed since the last update.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 14))
    }

    private var serviceStatusList: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Service Content")
                .font(.headline)

            ForEach(ServiceCatalog.allServices) { service in
                HStack(spacing: 12) {
                    Image(systemName: service.icon)
                        .font(.caption)
                        .frame(width: 28, height: 28)
                        .background(Color.blue.opacity(0.1), in: RoundedRectangle(cornerRadius: 6))
                        .foregroundStyle(.blue)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(service.name)
                            .font(.caption.bold())
                        let svc = dataStore.service(byId: service.id)
                        let researchCount = svc?.researchItems.count ?? 0
                        let standardsCount = svc?.standards.count ?? 0
                        let meetingsCount = svc?.meetingDiscussions.count ?? 0
                        Text("\(researchCount) papers · \(standardsCount) specs · \(meetingsCount) meetings")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Button {
                        Task { await dataStore.refreshService(id: service.id) }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.caption)
                            .foregroundStyle(.blue)
                    }
                    .disabled(dataStore.isRefreshing)
                }
                .padding(.vertical, 4)
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 14))
    }

    private var manualRefreshSection: some View {
        VStack(spacing: 12) {
            Button {
                Task { await dataStore.refreshAll() }
            } label: {
                Label("Refresh All Content", systemImage: "arrow.clockwise")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(dataStore.isRefreshing ? Color.gray : Color.blue, in: RoundedRectangle(cornerRadius: 12))
                    .foregroundStyle(.white)
            }
            .disabled(dataStore.isRefreshing)

            Text("Fetches latest research papers from arXiv, 3GPP specifications, and meeting documents.")
                .font(.caption2)
                .foregroundStyle(.tertiary)
                .multilineTextAlignment(.center)
        }
    }
}

struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.caption.bold())
        }
    }
}
