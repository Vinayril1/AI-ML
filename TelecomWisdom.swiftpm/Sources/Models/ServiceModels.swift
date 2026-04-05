import Foundation

// MARK: - Core Service

struct TelecomService: Identifiable, Codable {
    let id: String
    let name: String
    let icon: String
    let color: String
    let shortDescription: String
    let category: ServiceCategory
    var researchItems: [ResearchItem]
    var standards: [Standard]
    var meetingDiscussions: [MeetingDiscussion]
    var lastUpdated: Date?
}

enum ServiceCategory: String, Codable, CaseIterable {
    case coreNetwork = "Core Network"
    case airInterface = "Air Interface & Spectrum"
    case aiNative = "AI & Automation"
    case newParadigms = "New Paradigms"
    case security = "Security & Privacy"
    case management = "Management & Orchestration"
}

// MARK: - Research

struct ResearchItem: Identifiable, Codable {
    let id: String
    let title: String
    let authors: String
    let source: String
    let year: Int
    let summary: String
    let keyFindings: [String]
    let sourceURL: String
    let status: ResearchStatus
}

enum ResearchStatus: String, Codable {
    case conceptual = "Conceptual"
    case earlyResearch = "Early Research"
    case activeResearch = "Active Research"
    case standardization = "Standardization"
    case trial = "Trial/PoC"
    case deployment = "Early Deployment"
    case mature = "Mature"
}

// MARK: - 3GPP Standards

struct Standard: Identifiable, Codable {
    let id: String
    let specNumber: String
    let title: String
    let release: String
    let workingGroup: String
    let summary: String
    let keyFeatures: [String]
    let specURL: String
    let status: StandardStatus
}

enum StandardStatus: String, Codable {
    case study = "Study Item"
    case workItem = "Work Item"
    case draft = "Draft"
    case approved = "Approved"
    case frozen = "Frozen"
}

// MARK: - Meeting Discussions

struct MeetingDiscussion: Identifiable, Codable {
    let id: String
    let meetingNumber: String
    let workingGroup: String
    let date: String
    let topic: String
    let summary: String
    let keyDecisions: [String]
    let tdocReferences: [String]
    let sourceURL: String
}

// MARK: - Quiz

struct QuizQuestion: Identifiable, Codable {
    let id: String
    let serviceId: String
    let category: QuizCategory
    let difficulty: QuizDifficulty
    let question: String
    let options: [String]
    let correctIndex: Int
    let explanation: String
    let reference: String
}

enum QuizCategory: String, Codable, CaseIterable {
    case latestDevelopments = "Latest Developments"
    case coreConcepts = "Core Concepts"
    case specifications = "3GPP Specifications"
    case architecture = "Architecture"
    case protocols = "Protocols & Interfaces"
}

enum QuizDifficulty: String, Codable, CaseIterable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
    case expert = "Expert"
}

// MARK: - Quiz Result

struct QuizResult: Identifiable, Codable {
    let id: UUID
    let date: Date
    let serviceId: String?
    let category: QuizCategory?
    let totalQuestions: Int
    let correctAnswers: Int
    let timeTaken: TimeInterval

    var percentage: Double {
        guard totalQuestions > 0 else { return 0 }
        return Double(correctAnswers) / Double(totalQuestions) * 100
    }
}

// MARK: - Content Update Tracking

struct ContentUpdateInfo: Codable {
    var lastFetchDate: Date?
    var lastSuccessfulFetch: Date?
    var fetchErrors: [String]
    var sourceStatuses: [String: Bool]
}
