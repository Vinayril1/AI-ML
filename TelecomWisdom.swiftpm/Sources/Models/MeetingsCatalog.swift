import Foundation

struct MeetingsCatalog {

    // MARK: - Network Slicing
    static let networkSlicing: [MeetingDiscussion] = [
        MeetingDiscussion(id: "ns_m1", meetingNumber: "SA2#163", workingGroup: "SA2", date: "2024-08", topic: "Network Slicing Enhancement Phase 3 — Rel-19 Scope", summary: "SA2 agreed on the scope for Rel-19 network slicing enhancements focusing on hierarchical slicing, slice group management, and enhanced admission control via NSACF.", keyDecisions: ["Hierarchical slicing architecture approved for normative work", "NSACF enhancements for cross-slice admission control agreed", "Slice SLA monitoring integration with NWDAF endorsed"], tdocReferences: ["S2-2400100", "S2-2400215", "S2-2400330"], sourceURL: "https://www.3gpp.org/ftp/tsg_sa/WG2_Arch/"),
        MeetingDiscussion(id: "ns_m2", meetingNumber: "SA2#164", workingGroup: "SA2", date: "2024-11", topic: "Network Slicing — Inter-PLMN Slicing and Roaming Enhancements", summary: "Discussed challenges of network slicing across operator boundaries. Focus on HPLMN-VPLMN slice mapping, slice-aware roaming agreements, and SLA assurance in roaming scenarios.", keyDecisions: ["S-NSSAI mapping procedures between PLMNs refined", "NSSAAF role in roaming slice authentication clarified", "New study on slice federation for Rel-20 proposed"], tdocReferences: ["S2-2401050", "S2-2401123"], sourceURL: "https://www.3gpp.org/ftp/tsg_sa/WG2_Arch/"),
    ]

    // MARK: - SBA
    static let sba: [MeetingDiscussion] = [
        MeetingDiscussion(id: "sba_m1", meetingNumber: "CT3#131", workingGroup: "CT3", date: "2024-05", topic: "SCP Enhancement for Multi-Cloud 5G Core Deployment", summary: "CT3 discussed SCP enhancements for multi-cloud and multi-vendor SBA deployments, focusing on indirect communication binding, SCP chaining, and SCP load balancing.", keyDecisions: ["SCP binding indication in HTTP headers standardized", "Multi-hop SCP routing procedures defined", "SCP-to-SCP mutual authentication via mTLS mandated"], tdocReferences: ["C3-242100", "C3-242205"], sourceURL: "https://www.3gpp.org/ftp/tsg_ct/WG3_interworking/"),
        MeetingDiscussion(id: "sba_m2", meetingNumber: "SA2#163", workingGroup: "SA2", date: "2024-08", topic: "SBA Phase 2 — HTTP/3 and QUIC for SBI", summary: "SA2 evaluated HTTP/3 (QUIC) as transport for SBI interfaces to improve performance, reduce head-of-line blocking, and enable 0-RTT connection establishment.", keyDecisions: ["Study on HTTP/3 for SBI approved for Rel-19", "Backward compatibility with HTTP/2 required", "Performance benchmarking criteria defined"], tdocReferences: ["S2-2400450", "S2-2400512"], sourceURL: "https://www.3gpp.org/ftp/tsg_sa/WG2_Arch/"),
    ]

    // MARK: - UPF
    static let upf: [MeetingDiscussion] = [
        MeetingDiscussion(id: "upf_m1", meetingNumber: "CT4#128", workingGroup: "CT4", date: "2024-06", topic: "PFCP Enhancements for Edge UPF and TSN Integration", summary: "CT4 progressed PFCP enhancements for edge computing UPF deployment including TSN bridge integration, deterministic QoS, and UPF group management.", keyDecisions: ["PFCP extensions for TSN stream parameters approved", "UPF group concept for edge cluster management defined", "Redundant N4 session handling procedures finalized"], tdocReferences: ["C4-241800", "C4-241900"], sourceURL: "https://www.3gpp.org/ftp/tsg_ct/WG4_protocollars_ex-CN4/"),
    ]

    // MARK: - MEC
    static let mec: [MeetingDiscussion] = [
        MeetingDiscussion(id: "mec_m1", meetingNumber: "SA2#163", workingGroup: "SA2", date: "2024-08", topic: "Edge Computing Phase 2 — EASDF Enhancements and Edge Enabler", summary: "Progressed edge computing enhancements including EASDF multi-homing, edge application relocation, and integration of edge analytics with NWDAF.", keyDecisions: ["EASDF enhancement for multi-EDN discovery approved", "Edge application context transfer during mobility defined", "NWDAF-based edge traffic prediction analytics specified"], tdocReferences: ["S2-2400600", "S2-2400678"], sourceURL: "https://www.3gpp.org/ftp/tsg_sa/WG2_Arch/"),
    ]

