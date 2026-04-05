import SwiftUI

struct ServiceDetailView: View {
    let serviceId: String
    @EnvironmentObject var dataStore: TelecomDataStore
    @State private var selectedSection = 0

    private var service: TelecomService? { dataStore.service(byId: serviceId) }

    var body: some View {
        Group {
            if let service {
                ScrollView {
                    VStack(spacing: 20) {
                        // Service Header
                        VStack(spacing: 8) {
                            Image(systemName: service.icon)
                                .font(.system(size: 40))
                                .foregroundStyle(.blue)
                            Text(service.name)
                                .font(.title2.bold())
                            Text(service.shortDescription)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                            if let updated = service.lastUpdated {
                                Label("Updated: \(updated.formatted(.relative(presentation: .named)))", systemImage: "clock.fill")
                                    .font(.caption2)
                                    .foregroundStyle(.tertiary)
                            }
                        }
                        .padding()

                        // Section Picker
                        Picker("Section", selection: $selectedSection) {
                            Text("Research (\(service.researchItems.count))").tag(0)
                            Text("Standards (\(service.standards.count))").tag(1)
                            Text("Meetings (\(service.meetingDiscussions.count))").tag(2)
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)

                        // Content
                        switch selectedSection {
                        case 0: researchSection(service.researchItems)
                        case 1: standardsSection(service.standards)
                        case 2: meetingsSection(service.meetingDiscussions)
                        default: EmptyView()
                        }
                    }
                    .padding(.bottom, 20)
                }
            } else {
                Text("Service not found")
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(service?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task { await dataStore.refreshService(id: serviceId) }
                } label: {
                    Image(systemName: dataStore.isRefreshing ? "arrow.clockwise" : "arrow.clockwise")
                }
                .disabled(dataStore.isRefreshing)
            }
        }
    }

    // MARK: - Research Section

    private func researchSection(_ items: [ResearchItem]) -> some View {
        LazyVStack(spacing: 14) {
            ForEach(items) { item in
                VStack(alignment: .leading, spacing: 10) {
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

                    Text(item.summary)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    if !item.keyFindings.isEmpty {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Key Findings")
                                .font(.caption.bold())
                                .foregroundStyle(.green)
                            ForEach(item.keyFindings, id: \.self) { finding in
                                HStack(alignment: .top, spacing: 6) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 10))
                                        .foregroundStyle(.green)
                                        .padding(.top, 2)
                                    Text(finding)
                                        .font(.caption)
                                }
                            }
                        }
                    }

                    if let url = URL(string: item.sourceURL) {
                        Link(destination: url) {
                            Label("View Source", systemImage: "arrow.up.right.square")
                                .font(.caption.bold())
                        }
                    }
                }
                .padding()
                .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding(.horizontal)
    }

    // MARK: - Standards Section

    private func standardsSection(_ items: [Standard]) -> some View {
        LazyVStack(spacing: 14) {
            ForEach(items) { item in
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(item.specNumber)
                            .font(.caption.bold())
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(Color.blue.opacity(0.12), in: Capsule())
                            .foregroundStyle(.blue)
                        Text(item.release)
                            .font(.caption2)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.purple.opacity(0.12), in: Capsule())
                            .foregroundStyle(.purple)
                        Text(item.workingGroup)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                        Spacer()
                        StatusBadge(text: item.status.rawValue, color: specStatusColor(item.status))
                    }

                    Text(item.title)
                        .font(.subheadline.bold())

                    Text(item.summary)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    if !item.keyFeatures.isEmpty {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Key Features")
                                .font(.caption.bold())
                                .foregroundStyle(.indigo)
                            ForEach(item.keyFeatures, id: \.self) { feature in
                                HStack(alignment: .top, spacing: 6) {
                                    Image(systemName: "diamond.fill")
                                        .font(.system(size: 6))
                                        .foregroundStyle(.indigo)
                                        .padding(.top, 4)
                                    Text(feature)
                                        .font(.caption)
                                }
                            }
                        }
                    }

                    if let url = URL(string: item.specURL) {
                        Link(destination: url) {
                            Label("View on 3GPP Portal", systemImage: "link")
                                .font(.caption.bold())
                        }
                    }
                }
                .padding()
                .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding(.horizontal)
    }

    // MARK: - Meetings Section

    private func meetingsSection(_ items: [MeetingDiscussion]) -> some View {
        LazyVStack(spacing: 14) {
            ForEach(items) { item in
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(item.meetingNumber)
                            .font(.caption.bold())
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(Color.orange.opacity(0.12), in: Capsule())
                            .foregroundStyle(.orange)
                        Text(item.workingGroup)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(item.date)
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                    }

                    Text(item.topic)
                        .font(.subheadline.bold())

                    Text(item.summary)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    if !item.keyDecisions.isEmpty {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Key Decisions")
                                .font(.caption.bold())
                                .foregroundStyle(.orange)
                            ForEach(item.keyDecisions, id: \.self) { decision in
                                HStack(alignment: .top, spacing: 6) {
                                    Image(systemName: "arrow.right.circle.fill")
                                        .font(.system(size: 10))
                                        .foregroundStyle(.orange)
                                        .padding(.top, 2)
                                    Text(decision)
                                        .font(.caption)
                                }
                            }
                        }
                    }

                    if !item.tdocReferences.isEmpty {
                        HStack {
                            Text("TDocs:")
                                .font(.caption2.bold())
                                .foregroundStyle(.secondary)
                            Text(item.tdocReferences.joined(separator: ", "))
                                .font(.caption2)
                                .foregroundStyle(.blue)
                        }
                    }

                    if let url = URL(string: item.sourceURL) {
                        Link(destination: url) {
                            Label("View Meeting Docs", systemImage: "folder.fill")
                                .font(.caption.bold())
                        }
                    }
                }
                .padding()
                .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding(.horizontal)
    }

    // MARK: - Helpers

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

    private func specStatusColor(_ status: StandardStatus) -> Color {
        switch status {
        case .study: return .yellow
        case .workItem: return .orange
        case .draft: return .blue
        case .approved: return .green
        case .frozen: return .mint
        }
    }
}

struct StatusBadge: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(.system(size: 9, weight: .bold))
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(color.opacity(0.15), in: Capsule())
            .foregroundStyle(color)
    }
}
