"""Negotiation Skills Simulator with telecom vendor and enterprise scenarios."""

import random

NEGOTIATION_SCENARIOS = [
    # Vendor negotiations
    {
        "level": 1,
        "category": "vendor",
        "title": "5G Core License Renewal",
        "scenario": (
            "Your company's 5G Core software license from Vendor X is up for renewal. "
            "They are proposing a 25% price increase citing 'enhanced features' in their "
            "latest release. Your budget is flat year-over-year. You need to negotiate "
            "a favorable renewal while maintaining the vendor relationship."
        ),
        "your_position": {
            "budget": "Flat budget — cannot exceed current spend",
            "leverage": "Evaluated Vendor Y as an alternative, 18-month migration feasible",
            "must_haves": ["24/7 support SLA", "All 3GPP R18 features", "API access"],
            "nice_to_haves": ["Training credits", "Early access to R19 beta", "Dedicated TAC engineer"],
        },
        "counterpart": "Vendor Account Director — motivated by annual revenue targets",
        "opening_message": (
            "Thank you for being a valued partner. As you know, our latest release "
            "includes significant enhancements for network slicing and NWDAF analytics. "
            "Given the substantial R&D investment, we're proposing a modest 25% adjustment "
            "to your license fees. I believe this reflects the tremendous value we deliver."
        ),
        "tactics_to_practice": ["Anchoring", "BATNA reference", "Value-based negotiation"],
    },
    {
        "level": 2,
        "category": "vendor",
        "title": "Multi-Vendor RAN-Core Integration Contract",
        "scenario": (
            "You are negotiating a $30M contract for integrating O-RAN compliant RAN "
            "with your 5G SA Core. Three vendors have bid. Vendor A has the best technology "
            "but highest price. Vendor B is cheapest but has integration risks. Vendor C "
            "is middle-ground. You need to negotiate with Vendor A to bring their price "
            "closer to Vendor C while securing performance guarantees."
        ),
        "your_position": {
            "budget": "$30M total, Vendor A bid $38M, Vendor C bid $28M",
            "leverage": "Three competitive bids, board approval needed",
            "must_haves": ["O-RAN compliance", "99.999% core availability SLA", "Penalty clauses"],
            "nice_to_haves": ["Joint innovation lab", "Reference customer rights", "Escrow of source code"],
        },
        "counterpart": "Vendor A's VP of Sales — wants to win the deal but protect margins",
        "opening_message": (
            "We appreciate the thoroughness of your proposal. Your technology is impressive "
            "and aligns well with our architecture vision. However, I need to be transparent — "
            "your pricing is significantly above the other qualified bids we've received. "
            "We need to find a path that works for both sides. What flexibility do you have?"
        ),
        "tactics_to_practice": ["Competitive leverage", "Unbundling", "Win-win framing"],
    },
    # Enterprise customer negotiations
    {
        "level": 2,
        "category": "enterprise",
        "title": "Private 5G Network Deal for Manufacturing",
        "scenario": (
            "A large automotive manufacturer wants a private 5G network for their smart "
            "factory. They need ultra-reliable low-latency communication (URLLC) for "
            "robotic assembly lines. They're comparing your solution against Wi-Fi 6E "
            "and a competitor's LTE-based offering. Budget is $5M for 3 years."
        ),
        "your_position": {
            "budget": "Your solution costs $6.5M over 3 years",
            "leverage": "Only true 5G URLLC solution, proven in similar deployments",
            "must_haves": ["3-year commitment", "Managed service contract", "Network slicing add-on"],
            "nice_to_haves": ["Reference customer agreement", "Case study rights", "Phase 2 expansion"],
        },
        "counterpart": "Customer's Head of Digital Transformation — reports to CEO, cost-conscious",
        "opening_message": (
            "We've been evaluating several connectivity options for our smart factory. "
            "Your 5G solution is technically compelling, but at $6.5M it's 30% above our "
            "budget. Our Wi-Fi 6E vendor is offering a complete solution for $3.8M. "
            "Help me understand why I should pay the premium for 5G."
        ),
        "tactics_to_practice": ["Value selling", "TCO analysis", "Risk-based negotiation"],
    },
    # Internal negotiations
    {
        "level": 3,
        "category": "internal",
        "title": "Resource Allocation for 6G Research",
        "scenario": (
            "You need to convince the VP of Engineering to allocate 15 engineers from "
            "the 5G Core maintenance team to a new 6G research initiative. The VP is "
            "concerned about 5G service quality and customer commitments. You need to "
            "negotiate a phased transition plan."
        ),
        "your_position": {
            "budget": "No additional headcount budget this fiscal year",
            "leverage": "CTO supports 6G initiative, competitors already investing",
            "must_haves": ["8 engineers minimum by Q2", "Dedicated 6G lab resources", "Budget for 3GPP participation"],
            "nice_to_haves": ["15 engineers by Q4", "University research partnerships", "Conference speaking slots"],
        },
        "counterpart": "VP Engineering — protective of team, focused on current deliverables",
        "opening_message": (
            "I understand you want to start a 6G research track, and I support the "
            "vision long-term. But right now we have three major 5G customers in "
            "deployment phase and two critical patches pending. I can't afford to lose "
            "anyone from the team. What exactly are you proposing?"
        ),
        "tactics_to_practice": ["Stakeholder alignment", "Phased approach", "Mutual gains"],
    },
    # Standards and partnership negotiations
    {
        "level": 4,
        "category": "partnership",
        "title": "6G Research Consortium Formation",
        "scenario": (
            "You are representing your company in negotiations to form a 6G research "
            "consortium with two competing vendors, a major university, and a government "
            "research agency. Key issues include IP ownership, publication rights, "
            "funding contributions, and governance structure."
        ),
        "your_position": {
            "budget": "$10M annual contribution proposed",
            "leverage": "Strongest 5G Core portfolio, key patents in AI-native networking",
            "must_haves": ["Joint IP for consortium work", "Right to commercialize independently", "Board seat"],
            "nice_to_haves": ["Hosting the consortium lab", "Leading the core network workstream", "First right of refusal on patents"],
        },
        "counterpart": "Multi-party — each with different priorities and constraints",
        "opening_message": (
            "Welcome everyone. We're here to define the structure of what could be "
            "the most impactful 6G research collaboration in the industry. Each of us "
            "brings unique strengths. The challenge is creating a framework that "
            "incentivizes open collaboration while protecting our individual interests. "
            "Let's start with governance — who has a proposal?"
        ),
        "tactics_to_practice": ["Multi-party negotiation", "Coalition building", "Framework negotiation"],
    },
]

