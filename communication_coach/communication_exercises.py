"""English communication exercises for technical professionals."""

import random

# --- Email Writing Exercises ---

EMAIL_EXERCISES = [
    {
        "level": 1,
        "title": "Status Update Email",
        "scenario": (
            "Write a weekly status update email to your manager about the 5G Core "
            "network migration project. The project is 70% complete, there's a risk "
            "with the SMF component testing timeline, and you need a decision on "
            "whether to proceed with vendor A or B for the UPF upgrade."
        ),
        "audience": "Direct manager (technical background)",
        "guidelines": [
            "Use clear subject line with project name and status",
            "Lead with the most important information first",
            "Separate status, risks, and action items clearly",
            "Keep it under 200 words",
        ],
        "good_example_elements": [
            "Subject: [5G Core Migration] Week 12 Status — 70% Complete, Decision Needed on UPF",
            "Executive summary in first 2 sentences",
            "Bulleted progress items",
            "Risk section with impact and mitigation",
            "Clear ask with deadline",
        ],
    },
    {
        "level": 2,
        "title": "Escalation Email to VP",
        "scenario": (
            "The 5G network slicing deployment for a major enterprise customer is at risk "
            "of missing the contractual go-live date by 3 weeks due to a critical bug in "
            "the PCF (Policy Control Function). The vendor has acknowledged the bug but "
            "their fix timeline is unclear. Write an escalation email to the VP of Engineering."
        ),
        "audience": "VP Engineering (semi-technical, time-constrained)",
        "guidelines": [
            "Be direct — state the problem and impact in the first sentence",
            "Quantify the business impact (revenue, SLA penalties, customer relationship)",
            "Present options with your recommendation",
            "Specify what you need from the VP",
        ],
        "good_example_elements": [
            "Clear problem statement with business impact",
            "Timeline with specific dates",
            "Options: (A) Wait for vendor fix, (B) Implement workaround, (C) Negotiate deadline",
            "Your recommendation with rationale",
            "Specific ask: 'I need your approval for Option B by Thursday'",
        ],
    },
    {
        "level": 3,
        "title": "Executive Briefing Email to CTO",
        "scenario": (
            "Write an email to the CTO summarizing your evaluation of three 6G research "
            "partnership proposals. Each has different strengths: University A has the best "
            "AI/ML research team, Company B has THz hardware expertise, and Consortium C "
            "offers the broadest ecosystem but requires the largest investment. Recommend "
            "one option."
        ),
        "audience": "CTO (highly technical, decides in minutes)",
        "guidelines": [
            "One-paragraph executive summary at the top",
            "Comparison table or matrix",
            "Clear recommendation with 3 supporting reasons",
            "Next steps with specific timeline",
        ],
        "good_example_elements": [
            "Subject line that telegraphs the recommendation",
            "TL;DR in first 2 lines",
            "Structured comparison (cost, capability, timeline, risk)",
            "Bold recommendation with 'because' reasoning",
            "Attachment reference for detailed analysis",
        ],
    },
]

# --- Meeting Facilitation Exercises ---

MEETING_EXERCISES = [
    {
        "level": 1,
        "title": "Stand-up Meeting Facilitation",
        "scenario": (
            "You are facilitating the daily stand-up for a 10-person core network "
            "development team. Two team members tend to go into long technical deep-dives. "
            "The sprint goal is at risk because of a dependency on the UDM team. "
            "Prepare your facilitation plan and key phrases."
        ),
        "skills_practiced": ["Time management", "Redirecting discussions", "Identifying blockers"],
        "key_phrases": [
            "'Let's take that offline after the stand-up.'",
            "'Can you summarize the blocker in one sentence?'",
            "'Who needs to be in the follow-up discussion?'",
            "'What's the one thing that would unblock you today?'",
        ],
    },
    {
        "level": 2,
        "title": "Architecture Review Meeting",
        "scenario": (
            "You are chairing an architecture review for a proposed Network Data Analytics "
            "Function (NWDAF) deployment. Attendees include the data science team, network "
            "operations, security, and the vendor. There are disagreements about whether "
            "to use a centralized or distributed NWDAF model. Lead the discussion to a decision."
        ),
        "skills_practiced": [
            "Facilitating technical debates",
            "Building consensus",
            "Decision documentation",
        ],
        "key_phrases": [
            "'Let's evaluate both options against our agreed criteria.'",
            "'What data do we need to make this decision confidently?'",
            "'I'm hearing two distinct concerns — let me separate them.'",
            "'Can we agree on the evaluation criteria before debating solutions?'",
            "'Let me summarize what I've heard so far to make sure we're aligned.'",
        ],
    },
    {
        "level": 3,
        "title": "Cross-Functional Program Review",
        "scenario": (
            "You are leading a monthly program review for the 5G-to-6G evolution roadmap. "
            "Attendees include engineering leads, product management, finance, and the CTO. "
            "Engineering wants more time for quality. Product wants faster feature delivery. "
            "Finance is questioning the ROI. Navigate these competing priorities."
        ),
        "skills_practiced": [
            "Stakeholder alignment",
            "Conflict resolution",
            "Executive communication",
        ],
        "key_phrases": [
            "'Let's start with what we all agree on — our strategic objective.'",
            "'I understand the tension between speed and quality — here's how I propose we balance both.'",
            "'Let me reframe this: it's not quality vs. speed, it's about which risks we accept.'",
            "'Can each team share their top constraint? That helps us find the real trade-offs.'",
            "'Here's my recommendation, and here's the data behind it.'",
        ],
    },
]

