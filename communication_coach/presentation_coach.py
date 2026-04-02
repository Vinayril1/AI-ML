"""Presentation Skills Coach with telecom-focused scenarios."""

import random

PRESENTATION_SCENARIOS = [
    # Level 1: Internal team updates
    {
        "level": 1,
        "title": "Sprint Review Update",
        "scenario": (
            "You are presenting a sprint review to your core network development team. "
            "The sprint focused on implementing a new Network Slice Management Function "
            "(NSMF) microservice. Explain what was accomplished, what challenges were "
            "encountered, and what's planned for the next sprint."
        ),
        "audience": "Development team (8-10 engineers)",
        "time_limit": "5 minutes",
        "key_points": [
            "Summarize completed user stories",
            "Highlight technical challenges and how they were resolved",
            "Demo the working functionality",
            "Outline next sprint priorities",
        ],
    },
    {
        "level": 1,
        "title": "Technical Design Walkthrough",
        "scenario": (
            "Present a technical design for migrating the existing 5G Core UPF "
            "(User Plane Function) from VM-based deployment to cloud-native CNF "
            "on Kubernetes. Your team needs to understand the architecture decisions."
        ),
        "audience": "Engineering team (5-7 architects and senior developers)",
        "time_limit": "15 minutes",
        "key_points": [
            "Current architecture limitations",
            "Proposed cloud-native architecture",
            "Migration strategy and timeline",
            "Risk assessment and mitigation",
        ],
    },
    # Level 2: Cross-functional
    {
        "level": 2,
        "title": "5G Network Slicing Business Case",
        "scenario": (
            "Present the business case for deploying enterprise-grade 5G network slicing "
            "to the product management and business development teams. They need to "
            "understand both the technical capabilities and the revenue opportunity."
        ),
        "audience": "Product managers, business development, and finance (12-15 people)",
        "time_limit": "20 minutes",
        "key_points": [
            "What is network slicing and why it matters",
            "Target enterprise use cases (manufacturing, healthcare, logistics)",
            "Revenue model and pricing strategy",
            "Competitive advantage and time-to-market",
        ],
    },
    {
        "level": 2,
        "title": "Security Architecture Review",
        "scenario": (
            "Present the zero-trust security architecture for the 5G SA Core to the "
            "security review board. Address how the Service Based Architecture (SBA) "
            "is secured, including inter-NF communication, API gateway security, and "
            "subscriber privacy protection."
        ),
        "audience": "Security team, CISO, compliance officers (8-10 people)",
        "time_limit": "30 minutes",
        "key_points": [
            "Zero-trust principles applied to 5G Core",
            "SBA interface security (OAuth 2.0, TLS 1.3)",
            "Subscriber data protection (SUPI/SUCI)",
            "Threat model and mitigation strategies",
        ],
    },
    # Level 3: C-Suite
    {
        "level": 3,
        "title": "6G Vision and Strategic Roadmap",
        "scenario": (
            "Present to the CTO and executive leadership team your vision for 6G "
            "readiness. Cover how current 5G Advanced investments create a foundation "
            "for 6G, including AI-native networking, THz communication research, and "
            "digital twin network capabilities."
        ),
        "audience": "CTO, VP Engineering, VP Strategy, CFO (5-7 executives)",
        "time_limit": "20 minutes",
        "key_points": [
            "6G industry timeline and key milestones",
            "How 5G Advanced bridges to 6G",
            "Required R&D investments and partnerships",
            "Strategic positioning vs. competitors",
        ],
    },
    {
        "level": 3,
        "title": "Board Investment Proposal: AI-Native Core Network",
        "scenario": (
            "Present a $50M investment proposal to the board of directors for building "
            "an AI-native core network platform. This includes NWDAF enhancement, "
            "closed-loop automation, and intent-based networking capabilities that will "
            "reduce OpEx by 40% over 3 years."
        ),
        "audience": "Board of Directors (8-10 members, mix of technical and financial)",
        "time_limit": "15 minutes",
        "key_points": [
            "Problem statement and market opportunity",
            "Solution overview (accessible to non-technical audience)",
            "Financial model: investment, ROI, payback period",
            "Risk factors and mitigation plan",
        ],
    },
    # Level 4: Industry conference
    {
        "level": 4,
        "title": "MWC Keynote: The Path from 5G Advanced to 6G",
        "scenario": (
            "You are delivering a keynote at Mobile World Congress on 'Building 6G-Ready "
            "Core Networks Today.' The audience includes CTOs, analysts, researchers, and "
            "media from across the global telecom industry. Your talk should inspire, "
            "inform, and position your company as a thought leader."
        ),
        "audience": "Industry conference (500+ attendees, diverse backgrounds)",
        "time_limit": "25 minutes",
        "key_points": [
            "Compelling opening with industry vision",
            "3GPP Release 18/19 as 6G stepping stones",
            "Live demo or case study results",
            "Bold predictions and call to action",
        ],
    },
    {
        "level": 4,
        "title": "Standards Body Technical Proposal",
        "scenario": (
            "Present a technical contribution to 3GPP SA2 working group proposing a new "
            "architecture for Integrated Sensing and Communication (ISAC) in the 6G Core. "
            "You must defend your proposal against alternative approaches from competing "
            "vendors while maintaining collaborative professionalism."
        ),
        "audience": "3GPP delegates from major telecom vendors and operators (30-50)",
        "time_limit": "10 minutes",
        "key_points": [
            "Problem statement and gap in current architecture",
            "Proposed solution with reference architecture",
            "Comparison with alternative approaches",
            "Implementation feasibility and backward compatibility",
        ],
    },
]

