import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @EnvironmentObject var progressStore: ProgressStore

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)

            PresentationCoachView()
                .tabItem {
                    Label("Present", systemImage: "person.wave.2.fill")
                }
                .tag(1)

            NegotiationSimulatorView()
                .tabItem {
                    Label("Negotiate", systemImage: "handshake.fill")
                }
                .tag(2)

            CommunicationLabView()
                .tabItem {
                    Label("Communicate", systemImage: "envelope.fill")
                }
                .tag(3)

            LeadershipAcademyView()
                .tabItem {
                    Label("Lead", systemImage: "star.fill")
                }
                .tag(4)
        }
        .tint(.indigo)
    }
}

// MARK: - Home View

struct HomeView: View {
    @EnvironmentObject var progressStore: ProgressStore
    @State private var quote: LeadershipQuote = LeadershipData.randomQuote()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Header Card
                    headerCard

                    // Daily Quote
                    quoteCard

                    // Quick Stats
                    statsSection

                    // Module Cards
                    modulesSection

                    // Recommendations
                    recommendationsSection
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Coach")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: ProgressDashboardView()) {
                        Image(systemName: "chart.bar.fill")
                    }
                }
            }
        }
    }

    private var headerCard: some View {
        VStack(spacing: 8) {
            Image(systemName: "mic.circle.fill")
                .font(.system(size: 50))
                .foregroundStyle(.indigo)
            Text("Communication Skills Coach")
                .font(.title2.bold())
            Text("5G Advanced | 6G | Core Network")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }

    private var quoteCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: "quote.opening")
                .foregroundStyle(.indigo)
            Text(quote.text)
                .font(.subheadline)
                .italic()
            Text("— \(quote.author)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.indigo.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
    }

    private var statsSection: some View {
        let summary = progressStore.summary
        return HStack(spacing: 12) {
            StatCard(title: "Exercises", value: "\(summary.totalExercises)", icon: "checkmark.circle.fill", color: .green)
            StatCard(title: "Streak", value: "\(summary.currentStreak)d", icon: "flame.fill", color: .orange)
            StatCard(title: "Best", value: summary.bestOverall > 0 ? "\(Int(summary.bestOverall))" : "—", icon: "trophy.fill", color: .yellow)
        }
    }

    private var modulesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Modules")
                .font(.headline)
            ModuleCard(icon: "person.wave.2.fill", title: "Presentation Coach", subtitle: "8 scenarios from team updates to MWC keynotes", color: .green, tab: 1)
            ModuleCard(icon: "handshake.fill", title: "Negotiation Simulator", subtitle: "Vendor, enterprise & internal negotiations", color: .orange, tab: 2)
            ModuleCard(icon: "envelope.fill", title: "Communication Lab", subtitle: "Emails, meetings, vocabulary & explanations", color: .purple, tab: 3)
            ModuleCard(icon: "star.fill", title: "Leadership Academy", subtitle: "Decisions, team management & strategy", color: .red, tab: 4)
        }
    }

    private var recommendationsSection: some View {
        let recs = progressStore.recommendations
        return Group {
            if !recs.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Recommendations")
                        .font(.headline)
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
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .foregroundStyle(color)
            Text(value)
                .font(.title3.bold())
            Text(title)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
    }
}

struct ModuleCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    let tab: Int

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
                .frame(width: 44, height: 44)
                .background(color.opacity(0.12), in: RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline.bold())
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.tertiary)
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
    }
}