NEGOTIATION_TACTICS = {
    "BATNA": {
        "name": "Best Alternative to Negotiated Agreement",
        "description": (
            "Know your walkaway option. If this deal fails, what's your next best "
            "alternative? A strong BATNA gives you confidence and leverage."
        ),
        "example": (
            "Before negotiating the license renewal, evaluate Vendor Y's offering "
            "in detail. If their solution covers 80% of your needs at 60% of the cost, "
            "that's a strong BATNA to reference."
        ),
        "telecom_tip": (
            "In telecom, switching costs are high but not infinite. Quantify the "
            "migration cost to your BATNA — it defines your negotiation range."
        ),
    },
    "Anchoring": {
        "name": "Setting the Anchor",
        "description": (
            "The first number mentioned in a negotiation sets the psychological anchor. "
            "Make the first offer when you have good information about fair value."
        ),
        "example": (
            "Instead of waiting for the vendor to propose pricing, open with: "
            "'Based on our market analysis, fair value for this solution is $X.'"
        ),
        "telecom_tip": (
            "Use publicly available analyst reports (Gartner, Analysys Mason) to "
            "establish credible anchors for technology pricing."
        ),
    },
    "Unbundling": {
        "name": "Unbundling the Package",
        "description": (
            "Break a complex deal into components. Negotiate each element separately "
            "to identify where flexibility exists."
        ),
        "example": (
            "Split the vendor proposal into: license fees, support costs, professional "
            "services, training, and future upgrade rights. Negotiate each independently."
        ),
        "telecom_tip": (
            "Telecom contracts often bundle hardware, software, support, and services. "
            "Unbundling reveals where margins are highest and flexibility exists."
        ),
    },
    "Value Framing": {
        "name": "Reframing Around Value",
        "description": (
            "Shift the conversation from cost to value. Frame your proposal in terms "
            "of business outcomes, ROI, and risk reduction."
        ),
        "example": (
            "Instead of 'Our solution costs $6.5M,' say 'Our solution delivers "
            "99.999% reliability, preventing $2M/year in production downtime.'"
        ),
        "telecom_tip": (
            "For 5G/6G solutions, frame value in terms of: revenue per subscriber, "
            "network efficiency gains, time-to-market for new services, and OpEx reduction."
        ),
    },
    "Mutual Gains": {
        "name": "Creating Mutual Gains",
        "description": (
            "Look for ways to expand the pie before dividing it. Identify interests "
            "(not just positions) to find creative solutions that benefit both sides."
        ),
        "example": (
            "If the vendor can't reduce price, negotiate for: extended payment terms, "
            "additional training, joint marketing, or early access to new features."
        ),
        "telecom_tip": (
            "In telecom partnerships, mutual gains often come from: joint go-to-market "
            "agreements, reference customer arrangements, or shared innovation labs."
        ),
    },
}

