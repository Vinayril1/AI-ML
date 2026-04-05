import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var dataStore: TelecomDataStore

    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Services", systemImage: "antenna.radiowaves.left.and.right") }
                .tag(0)
            QuizHomeView()
                .tabItem { Label("Quiz", systemImage: "questionmark.circle.fill") }
                .tag(1)
            UpdatesView()
                .tabItem { Label("Updates", systemImage: "arrow.clockwise.circle.fill") }
                .tag(2)
        }
        .tint(.blue)
    }
}