# --- Vocabulary Building ---

TECHNICAL_VOCABULARY = {
    "Architecture Terms": {
        "Service Based Architecture (SBA)": (
            "A cloud-native architecture pattern used in 5G Core where network functions "
            "expose services via APIs. Use it when: explaining 5G Core design philosophy."
        ),
        "Control and User Plane Separation (CUPS)": (
            "Decoupling of control plane (signaling) from user plane (data forwarding). "
            "Use it when: discussing scalability and deployment flexibility."
        ),
        "Network Function Virtualization (NFV)": (
            "Running network functions as software on commercial off-the-shelf hardware. "
            "Use it when: discussing infrastructure modernization."
        ),
        "Cloud-Native Network Function (CNF)": (
            "Network functions designed as microservices running on container platforms. "
            "Use it when: discussing modern deployment approaches."
        ),
    },
    "5G Advanced Terms": {
        "Network Slicing": (
            "Creating multiple virtual networks on shared physical infrastructure, each "
            "optimized for specific use cases. Use it when: discussing enterprise solutions."
        ),
        "NWDAF (Network Data Analytics Function)": (
            "3GPP-defined function for network data collection and analytics. "
            "Use it when: discussing AI/ML in the network."
        ),
        "Non-Terrestrial Networks (NTN)": (
            "Integration of satellite and high-altitude platforms with terrestrial 5G. "
            "Use it when: discussing coverage extension and 6G evolution."
        ),
        "Integrated Sensing and Communication (ISAC)": (
            "Using communication signals for sensing (radar-like) capabilities. "
            "Use it when: discussing 6G use cases and research."
        ),
    },
    "Business & Strategy Terms": {
        "Total Cost of Ownership (TCO)": (
            "Complete cost including purchase, deployment, operations, and decommissioning. "
            "Use it when: making business cases or vendor comparisons."
        ),
        "CAPEX vs OPEX": (
            "Capital expenditure (one-time) vs. operational expenditure (ongoing). "
            "Use it when: discussing cloud migration benefits."
        ),
        "Time-to-Market (TTM)": (
            "Duration from concept to commercial availability. "
            "Use it when: arguing for agile development or platform investments."
        ),
        "Net Promoter Score (NPS)": (
            "Customer satisfaction metric. "
            "Use it when: linking technical quality to business outcomes."
        ),
    },
}

# --- Articulation Exercises (explain complex concepts simply) ---

EXPLANATION_CHALLENGES = [
    {
        "concept": "5G Network Slicing",
        "explain_to": "A non-technical CEO",
        "constraint": "Use an everyday analogy. No more than 3 sentences.",
        "good_example": (
            "Think of network slicing like a highway with dedicated lanes. Just as you "
            "might have a bus lane, a carpool lane, and regular lanes on the same road, "
            "network slicing creates dedicated 'lanes' in our network — one optimized for "
            "video calls, another for factory robots, another for self-driving cars — all "
            "running on the same infrastructure but never interfering with each other."
        ),
    },
    {
        "concept": "Service Based Architecture (SBA)",
        "explain_to": "A project manager from the IT department",
        "constraint": "Relate it to something they already know, like web APIs or microservices.",
        "good_example": (
            "SBA in 5G Core is very similar to how modern web applications are built using "
            "microservices. Instead of one monolithic system handling everything, we break "
            "the network into small, specialized services that talk to each other via APIs — "
            "just like how Netflix has separate services for recommendations, streaming, "
            "and billing."
        ),
    },
    {
        "concept": "Zero-Trust Security in 5G Core",
        "explain_to": "The company's board of directors",
        "constraint": "Focus on risk and business impact. Keep it under 4 sentences.",
        "good_example": (
            "Traditional network security is like a castle with a moat — once you're inside, "
            "you're trusted. Zero-trust assumes no one is trusted, ever. Every request between "
            "every part of our 5G network must prove its identity and authorization, every time. "
            "This dramatically reduces the blast radius if any single component is compromised."
        ),
    },
    {
        "concept": "AI-Native 6G Networks",
        "explain_to": "A telecom industry journalist",
        "constraint": "Be quotable. Convey both technical substance and vision.",
        "good_example": (
            "Today we add AI on top of networks designed in the pre-AI era. 6G flips that — "
            "the network is designed from the ground up with AI as a first-class citizen. "
            "Imagine a network that doesn't just carry data but understands it, predicts "
            "failures before they happen, and optimizes itself in real-time without human "
            "intervention. That's the paradigm shift we're engineering."
        ),
    },
    {
        "concept": "Digital Twin Networks",
        "explain_to": "A finance executive evaluating R&D investment",
        "constraint": "Quantify the business value. Use concrete examples.",
        "good_example": (
            "A digital twin is a virtual replica of our entire network that we can use to "
            "simulate changes before deploying them in production. Instead of risking a "
            "network outage to test a new configuration — which could cost us $500K per hour "
            "in SLA penalties — we test it on the digital twin first. Companies using this "
            "approach report 60% fewer outages and 40% faster rollout of new services."
        ),
    },
]