RESPONSE_FRAMEWORKS = {
    "vendor_pushback": [
        "Acknowledge their position, then redirect to your priorities.",
        "Use data and benchmarks to support your counter-proposal.",
        "Propose alternatives: 'If not X, then how about Y?'",
        "Reference your BATNA without making it a threat.",
    ],
    "price_objection": [
        "Reframe from price to total cost of ownership (TCO).",
        "Break down the value delivered per dollar spent.",
        "Offer a phased approach to spread the investment.",
        "Tie pricing to performance guarantees and SLAs.",
    ],
    "deadline_pressure": [
        "Don't let artificial urgency force a bad decision.",
        "Ask: 'What specifically changes if we take another week?'",
        "Propose a letter of intent to show commitment while finalizing terms.",
        "Separate the timeline from the terms — agree on principles first.",
    ],
    "scope_creep": [
        "Document agreed scope explicitly before discussing additions.",
        "For each addition, ask: 'What are we removing to accommodate this?'",
        "Use a change request process with clear cost implications.",
        "Prioritize: must-have vs. nice-to-have for both sides.",
    ],
}


def get_scenario(level: int | None = None, category: str | None = None) -> dict:
    """Get a negotiation scenario, optionally filtered."""
    scenarios = NEGOTIATION_SCENARIOS
    if level:
        scenarios = [s for s in scenarios if s["level"] == level]
    if category:
        scenarios = [s for s in scenarios if s["category"] == category]
    if not scenarios:
        scenarios = NEGOTIATION_SCENARIOS
    return random.choice(scenarios)


def get_all_scenarios() -> list[dict]:
    """Return all negotiation scenarios."""
    return NEGOTIATION_SCENARIOS


def get_tactic(name: str | None = None) -> dict:
    """Get negotiation tactic details."""
    if name and name in NEGOTIATION_TACTICS:
        return {name: NEGOTIATION_TACTICS[name]}
    return NEGOTIATION_TACTICS


def get_response_framework(situation: str | None = None) -> dict:
    """Get response frameworks for common negotiation situations."""
    if situation and situation in RESPONSE_FRAMEWORKS:
        return {situation: RESPONSE_FRAMEWORKS[situation]}
    return RESPONSE_FRAMEWORKS


def evaluate_negotiation_response(text: str) -> dict:
    """Evaluate a negotiation response for key qualities."""
    text_lower = text.lower()

    # Check for assertiveness vs aggressiveness
    assertive_phrases = [
        "i propose", "we need", "our requirement is", "i recommend",
        "the fair value is", "based on our analysis", "we expect",
        "our position is", "let me suggest", "here is what works for us",
    ]
    aggressive_phrases = [
        "you must", "take it or leave it", "non-negotiable",
        "we won't accept", "that's unacceptable", "absolutely not",
    ]
    collaborative_phrases = [
        "how can we", "what if we", "i understand your", "let's explore",
        "mutual benefit", "win-win", "together", "partnership",
        "i appreciate", "fair to both", "common ground",
    ]

    assertive_count = sum(1 for p in assertive_phrases if p in text_lower)
    aggressive_count = sum(1 for p in aggressive_phrases if p in text_lower)
    collaborative_count = sum(1 for p in collaborative_phrases if p in text_lower)

    # Check for data/evidence usage
    has_data = any(
        indicator in text_lower
        for indicator in ["percent", "%", "data shows", "analysis", "benchmark",
                          "report", "study", "evidence", "roi", "tco", "cost"]
    )

    # Check for BATNA reference
    has_batna = any(
        indicator in text_lower
        for indicator in ["alternative", "other option", "other vendor",
                          "competitor", "other bid", "evaluated"]
    )

    # Tone assessment
    if aggressive_count > assertive_count:
        tone = "Too Aggressive — risk damaging the relationship"
    elif assertive_count == 0 and collaborative_count == 0:
        tone = "Too Passive — risk being taken advantage of"
    elif collaborative_count > 0 and assertive_count > 0:
        tone = "Balanced — assertive yet collaborative (ideal)"
    elif collaborative_count > assertive_count:
        tone = "Collaborative — good for relationship, ensure your interests are met"
    else:
        tone = "Assertive — strong position, consider adding collaborative elements"

    feedback = []
    if not has_data:
        feedback.append("Strengthen your position with specific data, benchmarks, or ROI figures.")
    if aggressive_count > 0:
        feedback.append("Soften aggressive language — replace ultimatums with firm-but-fair proposals.")
    if collaborative_count == 0:
        feedback.append("Add collaborative language to build trust while maintaining your position.")
    if not has_batna:
        feedback.append("Consider referencing your alternatives to strengthen your negotiating position.")
    if assertive_count == 0:
        feedback.append("Be more assertive — clearly state your requirements and expectations.")

    score = 50
    score += assertive_count * 8
    score += collaborative_count * 7
    score -= aggressive_count * 10
    score += 15 if has_data else 0
    score += 10 if has_batna else 0
    score = max(0, min(100, score))

    return {
        "score": score,
        "tone": tone,
        "assertive_count": assertive_count,
        "collaborative_count": collaborative_count,
        "aggressive_count": aggressive_count,
        "has_data": has_data,
        "has_batna": has_batna,
        "feedback": feedback,
    }
