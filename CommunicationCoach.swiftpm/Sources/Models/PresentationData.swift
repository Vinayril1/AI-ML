import Foundation

struct PresentationScenario: Identifiable {
    let id = UUID()
    let level: DifficultyLevel
    let title: String
    let scenario: String
    let audience: String
    let timeLimit: String
    let keyPoints: [String]
}

struct PresentationData {
    static let scenarios: [PresentationScenario] = [
        PresentationScenario(
            level: .beginner,
            title: "Sprint Review Update",
            scenario: "You are presenting a sprint review to your core network development team. The sprint focused on implementing a new Network Slice Management Function (NSMF) microservice. Explain what was accomplished, what challenges were encountered, and what's planned for the next sprint.",
            audience: "Development team (8-10 engineers)",
            timeLimit: "5 minutes",
            keyPoints: [
                "Summarize completed user stories",
                "Highlight technical challenges and how they were resolved",
                "Demo the working functionality",
                "Outline next sprint priorities"
            ]
        ),
        PresentationScenario(
            level: .beginner,
            title: "Technical Design Walkthrough",
            scenario: "Present a technical design for migrating the existing 5G Core UPF (User Plane Function) from VM-based deployment to cloud-native CNF on Kubernetes. Your team needs to understand the architecture decisions.",
            audience: "Engineering team (5-7 architects and senior developers)",
            timeLimit: "15 minutes",
            keyPoints: [
                "Current architecture limitations",
                "Proposed cloud-native architecture",
                "Migration strategy and timeline",
                "Risk assessment and mitigation"
            ]
        ),
        PresentationScenario(
            level: .intermediate,
            title: "5G Network Slicing Business Case",
            scenario: "Present the business case for deploying enterprise-grade 5G network slicing to the product management and business development teams. They need to understand both the technical capabilities and the revenue opportunity.",
            audience: "Product managers, business development, and finance (12-15 people)",
            timeLimit: "20 minutes",
            keyPoints: [
                "What is network slicing and why it matters",
                "Target enterprise use cases (manufacturing, healthcare, logistics)",
                "Revenue model and pricing strategy",
                "Competitive advantage and time-to-market"
            ]
        ),
        PresentationScenario(
            level: .intermediate,
            title: "Security Architecture Review",
            scenario: "Present the zero-trust security architecture for the 5G SA Core to the security review board. Address how the Service Based Architecture (SBA) is secured, including inter-NF communication, API gateway security, and subscriber privacy protection.",
            audience: "Security team, CISO, compliance officers (8-10 people)",
            timeLimit: "30 minutes",
            keyPoints: [
                "Zero-trust principles applied to 5G Core",
                "SBA interface security (OAuth 2.0, TLS 1.3)",
                "Subscriber data protection (SUPI/SUCI)",
                "Threat model and mitigation strategies"
            ]
        ),
        PresentationScenario(
            level: .advanced,
            title: "6G Vision and Strategic Roadmap",
            scenario: "Present to the CTO and executive leadership team your vision for 6G readiness. Cover how current 5G Advanced investments create a foundation for 6G, including AI-native networking, THz communication research, and digital twin network capabilities.",
            audience: "CTO, VP Engineering, VP Strategy, CFO (5-7 executives)",
            timeLimit: "20 minutes",
            keyPoints: [
                "6G industry timeline and key milestones",
                "How 5G Advanced bridges to 6G",
                "Required R&D investments and partnerships",
                "Strategic positioning vs. competitors"
            ]
        ),
        PresentationScenario(
            level: .advanced,
            title: "Board Investment Proposal: AI-Native Core",
            scenario: "Present a $50M investment proposal to the board of directors for building an AI-native core network platform. This includes NWDAF enhancement, closed-loop automation, and intent-based networking capabilities that will reduce OpEx by 40% over 3 years.",
            audience: "Board of Directors (8-10 members, mix of technical and financial)",
            timeLimit: "15 minutes",
            keyPoints: [
                "Problem statement and market opportunity",
                "Solution overview (accessible to non-technical audience)",
                "Financial model: investment, ROI, payback period",
                "Risk factors and mitigation plan"
            ]
        ),
        PresentationScenario(
            level: .expert,
            title: "MWC Keynote: 5G Advanced to 6G",
            scenario: "You are delivering a keynote at Mobile World Congress on 'Building 6G-Ready Core Networks Today.' The audience includes CTOs, analysts, researchers, and media from across the global telecom industry. Your talk should inspire, inform, and position your company as a thought leader.",
            audience: "Industry conference (500+ attendees, diverse backgrounds)",
            timeLimit: "25 minutes",
            keyPoints: [
                "Compelling opening with industry vision",
                "3GPP Release 18/19 as 6G stepping stones",
                "Live demo or case study results",
                "Bold predictions and call to action"
            ]
        ),
        PresentationScenario(
            level: .expert,
            title: "3GPP Standards Proposal",
            scenario: "Present a technical contribution to 3GPP SA2 working group proposing a new architecture for Integrated Sensing and Communication (ISAC) in the 6G Core. You must defend your proposal against alternative approaches from competing vendors while maintaining collaborative professionalism.",
            audience: "3GPP delegates from major telecom vendors and operators (30-50)",
            timeLimit: "10 minutes",
            keyPoints: [
                "Problem statement and gap in current architecture",
                "Proposed solution with reference architecture",
                "Comparison with alternative approaches",
                "Implementation feasibility and backward compatibility"
            ]
        ),
    ]

    static let tips: [(category: String, tips: [String])] = [
        ("Opening", [
            "Start with a compelling statistic or industry trend to capture attention.",
            "Open with a thought-provoking question relevant to your audience.",
            "Begin with a brief story that illustrates the problem you're solving.",
            "Use the 'What if...' technique to paint a vision of the future.",
        ]),
        ("Structure", [
            "Follow the 'Situation-Complication-Resolution' framework for business audiences.",
            "Use the 'Problem-Solution-Benefit' structure for technical proposals.",
            "Apply the 'Tell them what you'll tell them, tell them, tell them what you told them' rule.",
            "Limit to 3 key messages — audiences rarely retain more.",
        ]),
        ("Delivery", [
            "Pause after key points for 2-3 seconds to let them sink in.",
            "Use analogies to explain complex 5G/6G concepts to non-technical audiences.",
            "Make eye contact with different sections of the room every 3-5 seconds.",
            "Vary your pace — slow down for important points, speed up for context.",
        ]),
        ("Slides", [
            "Follow the 10-20-30 rule: 10 slides, 20 minutes, 30pt minimum font.",
            "One idea per slide — if you need a second bullet list, make a second slide.",
            "Use architecture diagrams instead of text for technical concepts.",
            "Include a clear 'So What?' for every data point you present.",
        ]),
        ("Closing", [
            "End with a specific, actionable call-to-action.",
            "Summarize your 3 key messages before Q&A.",
            "Close with a forward-looking statement that reinforces your vision.",
            "Prepare for the top 5 most likely questions and have concise answers ready.",
        ]),
    ]

    static func scenarios(for level: DifficultyLevel?) -> [PresentationScenario] {
        guard let level else { return scenarios }
        return scenarios.filter { $0.level == level }
    }

    static func randomScenario(level: DifficultyLevel? = nil) -> PresentationScenario {
        let filtered = scenarios(for: level)
        return filtered.randomElement() ?? scenarios[0]
    }
}
