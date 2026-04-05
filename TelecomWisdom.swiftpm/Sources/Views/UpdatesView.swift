import SwiftUI

struct UpdatesView: View {
    @EnvironmentObject var dataStore: TelecomDataStore
    @State private var showChat = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    refreshStatusCard
                    autoUpdateInfo
                    serviceContentList
                    manualRefreshSection
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Updates")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showChat = true
                    } label: {
                        Image(systemName: "bubble.left.and.bubble.right.fill")
                            .foregroundStyle(.blue)
                    }
                }
            }
            .sheet(isPresented: $showChat) {
                NavigationStack {
                    ChatView(context: .general)
                        .navigationTitle("Ask Expert")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Button("Close") { showChat = false }
                            }
                        }
                }
            }
        }
    }

    private var refreshStatusCard: some View {
        VStack(spacing: 12) {
            Image(systemName: dataStore.isRefreshing ? "arrow.triangle.2.circlepath" : "checkmark.circle.fill")
                .font(.system(size: 36))
                .foregroundStyle(dataStore.isRefreshing ? .orange : .green)

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
            Label("Auto-Update", systemImage: "clock.fill")
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

    // MARK: - Clickable Service Content with Whitepapers

    private var serviceContentList: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Service Content")
                .font(.headline)

            ForEach(ServiceCatalog.allServices) { service in
                NavigationLink(destination: UpdateServiceDetailView(serviceId: service.id)) {
                    HStack(spacing: 12) {
                        Image(systemName: service.icon)
                            .font(.caption)
                            .frame(width: 28, height: 28)
                            .background(Color.blue.opacity(0.1), in: RoundedRectangle(cornerRadius: 6))
                            .foregroundStyle(.blue)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(service.name)
                                .font(.caption.bold())
                                .foregroundStyle(.primary)
                            let svc = dataStore.service(byId: service.id)
                            let researchCount = svc?.researchItems.count ?? 0
                            let standardsCount = svc?.standards.count ?? 0
                            let meetingsCount = svc?.meetingDiscussions.count ?? 0
                            Text("\(researchCount) papers · \(standardsCount) specs · \(meetingsCount) meetings")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        Image(systemName: "chevron.right")
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                    }
                    .padding(.vertical, 6)
                }
                .buttonStyle(.plain)
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

// MARK: - Update Service Detail (Whitepapers + Summary + Source Links + Chat)

struct UpdateServiceDetailView: View {
    let serviceId: String
    @EnvironmentObject var dataStore: TelecomDataStore
    @State private var showChat = false

    private var service: TelecomService? { dataStore.service(byId: serviceId) }

    var body: some View {
        Group {
            if let service {
                ScrollView {
                    VStack(spacing: 16) {
                        // Service header
                        VStack(spacing: 6) {
                            Image(systemName: service.icon)
                                .font(.title)
                                .foregroundStyle(.blue)
                            Text(service.name)
                                .font(.title3.bold())
                            Text(service.shortDescription)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                            if let updated = service.lastUpdated {
                                Text("Updated: \(updated.formatted(.relative(presentation: .named)))")
                                    .font(.caption2)
                                    .foregroundStyle(.tertiary)
                            }
                        }
                        .padding()

                        // Research / Whitepapers
                        if !service.researchItems.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Label("Research & Whitepapers", systemImage: "book.fill")
                                    .font(.headline)

                                ForEach(service.researchItems) { item in
                                    WhitepaperCard(item: item)
                                }
                            }
                            .padding()
                            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 14))
                        }

                        // Standards
                        if !service.standards.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Label("3GPP Standards", systemImage: "doc.text.fill")
                                    .font(.headline)

                                ForEach(service.standards) { std in
                                    StandardCard(standard: std)
                                }
                            }
                            .padding()
                            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 14))
                        }

                        // Meetings
                        if !service.meetingDiscussions.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Label("Meeting Discussions", systemImage: "person.3.fill")
                                    .font(.headline)

                                ForEach(service.meetingDiscussions) { mtg in
                                    MeetingCard(meeting: mtg)
                                }
                            }
                            .padding()
                            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 14))
                        }

                        // Chat section inline
                        VStack(alignment: .leading, spacing: 8) {
                            Label("Ask about \(service.name)", systemImage: "bubble.left.and.bubble.right.fill")
                                .font(.headline)
                            ChatView(context: ServiceContext(service: service, section: "updates"))
                                .frame(height: 400)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .padding()
                        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 14))
                    }
                    .padding()
                }
            } else {
                Text("Service not found")
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(service?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Whitepaper Card

struct WhitepaperCard: View {
    let item: ResearchItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                StatusBadge(text: item.status.rawValue, color: statusColor(item.status))
                Spacer()
                Text("\(item.year)")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }

            Text(item.title)
                .font(.subheadline.bold())

            Text(item.authors)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(item.source)
                .font(.caption2)
                .foregroundStyle(.blue)

            // Summary
            Text(item.summary)
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(8)
                .background(Color(.tertiarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 8))

            // Key findings
            if !item.keyFindings.isEmpty {
                VStack(alignment: .leading, spacing: 3) {
                    ForEach(item.keyFindings, id: \.self) { finding in
                        HStack(alignment: .top, spacing: 6) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 9))
                                .foregroundStyle(.green)
                                .padding(.top, 2)
                            Text(finding)
                                .font(.caption2)
                        }
                    }
                }
            }

            // Source link
            if let url = URL(string: item.sourceURL) {
                Link(destination: url) {
                    Label("View Source", systemImage: "arrow.up.right.square")
                        .font(.caption.bold())
                }
            }
        }
        .padding(12)
        .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 10))
    }

    private func statusColor(_ status: ResearchStatus) -> Color {
        switch status {
        case .conceptual: return .gray
        case .earlyResearch: return .yellow
        case .activeResearch: return .orange
        case .standardization: return .blue
        case .trial: return .purple
        case .deployment: return .green
        case .mature: return .mint
        }
    }
}

