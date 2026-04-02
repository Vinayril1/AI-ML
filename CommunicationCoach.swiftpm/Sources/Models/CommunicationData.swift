import Foundation

// MARK: - Email Exercises

struct EmailExercise: Identifiable {
    let id = UUID()
    let level: DifficultyLevel
    let title: String
    let scenario: String
    let audience: String
    let guidelines: [String]
    let goodElements: [String]
}

// MARK: - Meeting Exercises

struct MeetingExercise: Identifiable {
    let id = UUID()
    let level: DifficultyLevel
    let title: String
    let scenario: String
    let skillsPracticed: [String]
    let keyPhrases: [String]
}

// MARK: - Explanation Challenges

struct ExplanationChallenge: Identifiable {
    let id = UUID()
    let concept: String
    let explainTo: String
    let constraint: String
    let goodExample: String
}

// MARK: - Vocabulary

struct VocabTerm: Identifiable {
    let id = UUID()
    let term: String
    let description: String
    let category: String
}

// MARK: - Data

struct CommunicationExerciseData {

    static let emailExercises: [EmailExercise] = [
        EmailExercise(
            level: .beginner,
            title: "Status Update Email",
            scenario: "Write a weekly status update email to your manager about the 5G Core network migration project. The project is 70% complete, there's a risk with the SMF component testing timeline, and you need a decision on whether to proceed with vendor A or B for the UPF upgrade.",
            audience: "Direct manager (technical background)",
            guidelines: [
                "Use clear subject line with project name and status",
                "Lead with the most important information first",
                "Separate status, risks, and action items clearly",
                "Keep it under 200 words",
            ],
            goodElements: [
                "Subject: [5G Core Migration] Week 12 — 70% Complete, Decision Needed",
                "Executive summary in first 2 sentences",
                "Bulleted progress items",
                "Risk section with impact and mitigation",
                "Clear ask with deadline",
            ]
        ),
        EmailExercise(
            level: .intermediate,
            title: "Escalation Email to VP",
            scenario: "The 5G network slicing deployment for a major enterprise customer is at risk of missing the go-live date by 3 weeks due to a critical bug in the PCF. The vendor has acknowledged the bug but their fix timeline is unclear. Write an escalation email to the VP of Engineering.",
            audience: "VP Engineering (semi-technical, time-constrained)",
            guidelines: [
                "Be direct — state the problem and impact in the first sentence",
                "Quantify the business impact (revenue, SLA penalties)",
                "Present options with your recommendation",
                "Specify what you need from the VP",
            ],
            goodElements: [
                "Clear problem statement with business impact",
                "Timeline with specific dates",
                "Options: (A) Wait for fix, (B) Workaround, (C) Negotiate deadline",
                "Your recommendation with rationale",
                "Specific ask: 'I need your approval for Option B by Thursday'",
            ]
        ),
        EmailExercise(
            level: .advanced,
            title: "Executive Briefing to CTO",
            scenario: "Write an email to the CTO summarizing your evaluation of three 6G research partnership proposals. University A has the best AI/ML team, Company B has THz hardware expertise, and Consortium C offers the broadest ecosystem but largest investment. Recommend one option.",
            audience: "CTO (highly technical, decides in minutes)",
            guidelines: [
                "One-paragraph executive summary at the top",
                "Comparison table or matrix",
                "Clear recommendation with 3 supporting reasons",
                "Next steps with specific timeline",
            ],
            goodElements: [
                "Subject line that telegraphs the recommendation",
                "TL;DR in first 2 lines",
                "Structured comparison (cost, capability, timeline, risk)",
                "Bold recommendation with 'because' reasoning",
                "Attachment reference for detailed analysis",
            ]
        ),
    ]

    static let meetingExercises: [MeetingExercise] = [
        MeetingExercise(
            level: .beginner,
            title: "Stand-up Meeting Facilitation",
            scenario: "You are facilitating the daily stand-up for a 10-person core network team. Two members tend to go into long technical deep-dives. The sprint goal is at risk because of a dependency on the UDM team.",
            skillsPracticed: ["Time management", "Redirecting discussions", "Identifying blockers"],
            keyPhrases: [
                "Let's take that offline after the stand-up.",
                "Can you summarize the blocker in one sentence?",
                "Who needs to be in the follow-up discussion?",
                "What's the one thing that would unblock you today?",
            ]
        ),
        MeetingExercise(
            level: .intermediate,
            title: "Architecture Review Meeting",
            scenario: "You are chairing an architecture review for a proposed NWDAF deployment. Attendees include data science, network ops, security, and the vendor. There are disagreements about centralized vs distributed NWDAF. Lead the discussion to a decision.",
            skillsPracticed: ["Facilitating technical debates", "Building consensus", "Decision documentation"],
            keyPhrases: [
                "Let's evaluate both options against our agreed criteria.",
                "What data do we need to make this decision confidently?",
                "I'm hearing two distinct concerns — let me separate them.",
                "Can we agree on evaluation criteria before debating solutions?",
                "Let me summarize what I've heard to make sure we're aligned.",
            ]
        ),
        MeetingExercise(
            level: .advanced,
            title: "Cross-Functional Program Review",
            scenario: "You are leading a monthly program review for the 5G-to-6G evolution roadmap. Engineering wants more time for quality. Product wants faster delivery. Finance is questioning ROI. Navigate these competing priorities.",
            skillsPracticed: ["Stakeholder alignment", "Conflict resolution", "Executive communication"],
            keyPhrases: [
                "Let's start with what we all agree on — our strategic objective.",
                "I understand the tension between speed and quality — here's how I propose we balance both.",
                "It's not quality vs. speed — it's about which risks we accept.",
                "Can each team share their top constraint?",
                "Here's my recommendation, and here's the data behind it.",
            ]
        ),
    ]