    // MARK: - NWDAF
    static let nwdaf: [MeetingDiscussion] = [
        MeetingDiscussion(id: "nwdaf_m1", meetingNumber: "SA2#163", workingGroup: "SA2", date: "2024-08", topic: "NWDAF Phase 4 — LLM Integration and Automated Root Cause Analysis", summary: "Major discussion on integrating Large Language Models with NWDAF for natural language network querying, automated root cause analysis, and predictive maintenance.", keyDecisions: ["LLM-NWDAF integration architecture baseline agreed", "New analytics ID for root cause analysis defined", "Privacy-preserving federated LLM training discussed", "Energy efficiency analytics added to Rel-19 scope"], tdocReferences: ["S2-2400750", "S2-2400812", "S2-2400890"], sourceURL: "https://www.3gpp.org/ftp/tsg_sa/WG2_Arch/"),
        MeetingDiscussion(id: "nwdaf_m2", meetingNumber: "SA5#148", workingGroup: "SA5", date: "2024-09", topic: "AI/ML Management — Model Lifecycle and MLOps for NWDAF", summary: "SA5 discussed end-to-end ML model lifecycle management for NWDAF including model training, validation, deployment, monitoring, and retirement procedures.", keyDecisions: ["ML model catalog and versioning framework approved", "Model performance monitoring KPIs defined", "Model drift detection and retraining triggers specified", "Federated learning governance model endorsed"], tdocReferences: ["S5-243200", "S5-243350"], sourceURL: "https://www.3gpp.org/ftp/tsg_sa/WG5_TM/"),
    ]

    // MARK: - Intent-Based
    static let intentBased: [MeetingDiscussion] = [
        MeetingDiscussion(id: "ibn_m1", meetingNumber: "SA5#148", workingGroup: "SA5", date: "2024-09", topic: "Intent-Based Management Enhancements for Rel-19", summary: "Discussion on extending intent management to cover multi-domain intents, intent conflict resolution, and natural language intent interface using LLM.", keyDecisions: ["Multi-domain intent decomposition procedure defined", "Intent conflict priority framework approved", "LLM-based intent translation study item proposed", "Intent assurance closed-loop with NWDAF specified"], tdocReferences: ["S5-243500", "S5-243612"], sourceURL: "https://www.3gpp.org/ftp/tsg_sa/WG5_TM/"),
    ]

    // MARK: - Digital Twin
    static let digitalTwin: [MeetingDiscussion] = [
        MeetingDiscussion(id: "dt_m1", meetingNumber: "SA5#147", workingGroup: "SA5", date: "2024-06", topic: "Digital Twin Network — Reference Architecture and Data Models", summary: "SA5 progressed DTN study defining reference architecture with digital representation layer, data collection layer, and simulation/prediction layer.", keyDecisions: ["DTN three-layer architecture baseline agreed", "Data model alignment with existing NRM (Network Resource Model) specified", "Real-time synchronization interval requirements defined", "Integration points with NWDAF for ML-driven simulation agreed"], tdocReferences: ["S5-242800", "S5-242900"], sourceURL: "https://www.3gpp.org/ftp/tsg_sa/WG5_TM/"),
    ]

    // MARK: - THz
    static let thz: [MeetingDiscussion] = [
        MeetingDiscussion(id: "thz_m1", meetingNumber: "ITU-R WP5D#45", workingGroup: "ITU-R WP5D", date: "2024-06", topic: "IMT-2030 Spectrum Considerations Above 100 GHz", summary: "WP5D discussed spectrum identification for 6G/IMT-2030 in bands above 100 GHz, with focus on 92-300 GHz range. Propagation studies and coexistence with passive services were key topics.", keyDecisions: ["Studies on 92-114.25 GHz and 130-174.8 GHz prioritized", "Channel modeling campaign results for indoor THz shared", "Coexistence with Earth exploration-satellite service studied", "6G spectrum roadmap toward WRC-2027 agenda updated"], tdocReferences: ["5D/TEMP/1200", "5D/TEMP/1215"], sourceURL: "https://www.itu.int/en/ITU-R/study-groups/rsg5/rwp5d/"),
    ]

