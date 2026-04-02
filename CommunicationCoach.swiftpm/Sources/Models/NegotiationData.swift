import Foundation

struct NegotiationScenario: Identifiable {
    let id = UUID()
    let level: DifficultyLevel
    let category: String
    let title: String
    let scenario: String
    let budget: String
    let leverage: String
    let mustHaves: [String]
    let niceToHaves: [String]
    let counterpart: String
    let openingMessage: String
    let tacticsToPractice: [String]
}

struct NegotiationTactic: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let example: String
    let telecomTip: String
}

struct NegotiationData {
    static let scenarios: [NegotiationScenario] = [
        NegotiationScenario(
            level: .beginner,
            category: "Vendor",
            title: "5G Core License Renewal",
            scenario: "Your company's 5G Core software license from Vendor X is up for renewal. They are proposing a 25% price increase citing 'enhanced features.' Your budget is flat year-over-year.",
            budget: "Flat budget — cannot exceed current spend",
            leverage: "Evaluated Vendor Y as alternative, 18-month migration feasible",
            mustHaves: ["24/7 support SLA", "All 3GPP R18 features", "API access"],
            niceToHaves: ["Training credits", "Early access to R19 beta", "Dedicated TAC engineer"],
            counterpart: "Vendor Account Director — motivated by annual revenue targets",
            openingMessage: "Thank you for being a valued partner. As you know, our latest release includes significant enhancements for network slicing and NWDAF analytics. Given the substantial R&D investment, we're proposing a modest 25% adjustment to your license fees.",
            tacticsToPractice: ["Anchoring", "BATNA reference", "Value-based negotiation"]
        ),
        NegotiationScenario(
            level: .intermediate,
            category: "Vendor",
            title: "Multi-Vendor RAN-Core Integration",
            scenario: "You are negotiating a $30M contract for integrating O-RAN compliant RAN with your 5G SA Core. Three vendors have bid. Vendor A has the best technology but highest price ($38M). Vendor C is $28M.",
            budget: "$30M total, Vendor A bid $38M, Vendor C bid $28M",
            leverage: "Three competitive bids, board approval needed",
            mustHaves: ["O-RAN compliance", "99.999% core availability SLA", "Penalty clauses"],
            niceToHaves: ["Joint innovation lab", "Reference customer rights", "Escrow of source code"],
            counterpart: "Vendor A's VP of Sales — wants to win but protect margins",
            openingMessage: "We appreciate the thoroughness of your proposal. Your technology is impressive and aligns with our architecture vision. However, your pricing is significantly above other qualified bids. We need to find a path that works for both sides.",
            tacticsToPractice: ["Competitive leverage", "Unbundling", "Win-win framing"]
        ),
        NegotiationScenario(
            level: .intermediate,
            category: "Enterprise",
            title: "Private 5G for Manufacturing",
            scenario: "A large automotive manufacturer wants a private 5G network for their smart factory. They need URLLC for robotic assembly lines. They're comparing your solution against Wi-Fi 6E and a competitor's LTE offering.",
            budget: "Your solution: $6.5M / 3yr. Customer budget: $5M",
            leverage: "Only true 5G URLLC solution, proven in similar deployments",
            mustHaves: ["3-year commitment", "Managed service contract", "Network slicing add-on"],
            niceToHaves: ["Reference customer agreement", "Case study rights", "Phase 2 expansion"],
            counterpart: "Customer's Head of Digital Transformation — reports to CEO, cost-conscious",
            openingMessage: "Your 5G solution is technically compelling, but at $6.5M it's 30% above our budget. Our Wi-Fi 6E vendor is offering a complete solution for $3.8M. Help me understand why I should pay the premium for 5G.",
            tacticsToPractice: ["Value selling", "TCO analysis", "Risk-based negotiation"]
        ),
        NegotiationScenario(
            level: .advanced,
            category: "Internal",
            title: "Resource Allocation for 6G Research",
            scenario: "You need to convince the VP of Engineering to allocate 15 engineers from the 5G Core maintenance team to a new 6G research initiative. The VP is concerned about 5G service quality and customer commitments.",
            budget: "No additional headcount budget this fiscal year",
            leverage: "CTO supports 6G initiative, competitors already investing",
            mustHaves: ["8 engineers minimum by Q2", "Dedicated 6G lab resources", "Budget for 3GPP participation"],
            niceToHaves: ["15 engineers by Q4", "University partnerships", "Conference speaking slots"],
            counterpart: "VP Engineering — protective of team, focused on current deliverables",
            openingMessage: "I understand you want to start a 6G research track, and I support the vision long-term. But right now we have three major 5G customers in deployment phase and two critical patches pending. I can't afford to lose anyone. What exactly are you proposing?",
            tacticsToPractice: ["Stakeholder alignment", "Phased approach", "Mutual gains"]
        ),
        NegotiationScenario(
            level: .expert,
            category: "Partnership",
            title: "6G Research Consortium Formation",
            scenario: "You are representing your company in negotiations to form a 6G research consortium with two competing vendors, a major university, and a government research agency. Key issues: IP ownership, publication rights, funding, and governance.",
            budget: "$10M annual contribution proposed",
            leverage: "Strongest 5G Core portfolio, key patents in AI-native networking",
            mustHaves: ["Joint IP for consortium work", "Right to commercialize independently", "Board seat"],
            niceToHaves: ["Hosting the consortium lab", "Leading core network workstream", "First right of refusal on patents"],
            counterpart: "Multi-party — each with different priorities and constraints",
            openingMessage: "Welcome everyone. We're here to define the structure of what could be the most impactful 6G research collaboration in the industry. Each of us brings unique strengths. Let's start with governance — who has a proposal?",
            tacticsToPractice: ["Multi-party negotiation", "Coalition building", "Framework negotiation"]
        ),
    ]