// MARK: - Standard Card

struct StandardCard: View {
    let standard: Standard

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(standard.specNumber)
                    .font(.caption.bold())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Color.blue.opacity(0.12), in: Capsule())
                    .foregroundStyle(.blue)
                Text(standard.release)
                    .font(.caption2)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.purple.opacity(0.12), in: Capsule())
                    .foregroundStyle(.purple)
                Spacer()
                Text(standard.workingGroup)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Text(standard.title)
                .font(.caption.bold())

            Text(standard.summary)
                .font(.caption2)
                .foregroundStyle(.secondary)

            if let url = URL(string: standard.specURL) {
                Link(destination: url) {
                    Label("View on 3GPP Portal", systemImage: "link")
                        .font(.caption2.bold())
                }
            }
        }
        .padding(12)
        .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - Meeting Card

struct MeetingCard: View {
    let meeting: MeetingDiscussion

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(meeting.meetingNumber)
                    .font(.caption.bold())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Color.orange.opacity(0.12), in: Capsule())
                    .foregroundStyle(.orange)
                Text(meeting.workingGroup)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(meeting.date)
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }

            Text(meeting.topic)
                .font(.caption.bold())

            Text(meeting.summary)
                .font(.caption2)
                .foregroundStyle(.secondary)

            if !meeting.tdocReferences.isEmpty {
                Text("TDocs: \(meeting.tdocReferences.joined(separator: ", "))")
                    .font(.system(size: 9))
                    .foregroundStyle(.blue)
            }

            if let url = URL(string: meeting.sourceURL) {
                Link(destination: url) {
                    Label("View Meeting Docs", systemImage: "folder.fill")
                        .font(.caption2.bold())
                }
            }
        }
        .padding(12)
        .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 10))
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