    // MARK: - RIS
    static let ris: [MeetingDiscussion] = [
        MeetingDiscussion(id: "ris_m1", meetingNumber: "RAN1#118", workingGroup: "RAN1", date: "2024-08", topic: "Study on RIS for NR — Channel Modeling and Evaluation", summary: "RAN1 reviewed RIS channel model proposals and evaluation methodology. Discussed passive RIS vs active RIS performance trade-offs and deployment scenarios.", keyDecisions: ["RIS path-loss model with distance-dependent phase shift adopted", "Evaluation methodology for RIS-aided MIMO defined", "Coverage extension scenario prioritized for initial study", "Active RIS with amplification included in scope"], tdocReferences: ["R1-2408100", "R1-2408250"], sourceURL: "https://www.3gpp.org/ftp/tsg_ran/WG1_RL1/"),
    ]

    // MARK: - NTN
    static let ntn: [MeetingDiscussion] = [
        MeetingDiscussion(id: "ntn_m1", meetingNumber: "SA2#163", workingGroup: "SA2", date: "2024-08", topic: "NTN Architecture Enhancements — Rel-19 Direct-to-Device", summary: "SA2 discussed 5G Core enhancements for NTN D2D scenarios including regenerative satellite payloads, inter-satellite handover, and NTN-terrestrial mobility.", keyDecisions: ["Regenerative satellite with on-board gNB architecture endorsed", "Inter-satellite link handover procedures defined", "Hybrid terrestrial-NTN session continuity specified", "NTN-specific UE power saving mechanisms agreed"], tdocReferences: ["S2-2401200", "S2-2401340"], sourceURL: "https://www.3gpp.org/ftp/tsg_sa/WG2_Arch/"),
    ]

    // MARK: - ISAC
    static let isac: [MeetingDiscussion] = [
        MeetingDiscussion(id: "isac_m1", meetingNumber: "SA1#106", workingGroup: "SA1", date: "2024-05", topic: "ISAC Service Requirements — Use Cases and KPIs", summary: "SA1 finalized service requirements for ISAC including use cases for intruder detection, traffic monitoring, gesture recognition, and indoor positioning.", keyDecisions: ["Sensing-as-a-service model approved", "Sensing accuracy KPIs: range (sub-meter), velocity (0.1 m/s) defined", "Privacy requirements: sensing data anonymization mandated", "Sensing authorization and consent framework specified"], tdocReferences: ["S1-242100", "S1-242200"], sourceURL: "https://www.3gpp.org/ftp/tsg_sa/WG1_Serv/"),
    ]

    // MARK: - Semantic Communications
    static let semanticComms: [MeetingDiscussion] = [
        MeetingDiscussion(id: "sem_m1", meetingNumber: "ITU-T SG13", workingGroup: "ITU-T SG13", date: "2024-04", topic: "Semantic Communication Framework for Future Networks", summary: "ITU-T SG13 discussed semantic communication architecture including semantic encoder/decoder placement, knowledge base synchronization, and semantic-aware transport.", keyDecisions: ["Semantic communication reference architecture drafted", "Knowledge base management protocol requirements outlined", "Semantic QoS metrics (meaning fidelity, task accuracy) proposed", "Joint source-channel coding for semantic comms studied"], tdocReferences: ["TD-520", "TD-535"], sourceURL: "https://www.itu.int/en/ITU-T/studygroups/2022-2024/13/"),
    ]

    // MARK: - Zero Trust
    static let zeroTrust: [MeetingDiscussion] = [
        MeetingDiscussion(id: "zt_m1", meetingNumber: "SA3#115", workingGroup: "SA3", date: "2024-08", topic: "Zero Trust Enhancements for 5G SBA — Rel-19 Security", summary: "SA3 discussed enhanced zero-trust measures for SBI including per-request authorization, API-level micro-segmentation, and security posture assessment.", keyDecisions: ["Per-request OAuth 2.0 token validation for critical NFs recommended", "SBI API-level access control policies defined", "Security posture continuous assessment framework studied", "Quantum-safe cryptography migration timeline for 5G discussed"], tdocReferences: ["S3-242700", "S3-242800"], sourceURL: "https://www.3gpp.org/ftp/tsg_sa/WG3_Security/"),
    ]

    // MARK: - NEF/CAPIF
    static let networkExposure: [MeetingDiscussion] = [
        MeetingDiscussion(id: "ne_m1", meetingNumber: "CT3#132", workingGroup: "CT3", date: "2024-08", topic: "CAPIF and NEF Enhancements — CAMARA API Alignment", summary: "CT3 discussed aligning 3GPP CAPIF/NEF specifications with GSMA CAMARA open APIs including QoD, Device Location, and Network Slicing APIs.", keyDecisions: ["CAMARA QoD API mapping to NEF Nnef services defined", "CAPIF multi-domain API federation architecture agreed", "API rate limiting and quota management standardized", "Developer portal integration with CAPIF specified"], tdocReferences: ["C3-243100", "C3-243200"], sourceURL: "https://www.3gpp.org/ftp/tsg_ct/WG3_interworking/"),
    ]
}
