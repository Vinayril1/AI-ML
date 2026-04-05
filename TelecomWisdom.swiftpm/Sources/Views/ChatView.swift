import SwiftUI

// MARK: - Chat View (embedded in Services & Updates)

struct ChatView: View {
    let context: ServiceContext
    @StateObject private var chatStore = ChatStore()
    @State private var inputText = ""
    @State private var showSettings = false

    var body: some View {
        VStack(spacing: 0) {
            // Chat header with model selector
            chatHeader

            Divider()

            if !chatStore.hasAPIKey {
                apiKeyPrompt
            } else {
                // Messages list
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 12) {
                            welcomeMessage
                            ForEach(chatStore.messages) { msg in
                                MessageBubble(message: msg)
                                    .id(msg.id)
                            }
                            if chatStore.isLoading {
                                typingIndicator
                            }
                            if let error = chatStore.errorMessage {
                                errorBubble(error)
                            }
                        }
                        .padding()
                    }
                    .onChange(of: chatStore.messages.count) { _, _ in
                        if let lastId = chatStore.messages.last?.id {
                            withAnimation { proxy.scrollTo(lastId, anchor: .bottom) }
                        }
                    }
                }

                Divider()

                // Input bar
                inputBar
            }
        }
        .background(Color(.systemGroupedBackground))
        .sheet(isPresented: $showSettings) {
            ChatSettingsSheet(chatStore: chatStore)
        }
    }

    // MARK: - Subviews

    private var chatHeader: some View {
        HStack {
            Image(systemName: "bubble.left.and.bubble.right.fill")
                .foregroundStyle(.blue)
            Text("Ask Expert")
                .font(.subheadline.bold())

            Spacer()

            // Model picker
            Menu {
                ForEach(ClaudeModel.allCases) { model in
                    Button {
                        chatStore.selectedModel = model
                        chatStore.saveSettings()
                    } label: {
                        HStack {
                            Text(model.displayName)
                            if chatStore.selectedModel == model {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                HStack(spacing: 4) {
                    Text(chatStore.selectedModel.shortName)
                        .font(.caption.bold())
                    Image(systemName: "chevron.down")
                        .font(.system(size: 8))
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.blue.opacity(0.12), in: Capsule())
                .foregroundStyle(.blue)
            }

            Button {
                showSettings = true
            } label: {
                Image(systemName: "gearshape.fill")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            if !chatStore.messages.isEmpty {
                Button {
                    chatStore.clearChat()
                } label: {
                    Image(systemName: "trash")
                        .font(.caption)
                        .foregroundStyle(.red.opacity(0.7))
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color(.secondarySystemGroupedBackground))
    }

    private var apiKeyPrompt: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "key.fill")
                .font(.system(size: 40))
                .foregroundStyle(.orange)
            Text("API Key Required")
                .font(.headline)
            Text("Enter your Anthropic API key to chat with Claude about telecom technologies.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            Button {
                showSettings = true
            } label: {
                Label("Configure API Key", systemImage: "gearshape.fill")
                    .font(.subheadline.bold())
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .background(.blue, in: Capsule())
                    .foregroundStyle(.white)
            }
            Spacer()
        }
    }

    private var welcomeMessage: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let service = context.service {
                Text("Ask me anything about **\(service.name)**")
                    .font(.caption)
                Text("I can help with \(service.shortDescription.lowercased()) References will link to 3GPP specs and research papers.")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            } else {
                Text("Ask me about any 5G/6G technology")
                    .font(.caption)
                Text("I provide answers with references to 3GPP specifications, research papers, and industry standards.")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.blue.opacity(0.06), in: RoundedRectangle(cornerRadius: 10))
    }

    private var typingIndicator: some View {
        HStack(spacing: 4) {
            ForEach(0..<3) { i in
                Circle()
                    .fill(Color.blue.opacity(0.5))
                    .frame(width: 6, height: 6)
            }
            Text("Thinking...")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal)
    }

    private func errorBubble(_ error: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundStyle(.red)
                .font(.caption)
            Text(error)
                .font(.caption)
                .foregroundStyle(.red)
        }
        .padding(10)
        .background(Color.red.opacity(0.08), in: RoundedRectangle(cornerRadius: 8))
    }

    private var inputBar: some View {
        HStack(spacing: 10) {
            TextField("Ask about this technology...", text: $inputText, axis: .vertical)
                .textFieldStyle(.plain)
                .font(.subheadline)
                .lineLimit(1...4)
                .padding(10)
                .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))

            Button {
                let text = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !text.isEmpty else { return }
                inputText = ""
                Task { await chatStore.sendMessage(text, context: context) }
            } label: {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.title2)
                    .foregroundStyle(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .gray : .blue)
            }
            .disabled(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || chatStore.isLoading)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
    }
}

