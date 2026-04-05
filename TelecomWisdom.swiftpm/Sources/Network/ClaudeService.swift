import Foundation

// MARK: - Claude Model Selection

enum ClaudeModel: String, CaseIterable, Identifiable {
    case opus = "claude-opus-4-6"
    case sonnet = "claude-sonnet-4-6"

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .opus: return "Claude Opus"
        case .sonnet: return "Claude Sonnet"
        }
    }

    var shortName: String {
        switch self {
        case .opus: return "Opus"
        case .sonnet: return "Sonnet"
        }
    }
}

// MARK: - Chat Message

struct ChatMessage: Identifiable, Codable {
    let id: UUID
    let role: MessageRole
    let content: String
    let timestamp: Date
    var references: [SourceReference]

    init(role: MessageRole, content: String, references: [SourceReference] = []) {
        self.id = UUID()
        self.role = role
        self.content = content
        self.timestamp = Date()
        self.references = references
    }
}

enum MessageRole: String, Codable {
    case user
    case assistant
}

struct SourceReference: Identifiable, Codable {
    let id: UUID
    let title: String
    let url: String
    let type: ReferenceType

    init(title: String, url: String, type: ReferenceType) {
        self.id = UUID()
        self.title = title
        self.url = url
        self.type = type
    }
}

enum ReferenceType: String, Codable {
    case threeGPP = "3GPP"
    case research = "Research"
    case standard = "Standard"
    case meeting = "Meeting"
    case web = "Web"
}

// MARK: - Claude API Service

