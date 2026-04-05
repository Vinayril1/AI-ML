import Foundation

// MARK: - Built-in Service Catalog

struct ServiceCatalog {

    static let allServices: [TelecomService] = [
        // ── Core Network ────────────────────────────────────────────────
        TelecomService(
            id: "network_slicing",
            name: "Network Slicing",
            icon: "square.stack.3d.up.fill",
            color: "blue",
            shortDescription: "End-to-end virtual networks on shared infrastructure, each optimized for specific use cases (eMBB, URLLC, mMTC).",
            category: .coreNetwork,
            researchItems: ResearchCatalog.networkSlicing,
            standards: StandardsCatalog.networkSlicing,
            meetingDiscussions: MeetingsCatalog.networkSlicing,
            lastUpdated: nil
        ),
        TelecomService(
            id: "sba",
            name: "Service Based Architecture",
            icon: "square.grid.3x3.fill",
            color: "indigo",
            shortDescription: "Cloud-native 5G Core architecture where NFs expose services via RESTful APIs, enabling modularity and independent scaling.",
            category: .coreNetwork,
            researchItems: ResearchCatalog.sba,
            standards: StandardsCatalog.sba,
            meetingDiscussions: MeetingsCatalog.sba,
            lastUpdated: nil
        ),
        TelecomService(
            id: "upf_userplane",
            name: "User Plane Function & CUPS",
            icon: "arrow.up.arrow.down.circle.fill",
            color: "green",
            shortDescription: "User plane data forwarding, traffic steering, QoS enforcement, and control/user plane separation for flexible deployment.",
            category: .coreNetwork,
            researchItems: ResearchCatalog.upf,
            standards: StandardsCatalog.upf,
            meetingDiscussions: MeetingsCatalog.upf,
            lastUpdated: nil
        ),
        TelecomService(
            id: "edge_computing",
            name: "MEC & Edge Computing",
            icon: "server.rack",
            color: "orange",
            shortDescription: "Multi-access Edge Computing bringing compute closer to the user for ultra-low latency applications.",
            category: .coreNetwork,
            researchItems: ResearchCatalog.mec,
            standards: StandardsCatalog.mec,
            meetingDiscussions: MeetingsCatalog.mec,
            lastUpdated: nil
        ),

        // ── AI & Automation ─────────────────────────────────────────────
        TelecomService(
            id: "nwdaf",
            name: "NWDAF & AI/ML in Core",
            icon: "brain",
            color: "purple",
            shortDescription: "Network Data Analytics Function — 3GPP-defined AI/ML framework for network intelligence, anomaly detection, and closed-loop automation.",
            category: .aiNative,
            researchItems: ResearchCatalog.nwdaf,
            standards: StandardsCatalog.nwdaf,
            meetingDiscussions: MeetingsCatalog.nwdaf,
            lastUpdated: nil
        ),
        TelecomService(
            id: "intent_based",
            name: "Intent-Based Networking",
            icon: "wand.and.stars",
            color: "cyan",
            shortDescription: "Declarative network management where operators express desired outcomes and the network autonomously configures itself.",
            category: .aiNative,
            researchItems: ResearchCatalog.intentBased,
            standards: StandardsCatalog.intentBased,
            meetingDiscussions: MeetingsCatalog.intentBased,
            lastUpdated: nil
        ),
        TelecomService(
            id: "digital_twin",
            name: "Digital Twin Networks",
            icon: "rectangle.on.rectangle.angled",
            color: "teal",
            shortDescription: "Virtual replica of the physical network for simulation, prediction, and zero-risk testing of configurations.",
            category: .aiNative,
            researchItems: ResearchCatalog.digitalTwin,
            standards: StandardsCatalog.digitalTwin,
            meetingDiscussions: MeetingsCatalog.digitalTwin,
            lastUpdated: nil
        ),

        // ── Air Interface & Spectrum ────────────────────────────────────
        TelecomService(
            id: "thz_comms",
            name: "THz Communications",
            icon: "wave.3.right",
            color: "red",
            shortDescription: "Sub-THz and THz frequency bands (100 GHz–10 THz) for 6G enabling Tbps data rates with new propagation challenges.",
            category: .airInterface,
            researchItems: ResearchCatalog.thz,
            standards: StandardsCatalog.thz,
            meetingDiscussions: MeetingsCatalog.thz,
            lastUpdated: nil
        ),
        TelecomService(
            id: "ris",
            name: "Reconfigurable Intelligent Surfaces",
            icon: "rectangle.split.3x3",
            color: "mint",
            shortDescription: "Programmable metasurfaces that reflect, refract, or absorb RF signals to create smart radio environments.",
            category: .airInterface,
            researchItems: ResearchCatalog.ris,
            standards: StandardsCatalog.ris,
            meetingDiscussions: MeetingsCatalog.ris,
            lastUpdated: nil
        ),

        // ── New Paradigms ───────────────────────────────────────────────
        TelecomService(
            id: "ntn",
            name: "Non-Terrestrial Networks",
            icon: "globe.americas.fill",
            color: "brown",
            shortDescription: "Integration of LEO/MEO/GEO satellites and HAPS with terrestrial 5G/6G for ubiquitous coverage.",
            category: .newParadigms,
            researchItems: ResearchCatalog.ntn,
            standards: StandardsCatalog.ntn,
            meetingDiscussions: MeetingsCatalog.ntn,
            lastUpdated: nil
        ),
        TelecomService(
            id: "isac",
            name: "Integrated Sensing & Communication",
            icon: "sensor.fill",
            color: "pink",
            shortDescription: "Using communication signals for radar-like sensing, enabling joint communication and environmental awareness.",
            category: .newParadigms,
            researchItems: ResearchCatalog.isac,
            standards: StandardsCatalog.isac,
            meetingDiscussions: MeetingsCatalog.isac,
            lastUpdated: nil
        ),
        TelecomService(
            id: "semantic_comms",
            name: "Semantic Communication",
            icon: "text.bubble.fill",
            color: "yellow",
            shortDescription: "Beyond Shannon: transmitting meaning rather than bits, using AI to achieve extreme compression and task-oriented communication.",
            category: .newParadigms,
            researchItems: ResearchCatalog.semanticComms,
            standards: StandardsCatalog.semanticComms,
            meetingDiscussions: MeetingsCatalog.semanticComms,
            lastUpdated: nil
        ),

        // ── Security ────────────────────────────────────────────────────
        TelecomService(
            id: "zero_trust",
            name: "Zero Trust Architecture",
            icon: "lock.shield.fill",
            color: "gray",
            shortDescription: "Never trust, always verify — applying zero-trust principles across 5G/6G core network functions, APIs, and data flows.",
            category: .security,
            researchItems: ResearchCatalog.zeroTrust,
            standards: StandardsCatalog.zeroTrust,
            meetingDiscussions: MeetingsCatalog.zeroTrust,
            lastUpdated: nil
        ),

        // ── Management & Orchestration ──────────────────────────────────
        TelecomService(
            id: "network_exposure",
            name: "NEF/CAPIF & Network APIs",
            icon: "point.3.connected.trianglepath.dotted",
            color: "orange",
            shortDescription: "Network Exposure Function and CAPIF enabling third-party developers to access network capabilities via APIs.",
            category: .management,
            researchItems: ResearchCatalog.networkExposure,
            standards: StandardsCatalog.networkExposure,
            meetingDiscussions: MeetingsCatalog.networkExposure,
            lastUpdated: nil
        ),
    ]

    static func service(byId id: String) -> TelecomService? {
        allServices.first { $0.id == id }
    }

    static func services(for category: ServiceCategory) -> [TelecomService] {
        allServices.filter { $0.category == category }
    }
}
