"""Leadership coaching exercises for technical leaders in telecom."""

import random

LEADERSHIP_SCENARIOS = [
    # Decision Making
    {
        "level": 1,
        "category": "decision_making",
        "title": "Build vs Buy Decision",
        "scenario": (
            "Your team needs a network monitoring and observability platform for the "
            "5G Core. Option A: Build in-house using open-source tools (Prometheus, "
            "Grafana, custom collectors) — estimated 6 months, 4 engineers. Option B: "
            "Buy a commercial solution from a vendor — $2M/year, 3-month deployment. "
            "Your team is already stretched thin on 5G SA deployment. Make your decision "
            "and explain your reasoning."
        ),
        "key_considerations": [
            "Total cost of ownership over 3 years",
            "Opportunity cost of engineer time",
            "Customization needs for telecom-specific metrics",
            "Long-term maintainability and vendor lock-in",
            "Time to value given current project pressures",
        ],
        "leadership_skill": "Data-driven decision making under uncertainty",
        "framework": "Decision Matrix — weigh criteria, score options, choose transparently",
    },
    {
        "level": 2,
        "category": "decision_making",
        "title": "Technology Bet: Container Platform Selection",
        "scenario": (
            "The company needs to standardize on a container orchestration platform for "
            "all 5G Core CNFs. Three options: (A) Red Hat OpenShift — enterprise support, "
            "expensive, (B) Vanilla Kubernetes with custom tooling — flexible, needs expertise, "
            "(C) Vendor-specific platform from your 5G core vendor — integrated but lock-in. "
            "This decision affects 200+ engineers and $100M+ in infrastructure. Present your "
            "recommendation to the architecture board."
        ),
        "key_considerations": [
            "Impact on all engineering teams",
            "Vendor lock-in vs. operational simplicity",
            "Talent availability in the market",
            "5G-specific requirements (real-time, DPDK, SR-IOV)",
            "Migration cost from current setup",
        ],
        "leadership_skill": "Strategic thinking and stakeholder alignment",
        "framework": "Wardley Mapping — understand evolution stage of each option",
    },
    # Team Management
    {
        "level": 2,
        "category": "team_management",
        "title": "Managing Underperformance in a Senior Engineer",
        "scenario": (
            "Your senior 5G Core architect (10 years experience, deep AMF/SMF expertise) "
            "has been underperforming for the past quarter. Deliverables are late, code "
            "review quality has dropped, and two junior engineers have complained about "
            "lack of mentoring. You suspect burnout but haven't confirmed. How do you "
            "handle this situation?"
        ),
        "key_considerations": [
            "Having a private, empathetic conversation first",
            "Separating performance feedback from personal support",
            "Understanding root causes before prescribing solutions",
            "Balancing team needs with individual support",
            "Documenting the conversation and agreed action plan",
        ],
        "leadership_skill": "Empathetic leadership and difficult conversations",
        "framework": "SBI Model — Situation, Behavior, Impact",
    },
    {
        "level": 3,
        "category": "team_management",
        "title": "Restructuring the Core Network Team",
        "scenario": (
            "The CTO wants you to restructure your 45-person core network engineering "
            "organization. Currently organized by technology (AMF team, SMF team, UPF team). "
            "Proposal is to move to cross-functional squads aligned to customer segments "
            "(enterprise, consumer, IoT). This will break up established teams and require "
            "people to learn new areas. Design the restructuring plan and communication approach."
        ),
        "key_considerations": [
            "Change management — people resist reorganizations",
            "Knowledge transfer during transition",
            "Maintaining delivery velocity during the change",
            "Identifying and addressing individual concerns",
            "Measuring success of the new structure",
        ],
        "leadership_skill": "Organizational design and change management",
        "framework": "Kotter's 8-Step Change Model",
    },
    # Stakeholder Management
    {
        "level": 2,
        "category": "stakeholder_management",
        "title": "Conflicting Priorities from Two VPs",
        "scenario": (
            "The VP of Product wants your team to prioritize a new network slicing feature "
            "for a major enterprise deal closing in 6 weeks. The VP of Operations wants "
            "your team to fix critical stability issues that caused two outages last month. "
            "You can't fully deliver both with your current team. How do you navigate this?"
        ),
        "key_considerations": [
            "Understanding the business impact of each request",
            "Not choosing sides — finding a path that addresses both",
            "Escalating with a recommendation, not just the problem",
            "Being transparent about trade-offs",
            "Proposing creative solutions (temporary contractors, reduced scope, phased delivery)",
        ],
        "leadership_skill": "Managing up and lateral influence",
        "framework": "Stakeholder Mapping + Impact/Effort Matrix",
    },
    {
        "level": 3,
        "category": "stakeholder_management",
        "title": "Board Presentation After a Major Outage",
        "scenario": (
            "A critical 5G Core outage affected 2 million subscribers for 4 hours. "
            "Root cause: a misconfigured network policy in the PCF during a routine update. "
            "The board wants answers. Prepare your presentation covering what happened, why, "
            "and what you're doing to prevent recurrence. The media has picked up the story."
        ),
        "key_considerations": [
            "Taking accountability without blame-shifting",
            "Being transparent about what went wrong",
            "Demonstrating competence through your remediation plan",
            "Addressing customer and regulatory impact",
            "Rebuilding confidence with concrete commitments",
        ],
        "leadership_skill": "Crisis communication and accountability",
        "framework": "STAR-AR — Situation, Task, Action, Result, Action taken, Result expected",
    },
    # Strategic Thinking
    {
        "level": 3,
        "category": "strategic_thinking",
        "title": "5G Monetization Strategy",
        "scenario": (
            "Despite investing $500M in 5G infrastructure, subscriber ARPU hasn't increased. "
            "The CEO is questioning the ROI of 5G. As the solution architect, prepare a "
            "strategic proposal for 5G monetization. Consider enterprise services, network "
            "APIs (NEF/CAPIF), edge computing, and new business models."
        ),
        "key_considerations": [
            "Understanding why consumer 5G alone doesn't drive ARPU",
            "Enterprise B2B opportunities (private networks, slicing)",
            "API economy — exposing network capabilities to developers",
            "Partnership models with cloud providers and verticals",
            "Phased approach with quick wins and long-term plays",
        ],
        "leadership_skill": "Strategic vision and business acumen",
        "framework": "Business Model Canvas + Blue Ocean Strategy",
    },
    {
        "level": 4,
        "category": "strategic_thinking",
        "title": "6G Positioning Strategy",
        "scenario": (
            "The CEO asks you to define the company's 6G strategy for the next 5 years. "
            "Key questions: Which 6G technologies to invest in? Build vs. partner? "
            "How to participate in standards (3GPP, ITU)? What's the talent strategy? "
            "How to fund it without impacting current 5G profitability? Present your "
            "strategic framework."
        ),
        "key_considerations": [
            "Technology bets: AI-native, THz, RIS, NTN, ISAC",
            "Standards participation strategy (lead vs. follow)",
            "Talent acquisition and upskilling plan",
            "Funding model (internal, government grants, consortium)",
            "Competitive intelligence and differentiation",
        ],
        "leadership_skill": "Long-term strategic planning and vision",
        "framework": "Horizon Planning (H1: current, H2: emerging, H3: future)",
    },
]