actor ClaudeService {
    private let session: URLSession

    init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        config.timeoutIntervalForResource = 120
        self.session = URLSession(configuration: config)
    }

    struct APIRequest: Encodable {
        let model: String
        let max_tokens: Int
        let system: String
        let messages: [APIMessage]
    }

    struct APIMessage: Encodable {
        let role: String
        let content: String
    }

    struct APIResponse: Decodable {
        let content: [ContentBlock]
    }

    struct ContentBlock: Decodable {
        let type: String
        let text: String?
    }

    struct APIError: Decodable {
        let error: ErrorDetail?
    }

    struct ErrorDetail: Decodable {
        let message: String?
        let type: String?
    }

    func sendMessage(
        apiKey: String,
        model: ClaudeModel,
        userMessage: String,
        conversationHistory: [ChatMessage],
        serviceContext: ServiceContext
    ) async throws -> (response: String, references: [SourceReference]) {

        guard !apiKey.isEmpty else {
            throw ClaudeError.noAPIKey
        }

        guard let url = URL(string: "https://api.anthropic.com/v1/messages") else {
            throw ClaudeError.invalidURL
        }

        let systemPrompt = buildSystemPrompt(context: serviceContext)

        var apiMessages: [APIMessage] = []
        for msg in conversationHistory.suffix(10) {
            apiMessages.append(APIMessage(role: msg.role.rawValue, content: msg.content))
        }
        apiMessages.append(APIMessage(role: "user", content: userMessage))

        let requestBody = APIRequest(
            model: model.rawValue,
            max_tokens: 2048,
            system: systemPrompt,
            messages: apiMessages
        )

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("2023-06-01", forHTTPHeaderField: "anthropic-version")
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.httpBody = try JSONEncoder().encode(requestBody)

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw ClaudeError.networkError("No HTTP response")
        }

        if httpResponse.statusCode != 200 {
            if let apiError = try? JSONDecoder().decode(APIError.self, from: data),
               let message = apiError.error?.message {
                throw ClaudeError.apiError(httpResponse.statusCode, message)
            }
            throw ClaudeError.apiError(httpResponse.statusCode, "Request failed")
        }

        let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
        let responseText = apiResponse.content.compactMap(\.text).joined()

        let references = extractReferences(from: responseText, context: serviceContext)

        return (responseText, references)
    }

    private func buildSystemPrompt(context: ServiceContext) -> String {
        var prompt = """
        You are an expert telecom solution architect assistant specializing in 5G Advanced and 6G core network technologies. \
        You provide detailed, technically accurate answers with references to authoritative sources.

        IMPORTANT GUIDELINES:
        - Always reference specific 3GPP specifications (e.g., TS 23.501, TS 29.500) when relevant
        - Include links to 3GPP portal: https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx
        - Reference working groups (SA1, SA2, SA3, SA5, CT3, CT4, RAN1) when discussing standardization
        - Cite real research papers and whitepapers when available
        - Mention relevant 3GPP releases (Rel-15 through Rel-19 and beyond)
        - For each technical claim, indicate the source (3GPP spec, research paper, industry whitepaper)
        - Format references as [Source: <title> - <url>] at the end of relevant paragraphs
        """

        if let service = context.service {
            prompt += "\n\nCurrent service context: \(service.name) — \(service.shortDescription)"

            if !service.standards.isEmpty {
                prompt += "\n\nRelevant 3GPP Standards for this service:"
                for std in service.standards {
                    prompt += "\n- \(std.specNumber): \(std.title) (\(std.release), \(std.workingGroup)) — \(std.specURL)"
                }
            }

            if !service.researchItems.isEmpty {
                prompt += "\n\nKey research papers for this service:"
                for item in service.researchItems.prefix(5) {
                    prompt += "\n- \(item.title) by \(item.authors) (\(item.year)) — \(item.sourceURL)"
                }
            }

            if !service.meetingDiscussions.isEmpty {
                prompt += "\n\nRecent 3GPP meeting discussions:"
                for mtg in service.meetingDiscussions.prefix(3) {
                    prompt += "\n- \(mtg.meetingNumber) \(mtg.workingGroup): \(mtg.topic)"
                }
            }
        }

        return prompt
    }

    private func extractReferences(from text: String, context: ServiceContext) -> [SourceReference] {
        var refs: [SourceReference] = []

        // Extract [Source: ...] patterns from response
        let pattern = "\\[Source: ([^\\]]+)\\]"
        if let regex = try? NSRegularExpression(pattern: pattern) {
            let matches = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            for match in matches {
                if let range = Range(match.range(at: 1), in: text) {
                    let sourceText = String(text[range])
                    let parts = sourceText.components(separatedBy: " - ")
                    let title = parts.first ?? sourceText
                    let url = parts.count > 1 ? parts.last! : ""
                    let type: ReferenceType = url.contains("3gpp") ? .threeGPP :
                        url.contains("arxiv") ? .research : .web
                    refs.append(SourceReference(title: title.trimmingCharacters(in: .whitespaces),
                                                url: url.trimmingCharacters(in: .whitespaces),
                                                type: type))
                }
            }
        }

        // Add relevant standards from context if mentioned in response
        if let service = context.service {
            for std in service.standards {
                if text.contains(std.specNumber) && !refs.contains(where: { $0.title.contains(std.specNumber) }) {
                    refs.append(SourceReference(title: "\(std.specNumber): \(std.title)", url: std.specURL, type: .standard))
                }
            }
        }

        return refs
    }
}

// MARK: - Service Context

struct ServiceContext {
    let service: TelecomService?
    let section: String?

    static var general: ServiceContext {
        ServiceContext(service: nil, section: nil)
    }
}

// MARK: - Errors

enum ClaudeError: LocalizedError {
    case noAPIKey
    case invalidURL
    case networkError(String)
    case apiError(Int, String)
    case decodingError

    var errorDescription: String? {
        switch self {
        case .noAPIKey: return "Please enter your Anthropic API key in Settings to use the chat feature."
        case .invalidURL: return "Invalid API URL."
        case .networkError(let msg): return "Network error: \(msg)"
        case .apiError(let code, let msg): return "API error (\(code)): \(msg)"
        case .decodingError: return "Failed to parse response."
        }
    }
}