    static let tactics: [NegotiationTactic] = [
        NegotiationTactic(
            name: "BATNA",
            description: "Best Alternative to Negotiated Agreement. Know your walkaway option — a strong BATNA gives you confidence and leverage.",
            example: "Before negotiating the license renewal, evaluate Vendor Y's offering in detail. If it covers 80% of your needs at 60% of the cost, that's a strong BATNA.",
            telecomTip: "In telecom, switching costs are high but not infinite. Quantify the migration cost to your BATNA — it defines your negotiation range."
        ),
        NegotiationTactic(
            name: "Anchoring",
            description: "The first number mentioned sets the psychological anchor. Make the first offer when you have good information about fair value.",
            example: "Instead of waiting for the vendor, open with: 'Based on our market analysis, fair value for this solution is $X.'",
            telecomTip: "Use publicly available analyst reports (Gartner, Analysys Mason) to establish credible anchors for technology pricing."
        ),
        NegotiationTactic(
            name: "Unbundling",
            description: "Break a complex deal into components. Negotiate each element separately to identify where flexibility exists.",
            example: "Split the proposal into: license fees, support costs, professional services, training, and upgrade rights. Negotiate each independently.",
            telecomTip: "Telecom contracts often bundle hardware, software, support, and services. Unbundling reveals where margins are highest."
        ),
        NegotiationTactic(
            name: "Value Framing",
            description: "Shift the conversation from cost to value. Frame your proposal in terms of business outcomes, ROI, and risk reduction.",
            example: "Instead of 'Our solution costs $6.5M,' say 'Our solution delivers 99.999% reliability, preventing $2M/year in production downtime.'",
            telecomTip: "For 5G/6G, frame value as: revenue per subscriber, network efficiency gains, time-to-market, and OpEx reduction."
        ),
        NegotiationTactic(
            name: "Mutual Gains",
            description: "Look for ways to expand the pie before dividing it. Identify interests (not just positions) to find creative solutions.",
            example: "If the vendor can't reduce price, negotiate for: extended payment terms, training, joint marketing, or early access to new features.",
            telecomTip: "In telecom partnerships, mutual gains often come from: joint go-to-market, reference customer arrangements, or shared innovation labs."
        ),
    ]

    static func scenarios(for level: DifficultyLevel?) -> [NegotiationScenario] {
        guard let level else { return scenarios }
        return scenarios.filter { $0.level == level }
    }

    static func randomScenario(level: DifficultyLevel? = nil) -> NegotiationScenario {
        let filtered = scenarios(for: level)
        return filtered.randomElement() ?? scenarios[0]
    }
}
