"""Domain knowledge and configuration for telecom-focused coaching."""

TELECOM_DOMAIN = {
    "role": "Telecom Solution Architect",
    "focus_areas": ["5G Advanced", "6G", "Core Network"],
    "technologies": [
        "5G SA Core", "5G NSA", "Network Slicing", "Service Based Architecture (SBA)",
        "NWDAF", "AUSF", "UDM", "AMF", "SMF", "UPF", "PCF", "NRF", "NEF", "SEPP",
        "NFV", "SDN", "MEC", "O-RAN", "Cloud-Native CNFs",
        "6G AI-Native Networks", "THz Communications", "Reconfigurable Intelligent Surfaces (RIS)",
        "Digital Twin Networks", "Non-Terrestrial Networks (NTN)",
        "Integrated Sensing and Communication (ISAC)",
        "Semantic Communication", "Zero-Trust Architecture",
        "3GPP Release 18/19", "Network Automation", "Intent-Based Networking",
    ],
    "stakeholders": [
        "CTO", "VP Engineering", "Product Manager", "Network Operations Team",
        "Vendor Partners", "Regulatory Bodies", "Enterprise Customers",
        "Standards Bodies (3GPP, ETSI, ITU)", "R&D Teams", "Security Team",
    ],
}

# Scoring rubrics
SCORING = {
    "clarity": {
        "weight": 0.25,
        "description": "How clear and understandable is the communication",
    },
    "structure": {
        "weight": 0.20,
        "description": "Logical flow and organization of ideas",
    },
    "technical_accuracy": {
        "weight": 0.20,
        "description": "Correct use of technical terminology and concepts",
    },
    "persuasiveness": {
        "weight": 0.20,
        "description": "Ability to convince and influence the audience",
    },
    "conciseness": {
        "weight": 0.15,
        "description": "Delivering the message without unnecessary verbosity",
    },
}

# Difficulty levels
LEVELS = {
    1: "Beginner — Internal team updates",
    2: "Intermediate — Cross-functional presentations",
    3: "Advanced — C-Suite and board-level pitches",
    4: "Expert — Industry conference keynotes & vendor negotiations",
}
