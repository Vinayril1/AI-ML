import SwiftUI

@main
struct CommunicationCoachApp: App {
    @StateObject private var progressStore = ProgressStore()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(progressStore)
        }
    }
}
