import Foundation

struct LeadershipScenario: Identifiable {
    let id = UUID()
    let level: DifficultyLevel
    let category: String
    let title: String
    let scenario: String
    let keyConsiderations: [String]
    let leadershipSkill: String
    let framework: String
}

struct LeadershipFramework: Identifiable {
    let id = UUID()
    let name: String
    let fullName: String
    let description: String
    let steps: [String]
    let whenToUse: String
}

struct LeadershipQuote: Identifiable {
    let id = UUID()
    let text: String
    let author: String
}

struct LeadershipData {
    static let scenarios: [LeadershipScenario] = [
        LeadershipScenario(
            level: .beginner,
            category: "Decision Making",
            title: "Build vs Buy Decision",
            scenario: "Your team needs a network monitoring platform for the 5G Core. Option A: Build in-house using open-source (Prometheus, Grafana) — 6 months, 4 engineers. Option B: Buy commercial — $2M/year, 3-month deployment. Your team is already stretched thin.",
            keyConsiderations: [
                "Total cost of ownership over 3 years",
                "Opportunity cost of engineer time",
                "Customization needs for telecom-specific metrics",
                "Long-term maintainability and vendor lock-in",
                "Time to value given current project pressures",
            ],
            leadershipSkill: "Data-driven decision making under uncertainty",
            framework: "Decision Matrix"
        ),
        LeadershipScenario(
            level: .intermediate,
            category: "Decision Making",
            title: "Container Platform Selection",
            scenario: "Standardize on a container platform for all 5G Core CNFs. Options: (A) Red Hat OpenShift — enterprise support, expensive. (B) Vanilla Kubernetes — flexible, needs expertise. (C) Vendor-specific platform — integrated but lock-in. Affects 200+ engineers and $100M+ in infrastructure.",
            keyConsiderations: [
                "Impact on all engineering teams",
                "Vendor lock-in vs operational simplicity",
                "Talent availability in the market",
                "5G-specific requirements (real-time, DPDK, SR-IOV)",
                "Migration cost from current setup",
            ],
            leadershipSkill: "Strategic thinking and stakeholder alignment",
            framework: "Wardley Mapping"
        ),
        LeadershipScenario(
            level: .intermediate,
            category: "Team Management",
            title: "Managing Underperformance",
            scenario: "Your senior 5G Core architect (10 years experience, deep AMF/SMF expertise) has been underperforming. Deliverables are late, code review quality dropped, and juniors complain about lack of mentoring. You suspect burnout. How do you handle this?",
            keyConsiderations: [
                "Private, empathetic conversation first",
                "Separate performance feedback from personal support",
                "Understand root causes before prescribing solutions",
                "Balance team needs with individual support",
                "Document conversation and agreed action plan",
            ],
            leadershipSkill: "Empathetic leadership and difficult conversations",
            framework: "SBI Model"
        ),
        LeadershipScenario(
            level: .advanced,
            category: "Team Management",
            title: "Restructuring the Core Network Team",
            scenario: "The CTO wants you to restructure your 45-person organization from technology-based teams (AMF, SMF, UPF) to cross-functional squads aligned to customer segments (enterprise, consumer, IoT). This will break up established teams.",
            keyConsiderations: [
                "Change management — people resist reorganizations",
                "Knowledge transfer during transition",
                "Maintaining delivery velocity during change",
                "Identifying and addressing individual concerns",
                "Measuring success of the new structure",
            ],
            leadershipSkill: "Organizational design and change management",
            framework: "Kotter's 8-Step Model"
        ),
        LeadershipScenario(
            level: .intermediate,
            category: "Stakeholder Management",
            title: "Conflicting VP Priorities",
            scenario: "VP of Product wants a new network slicing feature for a deal closing in 6 weeks. VP of Operations wants critical stability fixes after two outages. You can't fully deliver both. Navigate this.",
            keyConsiderations: [
                "Business impact of each request",
                "Don't choose sides — find a path for both",
                "Escalate with a recommendation, not just the problem",
                "Be transparent about trade-offs",
                "Creative solutions (contractors, reduced scope, phased delivery)",
            ],
            leadershipSkill: "Managing up and lateral influence",
            framework: "Stakeholder Mapping + Impact/Effort Matrix"
        ),
        LeadershipScenario(
            level: .advanced,
            category: "Stakeholder Management",
            title: "Board Presentation After Major Outage",
            scenario: "A critical 5G Core outage affected 2 million subscribers for 4 hours. Root cause: misconfigured PCF policy during routine update. The board wants answers. The media has picked up the story.",
            keyConsiderations: [
                "Take accountability without blame-shifting",
                "Be transparent about what went wrong",
                "Demonstrate competence through remediation plan",
                "Address customer and regulatory impact",
                "Rebuild confidence with concrete commitments",
            ],
            leadershipSkill: "Crisis communication and accountability",
            framework: "STAR-AR"
        ),
        LeadershipScenario(
            level: .advanced,
            category: "Strategic Thinking",
            title: "5G Monetization Strategy",
            scenario: "Despite $500M in 5G infrastructure investment, subscriber ARPU hasn't increased. The CEO questions the ROI. Prepare a strategic proposal for 5G monetization covering enterprise services, network APIs, edge computing, and new business models.",
            keyConsiderations: [
                "Why consumer 5G alone doesn't drive ARPU",
                "Enterprise B2B opportunities (private networks, slicing)",
                "API economy — exposing network capabilities to developers",
                "Partnership models with cloud providers and verticals",
                "Phased approach with quick wins and long-term plays",
            ],
            leadershipSkill: "Strategic vision and business acumen",
            framework: "Business Model Canvas"
        ),
        LeadershipScenario(
            level: .expert,
            category: "Strategic Thinking",
            title: "6G Positioning Strategy",
            scenario: "The CEO asks you to define the company's 6G strategy for 5 years. Which technologies to invest in? Build vs partner? How to participate in standards? What's the talent strategy? How to fund it without impacting 5G profitability?",
            keyConsiderations: [
                "Technology bets: AI-native, THz, RIS, NTN, ISAC",
                "Standards participation strategy (lead vs follow)",
                "Talent acquisition and upskilling plan",
                "Funding model (internal, grants, consortium)",
                "Competitive intelligence and differentiation",
            ],
            leadershipSkill: "Long-term strategic planning and vision",
            framework: "Horizon Planning (H1/H2/H3)"
        ),
    ]