LEADERSHIP_FRAMEWORKS = {
    "SBI": {
        "name": "Situation-Behavior-Impact",
        "description": "A framework for giving clear, specific feedback.",
        "steps": [
            "Situation: Describe the specific context ('In last Tuesday's architecture review...')",
            "Behavior: State the observable behavior ('...you interrupted the junior engineer three times...')",
            "Impact: Explain the effect ('...which made them hesitant to share ideas for the rest of the meeting.')",
        ],
        "when_to_use": "Performance feedback, coaching conversations, conflict resolution",
    },
    "RAPID": {
        "name": "RAPID Decision Framework",
        "description": "Clarifies decision-making roles to avoid gridlock.",
        "steps": [
            "Recommend: Who proposes the decision? (Usually the architect/lead)",
            "Agree: Who must agree? (Stakeholders with veto power)",
            "Perform: Who implements? (Engineering team)",
            "Input: Who provides input? (Subject matter experts)",
            "Decide: Who makes the final call? (Single decision-maker)",
        ],
        "when_to_use": "Complex decisions involving multiple stakeholders",
    },
    "STAR": {
        "name": "Situation-Task-Action-Result",
        "description": "Structure for communicating accomplishments and experiences.",
        "steps": [
            "Situation: Set the context and background",
            "Task: Describe your specific responsibility",
            "Action: Detail the steps you took",
            "Result: Share the outcome with metrics",
        ],
        "when_to_use": "Interviews, performance reviews, stakeholder updates",
    },
    "Kotter": {
        "name": "Kotter's 8-Step Change Model",
        "description": "Framework for leading organizational change.",
        "steps": [
            "1. Create urgency — Why must we change now?",
            "2. Form a guiding coalition — Who leads the change?",
            "3. Develop a vision and strategy — Where are we going?",
            "4. Communicate the vision — Ensure everyone understands",
            "5. Empower broad-based action — Remove obstacles",
            "6. Generate short-term wins — Show early progress",
            "7. Consolidate gains — Build on momentum",
            "8. Anchor in culture — Make it stick",
        ],
        "when_to_use": "Team restructuring, process changes, technology migrations",
    },
    "Eisenhower": {
        "name": "Eisenhower Priority Matrix",
        "description": "Prioritize tasks by urgency and importance.",
        "steps": [
            "Urgent + Important: Do immediately (production outage)",
            "Important + Not Urgent: Schedule it (architecture planning, team development)",
            "Urgent + Not Important: Delegate (routine requests, meeting coordination)",
            "Not Urgent + Not Important: Eliminate (unnecessary reports, low-value meetings)",
        ],
        "when_to_use": "Daily/weekly prioritization, overload situations",
    },
}