    static let explanationChallenges: [ExplanationChallenge] = [
        ExplanationChallenge(
            concept: "5G Network Slicing",
            explainTo: "A non-technical CEO",
            constraint: "Use an everyday analogy. No more than 3 sentences.",
            goodExample: "Think of network slicing like a highway with dedicated lanes. Just as you might have a bus lane, a carpool lane, and regular lanes on the same road, network slicing creates dedicated 'lanes' in our network — one for video calls, another for factory robots, another for self-driving cars — all running on the same infrastructure but never interfering."
        ),
        ExplanationChallenge(
            concept: "Service Based Architecture (SBA)",
            explainTo: "A project manager from IT",
            constraint: "Relate it to something they already know, like web APIs or microservices.",
            goodExample: "SBA in 5G Core is very similar to how modern web apps are built using microservices. Instead of one monolithic system, we break the network into small, specialized services that talk via APIs — just like how Netflix has separate services for recommendations, streaming, and billing."
        ),
        ExplanationChallenge(
            concept: "Zero-Trust Security in 5G Core",
            explainTo: "The company's board of directors",
            constraint: "Focus on risk and business impact. Keep it under 4 sentences.",
            goodExample: "Traditional network security is like a castle with a moat — once inside, you're trusted. Zero-trust assumes no one is trusted, ever. Every request between every part of our 5G network must prove its identity and authorization, every time. This dramatically reduces the blast radius if any single component is compromised."
        ),
        ExplanationChallenge(
            concept: "AI-Native 6G Networks",
            explainTo: "A telecom industry journalist",
            constraint: "Be quotable. Convey both technical substance and vision.",
            goodExample: "Today we add AI on top of networks designed in the pre-AI era. 6G flips that — the network is designed from the ground up with AI as a first-class citizen. Imagine a network that doesn't just carry data but understands it, predicts failures before they happen, and optimizes itself in real-time without human intervention."
        ),
        ExplanationChallenge(
            concept: "Digital Twin Networks",
            explainTo: "A finance executive evaluating R&D investment",
            constraint: "Quantify the business value. Use concrete examples.",
            goodExample: "A digital twin is a virtual replica of our entire network. Instead of risking a network outage to test a new configuration — costing $500K per hour in SLA penalties — we test on the digital twin first. Companies using this approach report 60% fewer outages and 40% faster rollout of new services."
        ),
    ]

    static let vocabulary: [(category: String, terms: [VocabTerm])] = [
        ("Architecture", [
            VocabTerm(term: "Service Based Architecture (SBA)", description: "Cloud-native architecture in 5G Core where NFs expose services via APIs. Use when explaining 5G Core design.", category: "Architecture"),
            VocabTerm(term: "CUPS", description: "Control and User Plane Separation — decoupling signaling from data forwarding. Use when discussing scalability.", category: "Architecture"),
            VocabTerm(term: "NFV", description: "Network Function Virtualization — running NFs as software on COTS hardware. Use when discussing modernization.", category: "Architecture"),
            VocabTerm(term: "CNF", description: "Cloud-Native Network Function — microservices on container platforms. Use when discussing modern deployments.", category: "Architecture"),
        ]),
        ("5G Advanced", [
            VocabTerm(term: "Network Slicing", description: "Multiple virtual networks on shared infrastructure, each optimized for specific use cases. Use for enterprise solutions.", category: "5G Advanced"),
            VocabTerm(term: "NWDAF", description: "Network Data Analytics Function — 3GPP-defined for network analytics. Use when discussing AI/ML in the network.", category: "5G Advanced"),
            VocabTerm(term: "NTN", description: "Non-Terrestrial Networks — satellite/HAPS integration with 5G. Use when discussing coverage and 6G evolution.", category: "5G Advanced"),
            VocabTerm(term: "ISAC", description: "Integrated Sensing and Communication — using signals for radar-like sensing. Use for 6G use cases.", category: "5G Advanced"),
        ]),
        ("Business & Strategy", [
            VocabTerm(term: "TCO", description: "Total Cost of Ownership — complete cost over lifecycle. Use for business cases and vendor comparisons.", category: "Business"),
            VocabTerm(term: "CAPEX vs OPEX", description: "Capital vs. operational expenditure. Use when discussing cloud migration benefits.", category: "Business"),
            VocabTerm(term: "TTM", description: "Time-to-Market — concept to commercial availability. Use when arguing for platform investments.", category: "Business"),
            VocabTerm(term: "NPS", description: "Net Promoter Score — customer satisfaction metric. Use to link technical quality to business outcomes.", category: "Business"),
        ]),
    ]
}
