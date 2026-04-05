import SwiftUI

@main
struct TelecomWisdomApp: App {
    @StateObject private var dataStore = TelecomDataStore()
    @StateObject private var quizStore = QuizStore()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(dataStore)
                .environmentObject(quizStore)
                .task {
                    await dataStore.refreshAllIfNeeded()
                }
        }
    }
}