    static let frameworks: [LeadershipFramework] = [
        LeadershipFramework(
            name: "SBI",
            fullName: "Situation-Behavior-Impact",
            description: "A framework for giving clear, specific feedback.",
            steps: [
                "Situation: Describe the specific context",
                "Behavior: State the observable behavior",
                "Impact: Explain the effect on the team/project",
            ],
            whenToUse: "Performance feedback, coaching, conflict resolution"
        ),
        LeadershipFramework(
            name: "RAPID",
            fullName: "RAPID Decision Framework",
            description: "Clarifies decision-making roles to avoid gridlock.",
            steps: [
                "Recommend: Who proposes the decision?",
                "Agree: Who must agree (veto power)?",
                "Perform: Who implements?",
                "Input: Who provides expertise?",
                "Decide: Who makes the final call?",
            ],
            whenToUse: "Complex decisions with multiple stakeholders"
        ),
        LeadershipFramework(
            name: "STAR",
            fullName: "Situation-Task-Action-Result",
            description: "Structure for communicating accomplishments.",
            steps: [
                "Situation: Set the context and background",
                "Task: Your specific responsibility",
                "Action: Steps you took",
                "Result: Outcome with metrics",
            ],
            whenToUse: "Interviews, performance reviews, stakeholder updates"
        ),
        LeadershipFramework(
            name: "Kotter",
            fullName: "Kotter's 8-Step Change Model",
            description: "Framework for leading organizational change.",
            steps: [
                "1. Create urgency — Why change now?",
                "2. Form a guiding coalition",
                "3. Develop a vision and strategy",
                "4. Communicate the vision",
                "5. Empower broad-based action",
                "6. Generate short-term wins",
                "7. Consolidate gains",
                "8. Anchor in culture",
            ],
            whenToUse: "Restructuring, process changes, migrations"
        ),
        LeadershipFramework(
            name: "Eisenhower",
            fullName: "Eisenhower Priority Matrix",
            description: "Prioritize tasks by urgency and importance.",
            steps: [
                "Urgent + Important → Do immediately",
                "Important + Not Urgent → Schedule it",
                "Urgent + Not Important → Delegate",
                "Not Urgent + Not Important → Eliminate",
            ],
            whenToUse: "Daily/weekly prioritization, overload situations"
        ),
    ]

    static let quotes: [LeadershipQuote] = [
        LeadershipQuote(text: "The art of communication is the language of leadership.", author: "James Humes"),
        LeadershipQuote(text: "Before you are a leader, success is about growing yourself. When you become a leader, success is about growing others.", author: "Jack Welch"),
        LeadershipQuote(text: "The most important thing in communication is hearing what isn't said.", author: "Peter Drucker"),
        LeadershipQuote(text: "A leader is one who knows the way, goes the way, and shows the way.", author: "John C. Maxwell"),
        LeadershipQuote(text: "Innovation distinguishes between a leader and a follower.", author: "Steve Jobs"),
        LeadershipQuote(text: "The single biggest problem in communication is the illusion that it has taken place.", author: "George Bernard Shaw"),
        LeadershipQuote(text: "Leadership is not about being in charge. It is about taking care of those in your charge.", author: "Simon Sinek"),
        LeadershipQuote(text: "Management is doing things right; leadership is doing the right things.", author: "Peter Drucker"),
    ]

    static func randomQuote() -> LeadershipQuote {
        quotes.randomElement() ?? quotes[0]
    }

    static func scenarios(for level: DifficultyLevel?) -> [LeadershipScenario] {
        guard let level else { return scenarios }
        return scenarios.filter { $0.level == level }
    }

    static func randomScenario(level: DifficultyLevel? = nil) -> LeadershipScenario {
        let filtered = scenarios(for: level)
        return filtered.randomElement() ?? scenarios[0]
    }
}
