import Foundation

// MARK: - Difficulty Levels

enum DifficultyLevel: Int, CaseIterable, Identifiable, Codable {
    case beginner = 1
    case intermediate = 2
    case advanced = 3
    case expert = 4

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .beginner: return "Beginner"
        case .intermediate: return "Intermediate"
        case .advanced: return "Advanced"
        case .expert: return "Expert"
        }
    }

    var subtitle: String {
        switch self {
        case .beginner: return "Internal team updates"
        case .intermediate: return "Cross-functional presentations"
        case .advanced: return "C-Suite and board-level"
        case .expert: return "Industry conferences & standards"
        }
    }

    var color: String {
        switch self {
        case .beginner: return "green"
        case .intermediate: return "blue"
        case .advanced: return "orange"
        case .expert: return "red"
        }
    }
}

// MARK: - Scoring Dimensions

enum ScoringDimension: String, CaseIterable {
    case clarity
    case structure
    case technicalAccuracy = "technical_accuracy"
    case persuasiveness
    case conciseness

    var displayName: String {
        switch self {
        case .clarity: return "Clarity"
        case .structure: return "Structure"
        case .technicalAccuracy: return "Technical Accuracy"
        case .persuasiveness: return "Persuasiveness"
        case .conciseness: return "Conciseness"
        }
    }

    var description: String {
        switch self {
        case .clarity: return "How clear and understandable"
        case .structure: return "Logical flow and organization"
        case .technicalAccuracy: return "Correct use of technical terms"
        case .persuasiveness: return "Ability to convince and influence"
        case .conciseness: return "Delivering without verbosity"
        }
    }

    var weight: Double {
        switch self {
        case .clarity: return 0.25
        case .structure: return 0.20
        case .technicalAccuracy: return 0.20
        case .persuasiveness: return 0.20
        case .conciseness: return 0.15
        }
    }

    var iconName: String {
        switch self {
        case .clarity: return "eye.fill"
        case .structure: return "list.bullet.rectangle.fill"
        case .technicalAccuracy: return "cpu.fill"
        case .persuasiveness: return "bolt.fill"
        case .conciseness: return "scissors"
        }
    }
}

// MARK: - Telecom Domain

struct TelecomDomain {
    static let technologies = [
        "5G SA Core", "5G NSA", "Network Slicing", "Service Based Architecture",
        "SBA", "NWDAF", "AUSF", "UDM", "AMF", "SMF", "UPF", "PCF", "NRF", "NEF", "SEPP",
        "NFV", "SDN", "MEC", "O-RAN", "Cloud-Native", "CNF",
        "AI-Native", "THz", "Reconfigurable Intelligent Surfaces", "RIS",
        "Digital Twin", "Non-Terrestrial Networks", "NTN",
        "ISAC", "Semantic Communication", "Zero-Trust",
        "3GPP", "Release 18", "Release 19", "Network Automation",
        "Intent-Based Networking", "URLLC", "mMTC", "eMBB",
    ]
}