// MARK: - Message Bubble

struct MessageBubble: View {
    let message: ChatMessage

    var body: some View {
        VStack(alignment: message.role == .user ? .trailing : .leading, spacing: 6) {
            HStack {
                if message.role == .user { Spacer(minLength: 40) }

                VStack(alignment: .leading, spacing: 8) {
                    Text(message.content)
                        .font(.subheadline)
                        .textSelection(.enabled)

                    // Source references
                    if !message.references.isEmpty {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Sources")
                                .font(.caption2.bold())
                                .foregroundStyle(.secondary)
                            ForEach(message.references) { ref in
                                ReferenceLink(reference: ref)
                            }
                        }
                        .padding(.top, 4)
                    }
                }
                .padding(12)
                .background(
                    message.role == .user
                    ? Color.blue.opacity(0.12)
                    : Color(.secondarySystemGroupedBackground),
                    in: RoundedRectangle(cornerRadius: 12)
                )

                if message.role == .assistant { Spacer(minLength: 40) }
            }

            Text(message.timestamp.formatted(.dateTime.hour().minute()))
                .font(.system(size: 9))
                .foregroundStyle(.tertiary)
                .padding(.horizontal, 4)
        }
        .frame(maxWidth: .infinity, alignment: message.role == .user ? .trailing : .leading)
    }
}

// MARK: - Reference Link

struct ReferenceLink: View {
    let reference: SourceReference

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: iconForType)
                .font(.system(size: 9))
                .foregroundStyle(colorForType)

            if let url = URL(string: reference.url), !reference.url.isEmpty {
                Link(destination: url) {
                    Text(reference.title)
                        .font(.caption2)
                        .foregroundStyle(.blue)
                        .lineLimit(2)
                }
            } else {
                Text(reference.title)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
    }

    private var iconForType: String {
        switch reference.type {
        case .threeGPP, .standard: return "doc.text.fill"
        case .research: return "book.fill"
        case .meeting: return "person.3.fill"
        case .web: return "globe"
        }
    }

    private var colorForType: Color {
        switch reference.type {
        case .threeGPP: return .blue
        case .standard: return .indigo
        case .research: return .green
        case .meeting: return .orange
        case .web: return .gray
        }
    }
}

// MARK: - Chat Settings Sheet

struct ChatSettingsSheet: View {
    @ObservedObject var chatStore: ChatStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section("API Key") {
                    SecureField("Anthropic API Key (sk-ant-...)", text: $chatStore.apiKey)
                        .textContentType(.password)
                        .font(.subheadline)
                    Text("Get your API key from console.anthropic.com")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }

                Section("Model") {
                    Picker("Claude Model", selection: $chatStore.selectedModel) {
                        ForEach(ClaudeModel.allCases) { model in
                            VStack(alignment: .leading) {
                                Text(model.displayName)
                            }
                            .tag(model)
                        }
                    }
                    .pickerStyle(.inline)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Opus — Most capable, best for complex technical analysis")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                        Text("Sonnet — Fast, great for quick questions and lookups")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }

                Section("About") {
                    Text("Chat uses the Anthropic Messages API to provide expert telecom answers with references to 3GPP specifications, research papers, and industry standards.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Chat Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        chatStore.saveSettings()
                        dismiss()
                    }
                    .bold()
                }
            }
        }
    }
}
