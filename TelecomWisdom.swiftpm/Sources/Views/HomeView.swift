import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataStore: TelecomDataStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    headerCard

                    ForEach(ServiceCategory.allCases, id: \.rawValue) { category in
                        let services = dataStore.services(for: category)
                        if !services.isEmpty {
                            categorySection(category: category, services: services)
                        }
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("5G/6G Technologies")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if dataStore.isRefreshing {
                        ProgressView()
                    } else {
                        Button {
                            Task { await dataStore.refreshAll() }
                        } label: {
                            Image(systemName: "arrow.clockwise")
                        }
                    }
                }
            }
        }
    }

    private var headerCard: some View {
        VStack(spacing: 8) {
            Image(systemName: "antenna.radiowaves.left.and.right")
                .font(.system(size: 44))
                .foregroundStyle(.blue)
            Text("Telecom Wisdom")
                .font(.title2.bold())
            Text("5G Advanced | 6G | Core Network | Standards | Research")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            if let last = dataStore.lastRefresh {
                Text("Updated: \(dataStore.lastRefreshText)")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }

    private func categorySection(category: ServiceCategory, services: [TelecomService]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(category.rawValue)
                .font(.headline)
                .foregroundStyle(.primary)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(services) { service in
                    NavigationLink(destination: ServiceDetailView(serviceId: service.id)) {
                        ServiceCard(service: service)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

// MARK: - Service Card

struct ServiceCard: View {
    let service: TelecomService

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: service.icon)
                .font(.title)
                .foregroundStyle(colorForService)
                .frame(width: 50, height: 50)
                .background(colorForService.opacity(0.12), in: RoundedRectangle(cornerRadius: 12))

            Text(service.name)
                .font(.caption.bold())
                .multilineTextAlignment(.center)
                .lineLimit(2)

            HStack(spacing: 8) {
                StatBadge(count: service.researchItems.count, icon: "doc.text.fill")
                StatBadge(count: service.standards.count, icon: "checkmark.seal.fill")
                StatBadge(count: service.meetingDiscussions.count, icon: "bubble.left.fill")
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .padding(.horizontal, 8)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 14))
    }

    private var colorForService: Color {
        switch service.color {
        case "blue": return .blue
        case "indigo": return .indigo
        case "green": return .green
        case "orange": return .orange
        case "purple": return .purple
        case "cyan": return .cyan
        case "teal": return .teal
        case "red": return .red
        case "mint": return .mint
        case "brown": return .brown
        case "pink": return .pink
        case "yellow": return .yellow
        case "gray": return .gray
        default: return .blue
        }
    }
}

struct StatBadge: View {
    let count: Int
    let icon: String

    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: icon)
            Text("\(count)")
        }
        .font(.system(size: 9))
        .foregroundStyle(.secondary)
    }
}