PRESENTATION_TIPS = {
    "opening": [
        "Start with a compelling statistic or industry trend to capture attention.",
        "Open with a thought-provoking question relevant to your audience.",
        "Begin with a brief story that illustrates the problem you're solving.",
        "Use the 'What if...' technique to paint a vision of the future.",
    ],
    "structure": [
        "Follow the 'Situation-Complication-Resolution' framework for business audiences.",
        "Use the 'Problem-Solution-Benefit' structure for technical proposals.",
        "Apply the 'Tell them what you'll tell them, tell them, tell them what you told them' rule.",
        "Limit to 3 key messages — audiences rarely retain more.",
    ],
    "delivery": [
        "Pause after key points for 2-3 seconds to let them sink in.",
        "Use analogies to explain complex 5G/6G concepts to non-technical audiences.",
        "Make eye contact with different sections of the room every 3-5 seconds.",
        "Vary your pace — slow down for important points, speed up for context.",
    ],
    "slides": [
        "Follow the 10-20-30 rule: 10 slides, 20 minutes, 30pt minimum font.",
        "One idea per slide — if you need a second bullet list, make a second slide.",
        "Use architecture diagrams instead of text for technical concepts.",
        "Include a clear 'So What?' for every data point you present.",
    ],
    "closing": [
        "End with a specific, actionable call-to-action.",
        "Summarize your 3 key messages before Q&A.",
        "Close with a forward-looking statement that reinforces your vision.",
        "Prepare for the top 5 most likely questions and have concise answers ready.",
    ],
}


def get_scenario(level: int | None = None) -> dict:
    """Get a presentation scenario, optionally filtered by level."""
    if level:
        scenarios = [s for s in PRESENTATION_SCENARIOS if s["level"] == level]
    else:
        scenarios = PRESENTATION_SCENARIOS
    return random.choice(scenarios)


def get_all_scenarios() -> list[dict]:
    """Return all available presentation scenarios."""
    return PRESENTATION_SCENARIOS


def get_tips(category: str | None = None) -> dict:
    """Get presentation tips, optionally for a specific category."""
    if category and category in PRESENTATION_TIPS:
        return {category: PRESENTATION_TIPS[category]}
    return PRESENTATION_TIPS


def evaluate_presentation_structure(text: str) -> dict:
    """Evaluate if the presentation has a clear structure."""
    text_lower = text.lower()
    has_opening = any(
        phrase in text_lower
        for phrase in ["today i", "let me", "i'd like to", "good morning",
                       "good afternoon", "thank you for", "welcome"]
    )
    has_body = len(text.split(".")) >= 3
    has_conclusion = any(
        phrase in text_lower
        for phrase in ["in conclusion", "to summarize", "in summary", "to wrap up",
                       "key takeaway", "next steps", "call to action", "finally",
                       "i recommend", "let's move forward"]
    )
    has_transitions = any(
        phrase in text_lower
        for phrase in ["first", "second", "next", "moreover", "furthermore",
                       "however", "therefore", "additionally", "moving on"]
    )

    structure_score = sum([
        has_opening * 25,
        has_body * 25,
        has_conclusion * 25,
        has_transitions * 25,
    ])

    feedback = []
    if not has_opening:
        feedback.append("Add a strong opening — greet the audience and state your purpose.")
    if not has_transitions:
        feedback.append("Use transition phrases to guide the audience through your points.")
    if not has_conclusion:
        feedback.append("Include a clear conclusion with a summary or call to action.")

    return {
        "structure_score": structure_score,
        "has_opening": has_opening,
        "has_body": has_body,
        "has_conclusion": has_conclusion,
        "has_transitions": has_transitions,
        "feedback": feedback,
    }