LEADERSHIP_QUOTES = [
    ("The art of communication is the language of leadership.", "James Humes"),
    ("Before you are a leader, success is about growing yourself. When you become a leader, success is about growing others.", "Jack Welch"),
    ("The most important thing in communication is hearing what isn't said.", "Peter Drucker"),
    ("A leader is one who knows the way, goes the way, and shows the way.", "John C. Maxwell"),
    ("Innovation distinguishes between a leader and a follower.", "Steve Jobs"),
    ("The single biggest problem in communication is the illusion that it has taken place.", "George Bernard Shaw"),
    ("Leadership is not about being in charge. It is about taking care of those in your charge.", "Simon Sinek"),
    ("Management is doing things right; leadership is doing the right things.", "Peter Drucker"),
]


def get_scenario(level: int | None = None, category: str | None = None) -> dict:
    """Get a leadership scenario, optionally filtered."""
    scenarios = LEADERSHIP_SCENARIOS
    if level:
        scenarios = [s for s in scenarios if s["level"] == level]
    if category:
        scenarios = [s for s in scenarios if s["category"] == category]
    if not scenarios:
        scenarios = LEADERSHIP_SCENARIOS
    return random.choice(scenarios)


def get_all_scenarios() -> list[dict]:
    """Return all leadership scenarios."""
    return LEADERSHIP_SCENARIOS


def get_framework(name: str | None = None) -> dict:
    """Get a leadership framework."""
    if name and name in LEADERSHIP_FRAMEWORKS:
        return {name: LEADERSHIP_FRAMEWORKS[name]}
    return LEADERSHIP_FRAMEWORKS


def get_daily_quote() -> tuple[str, str]:
    """Get a random leadership quote."""
    return random.choice(LEADERSHIP_QUOTES)


def evaluate_leadership_response(text: str, scenario_category: str = "general") -> dict:
    """Evaluate a leadership response."""
    text_lower = text.lower()

    # Check for key leadership qualities
    shows_empathy = any(
        phrase in text_lower
        for phrase in ["i understand", "i appreciate", "i hear you", "i recognize",
                       "their perspective", "from their point of view", "empathize",
                       "feelings", "concern", "well-being"]
    )
    shows_decisiveness = any(
        phrase in text_lower
        for phrase in ["i recommend", "my decision is", "i propose", "we will",
                       "the plan is", "i've decided", "here is what we'll do",
                       "the direction is", "i am committing to"]
    )
    shows_accountability = any(
        phrase in text_lower
        for phrase in ["i take responsibility", "my role is", "i own",
                       "i am accountable", "the buck stops", "i should have",
                       "i will ensure", "on my watch"]
    )
    uses_framework = any(
        phrase in text_lower
        for phrase in ["first", "second", "third", "step 1", "step 2",
                       "phase 1", "phase 2", "criteria", "framework",
                       "principles", "approach"]
    )
    considers_people = any(
        phrase in text_lower
        for phrase in ["team", "people", "engineers", "individuals",
                       "morale", "development", "growth", "career",
                       "training", "support", "mentor"]
    )
    data_driven = any(
        phrase in text_lower
        for phrase in ["data", "metrics", "measure", "kpi", "roi",
                       "analysis", "evidence", "numbers", "benchmark",
                       "percent", "%", "cost", "revenue"]
    )

    score = 30
    score += 15 if shows_empathy else 0
    score += 15 if shows_decisiveness else 0
    score += 10 if shows_accountability else 0
    score += 10 if uses_framework else 0
    score += 10 if considers_people else 0
    score += 10 if data_driven else 0

    feedback = []
    if not shows_decisiveness:
        feedback.append(
            "Be more decisive — leaders must make clear recommendations even with "
            "incomplete information. State your decision and the reasoning behind it."
        )
    if not shows_empathy and scenario_category in ("team_management", "stakeholder_management"):
        feedback.append(
            "Show empathy — acknowledge the human impact of decisions. People need to "
            "feel heard before they can accept change."
        )
    if not shows_accountability:
        feedback.append(
            "Demonstrate accountability — explicitly own outcomes and commitments. "
            "Say 'I will ensure...' rather than 'The team should...'"
        )
    if not uses_framework:
        feedback.append(
            "Use a structured approach — walk through your reasoning step by step. "
            "This builds confidence in your decision-making process."
        )
    if not considers_people:
        feedback.append(
            "Consider the people impact — great leaders think about how decisions "
            "affect individuals, team dynamics, and culture."
        )
    if not data_driven:
        feedback.append(
            "Back up your approach with data — use metrics, benchmarks, and evidence "
            "to support your leadership decisions."
        )
    if not feedback:
        feedback.append(
            "Excellent leadership response — decisive, empathetic, structured, and data-driven!"
        )

    qualities = {
        "empathy": shows_empathy,
        "decisiveness": shows_decisiveness,
        "accountability": shows_accountability,
        "structured_thinking": uses_framework,
        "people_focus": considers_people,
        "data_driven": data_driven,
    }

    return {
        "score": max(0, min(100, score)),
        "qualities": qualities,
        "feedback": feedback,
    }
