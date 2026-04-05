import Foundation
import SwiftUI

@MainActor
class ChatStore: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedModel: ClaudeModel = .sonnet
    @Published var apiKey: String = ""

    private let claudeService = ClaudeService()
    private let apiKeyStorageKey = "telecom_wisdom_claude_api_key"
    private let modelStorageKey = "telecom_wisdom_claude_model"

    init() {
        apiKey = UserDefaults.standard.string(forKey: apiKeyStorageKey) ?? ""
        if let savedModel = UserDefaults.standard.string(forKey: modelStorageKey),
           let model = ClaudeModel(rawValue: savedModel) {
            selectedModel = model
        }
    }

    func saveSettings() {
        UserDefaults.standard.set(apiKey, forKey: apiKeyStorageKey)
        UserDefaults.standard.set(selectedModel.rawValue, forKey: modelStorageKey)
    }

    func sendMessage(_ text: String, context: ServiceContext) async {
        let userMsg = ChatMessage(role: .user, content: text)
        messages.append(userMsg)
        isLoading = true
        errorMessage = nil

        do {
            let result = try await claudeService.sendMessage(
                apiKey: apiKey,
                model: selectedModel,
                userMessage: text,
                conversationHistory: Array(messages.dropLast()),
                serviceContext: context
            )
            let assistantMsg = ChatMessage(
                role: .assistant,
                content: result.response,
                references: result.references
            )
            messages.append(assistantMsg)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func clearChat() {
        messages.removeAll()
        errorMessage = nil
    }

    var hasAPIKey: Bool {
        !apiKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