def get_email_exercise(level: int | None = None) -> dict:
    """Get an email writing exercise."""
    exercises = EMAIL_EXERCISES
    if level:
        exercises = [e for e in exercises if e["level"] == level]
    return random.choice(exercises) if exercises else random.choice(EMAIL_EXERCISES)


def get_meeting_exercise(level: int | None = None) -> dict:
    """Get a meeting facilitation exercise."""
    exercises = MEETING_EXERCISES
    if level:
        exercises = [e for e in exercises if e["level"] == level]
    return random.choice(exercises) if exercises else random.choice(MEETING_EXERCISES)


def get_explanation_challenge() -> dict:
    """Get a random concept explanation challenge."""
    return random.choice(EXPLANATION_CHALLENGES)


def get_vocabulary(category: str | None = None) -> dict:
    """Get vocabulary terms, optionally filtered by category."""
    if category and category in TECHNICAL_VOCABULARY:
        return {category: TECHNICAL_VOCABULARY[category]}
    return TECHNICAL_VOCABULARY


def evaluate_email(text: str) -> dict:
    """Evaluate an email response for professional communication quality."""
    text_lower = text.lower()
    lines = text.strip().split("\n")

    has_subject = any(
        line.lower().startswith("subject:") for line in lines
    )
    has_greeting = any(
        text_lower.startswith(g)
        for g in ["hi ", "hello ", "dear ", "good morning", "good afternoon", "team,"]
    )
    has_closing = any(
        phrase in text_lower
        for phrase in ["regards", "thanks", "best", "sincerely", "thank you"]
    )
    has_action_item = any(
        phrase in text_lower
        for phrase in ["action needed", "please", "could you", "i need",
                       "by friday", "by end of", "deadline", "next steps",
                       "decision needed", "approval needed"]
    )
    has_structure = any(
        indicator in text_lower
        for indicator in ["summary:", "status:", "risk", "update:", "background:",
                          "recommendation:", "options:", "ask:", "action:"]
    )

    word_count = len(text.split())
    is_concise = word_count <= 250

    score = 40
    score += 10 if has_subject else 0
    score += 10 if has_greeting else 0
    score += 10 if has_closing else 0
    score += 15 if has_action_item else 0
    score += 10 if has_structure else 0
    score += 5 if is_concise else 0

    feedback = []
    if not has_subject:
        feedback.append("Always include a descriptive subject line that summarizes the key message.")
    if not has_greeting:
        feedback.append("Start with an appropriate greeting for the audience.")
    if not has_action_item:
        feedback.append("Include a clear call-to-action — what do you need from the reader?")
    if not has_structure:
        feedback.append("Use headers or sections (Summary, Risk, Action Items) for scannability.")
    if not is_concise:
        feedback.append(f"Email is {word_count} words — aim for under 200 for maximum impact.")
    if not has_closing:
        feedback.append("End with a professional closing (Regards, Best, Thank you).")
    if not feedback:
        feedback.append("Well-structured professional email — clear, concise, and actionable!")

    return {
        "score": max(0, min(100, score)),
        "has_subject": has_subject,
        "has_greeting": has_greeting,
        "has_closing": has_closing,
        "has_action_item": has_action_item,
        "has_structure": has_structure,
        "is_concise": is_concise,
        "word_count": word_count,
        "feedback": feedback,
    }
