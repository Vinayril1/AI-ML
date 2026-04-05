import Foundation

struct StandardsCatalog {

    // MARK: - Network Slicing
    static let networkSlicing: [Standard] = [
        Standard(id: "ns_s1", specNumber: "TS 23.501", title: "System Architecture for the 5G System", release: "Rel-18", workingGroup: "SA2", summary: "Defines the overall 5G system architecture including network slicing framework, NSSF, S-NSSAI, and slice selection procedures.", keyFeatures: ["Network Slice Selection Function (NSSF)", "S-NSSAI and NSSAI handling", "Slice-specific authentication via NSSAAF", "AMF-based slice selection"], specURL: "https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3144", status: .frozen),
        Standard(id: "ns_s2", specNumber: "TS 28.530", title: "Management and Orchestration of Network Slicing", release: "Rel-18", workingGroup: "SA5", summary: "Covers network slice lifecycle management: preparation, commissioning, operation, and decommissioning phases with NSSI/NSI models.", keyFeatures: ["Slice template and SLA definition", "NSSMF, NSMF, CSMF role definitions", "Closed-loop slice assurance", "Cross-domain slice orchestration"], specURL: "https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3273", status: .frozen),
        Standard(id: "ns_s3", specNumber: "TS 23.700-41", title: "Enhancement of Network Slicing Phase 3", release: "Rel-19", workingGroup: "SA2", summary: "Rel-19 study on advanced slicing features including slice grouping, hierarchical slicing, and enhanced slice SLA monitoring.", keyFeatures: ["Hierarchical network slicing", "Slice group management", "Enhanced NSACF for admission control", "Slice-level QoS monitoring"], specURL: "https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=4118", status: .study),
    ]

    // MARK: - SBA
    static let sba: [Standard] = [
        Standard(id: "sba_s1", specNumber: "TS 29.500", title: "5G System: Technical Realization of Service Based Architecture", release: "Rel-18", workingGroup: "CT3", summary: "Defines the HTTP/2 based service framework, NF service discovery, registration, and communication patterns on the SBI.", keyFeatures: ["HTTP/2 as transport protocol for SBI", "NF service registration/discovery via NRF", "Service-based notification mechanism", "Indirect communication via SCP"], specURL: "https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3338", status: .frozen),
        Standard(id: "sba_s2", specNumber: "TS 29.510", title: "NF Repository Function (NRF) Services", release: "Rel-18", workingGroup: "CT3", summary: "Specification of NRF services for NF management, discovery, and OAuth 2.0 token-based authorization on the SBI.", keyFeatures: ["Nnrf_NFManagement service", "Nnrf_NFDiscovery service", "OAuth 2.0 access token issuance", "NF profile and load information"], specURL: "https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3345", status: .frozen),
        Standard(id: "sba_s3", specNumber: "TS 23.700-07", title: "SBA Enhancement Phase 2", release: "Rel-19", workingGroup: "SA2", summary: "Study on SBA enhancements for Rel-19 including SCP enhancements, improved indirect communication, and multi-cloud SBA deployment.", keyFeatures: ["Multi-vendor SCP interoperability", "Edge-cloud SBA topology", "Enhanced SBI reliability mechanisms", "Binding support for indirect communication"], specURL: "https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=4105", status: .study),
    ]

    // MARK: - UPF
    static let upf: [Standard] = [
        Standard(id: "upf_s1", specNumber: "TS 23.501", title: "User Plane Function (UPF) Architecture", release: "Rel-18", workingGroup: "SA2", summary: "Defines UPF role in the 5G architecture including PDU session handling, QoS enforcement, traffic detection, and ULCL/branching point.", keyFeatures: ["GTP-U based user plane protocol stack", "Uplink Classifier (ULCL) for traffic steering", "UPF selection and reselection procedures", "N4 interface between SMF and UPF via PFCP"], specURL: "https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3144", status: .frozen),
        Standard(id: "upf_s2", specNumber: "TS 29.244", title: "Interface Between CP and UP Function (PFCP)", release: "Rel-18", workingGroup: "CT4", summary: "Defines the Packet Forwarding Control Protocol used on the N4 interface between SMF and UPF for session and rule management.", keyFeatures: ["PDR, FAR, QER, URR rule definitions", "Session establishment/modification/deletion", "Usage reporting and volume measurement", "Rel-18 PFCP enhancements for TSN and edge"], specURL: "https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3111", status: .frozen),
    ]

    // MARK: - MEC
    static let mec: [Standard] = [
        Standard(id: "mec_s1", specNumber: "TS 23.548", title: "5G System Enhancements for Edge Computing", release: "Rel-18", workingGroup: "SA2", summary: "Defines EAS Discovery Function (EASDF) and Edge Data Network (EDN) configuration for 5G-MEC integration.", keyFeatures: ["Edge Application Server discovery via EASDF", "DNS-based EAS discovery and traffic routing", "AF-influenced traffic routing to edge UPF", "Edge relocation for mobility scenarios"], specURL: "https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3855", status: .frozen),
    ]

    // MARK: - NWDAF
    static let nwdaf: [Standard] = [
        Standard(id: "nwdaf_s1", specNumber: "TS 23.288", title: "Architecture Enhancements for 5G System to Support Network Data Analytics Services", release: "Rel-18", workingGroup: "SA2", summary: "Core NWDAF specification defining analytics services, MTLF/AnLF decomposition, and ML model provisioning framework.", keyFeatures: ["NWDAF MTLF (Model Training) and AnLF (Analytics) split", "Nnwdaf_AnalyticsSubscription/Info services", "Federated learning framework across NWDAFs", "Analytics IDs: load, mobility, QoS sustainability, UE behavior"], specURL: "https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3579", status: .frozen),
        Standard(id: "nwdaf_s2", specNumber: "TS 23.700-80", title: "Study on NWDAF Phase 4", release: "Rel-19", workingGroup: "SA2", summary: "Rel-19 study on advanced NWDAF features: LLM integration, root cause analysis, energy efficiency analytics, and cross-domain analytics.", keyFeatures: ["LLM/GenAI integration for network insights", "Automated root cause analysis", "Energy efficiency analytics for green networks", "Horizontal NWDAF federation across PLMNs"], specURL: "https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=4133", status: .study),
    ]

    // MARK: - Intent-Based
    static let intentBased: [Standard] = [
        Standard(id: "ibn_s1", specNumber: "TS 28.312", title: "Intent Driven Management Service", release: "Rel-18", workingGroup: "SA5", summary: "Defines intent management framework for 5G networks: intent expression, translation, and fulfillment lifecycle.", keyFeatures: ["Intent object model and lifecycle management", "Intent-to-policy translation framework", "Conflict detection and resolution", "Intent fulfillment and assurance loop"], specURL: "https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3972", status: .frozen),
    ]

    // MARK: - Digital Twin
    static let digitalTwin: [Standard] = [
        Standard(id: "dt_s1", specNumber: "TR 28.917", title: "Study on Digital Twin Network Management", release: "Rel-19", workingGroup: "SA5", summary: "Study on applying digital twin concepts to network management, covering DTN architecture, data models, and simulation interfaces.", keyFeatures: ["DTN reference architecture for 5G management", "Real-time synchronization interfaces", "Simulation and what-if analysis APIs", "Integration with NWDAF for ML-driven twin"], specURL: "https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=4160", status: .study),
    ]

    // MARK: - THz
    static let thz: [Standard] = [
        Standard(id: "thz_s1", specNumber: "ITU-R M.2160", title: "IMT-2030 Framework and Objectives", release: "IMT-2030", workingGroup: "ITU-R WP5D", summary: "ITU-R framework document defining 6G vision, usage scenarios (including THz bands), and target capabilities for IMT-2030.", keyFeatures: ["Peak data rate target: 200 Gbps (THz-enabled)", "Spectrum studies for 92-300 GHz", "Six usage scenarios including immersive communication", "AI-native and sensing as key capabilities"], specURL: "https://www.itu.int/en/ITU-R/study-groups/rsg5/rwp5d/imt-2030/Pages/default.aspx", status: .study),
    ]

    // MARK: - RIS
    static let ris: [Standard] = [
        Standard(id: "ris_s1", specNumber: "TR 38.858", title: "Study on RIS for NR", release: "Rel-19", workingGroup: "RAN1", summary: "3GPP study item on Reconfigurable Intelligent Surfaces evaluating channel modeling, deployment scenarios, and potential specification impact.", keyFeatures: ["RIS channel model for NR frequencies", "Passive vs active RIS evaluation", "RIS-aided coverage extension scenarios", "Impact on existing NR procedures"], specURL: "https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=4200", status: .study),
    ]

    // MARK: - NTN
    static let ntn: [Standard] = [
        Standard(id: "ntn_s1", specNumber: "TS 38.821", title: "Solutions for NR to Support NTN", release: "Rel-17", workingGroup: "RAN2", summary: "Defines NR protocol adaptations for satellite communication including timing advance, HARQ, and mobility procedures for LEO/GEO.", keyFeatures: ["Extended timing advance for satellite RTT", "Disabled HARQ or modified feedback for long delays", "GNSS-based UE positioning for Doppler pre-compensation", "Earth-fixed vs satellite-fixed cell definition"], specURL: "https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3525", status: .frozen),
        Standard(id: "ntn_s2", specNumber: "TS 23.737", title: "Architecture Aspects for NTN in 5G Core", release: "Rel-18", workingGroup: "SA2", summary: "Defines 5G Core architecture extensions for NTN including satellite-aware AMF, SMF enhancements, and NTN-specific mobility.", keyFeatures: ["Satellite backhaul-aware NF selection", "NTN-specific registration/mobility procedures", "Store-and-forward for IoT NTN", "Multi-connectivity terrestrial+satellite"], specURL: "https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3910", status: .frozen),
    ]

    // MARK: - ISAC
    static let isac: [Standard] = [
        Standard(id: "isac_s1", specNumber: "TR 22.837", title: "Study on Integrated Sensing and Communication", release: "Rel-19", workingGroup: "SA1", summary: "Service requirements study for ISAC identifying use cases: object detection, environmental monitoring, gesture recognition, and localization.", keyFeatures: ["Sensing as a network service", "Mono-static, bi-static, multi-static sensing modes", "Privacy requirements for sensing data", "Sensing accuracy and latency KPIs"], specURL: "https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=4120", status: .study),
    ]

    // MARK: - Semantic Communications
    static let semanticComms: [Standard] = [
        Standard(id: "sem_s1", specNumber: "ITU-T FG-AN", title: "Focus Group on Autonomous Networks — Semantic Communication", release: "Pre-standard", workingGroup: "ITU-T SG13", summary: "ITU-T focus group studying semantic communication framework, knowledge base management, and semantic-aware network protocols.", keyFeatures: ["Semantic encoder/decoder framework", "Shared knowledge base management", "Semantic-aware QoS metrics", "Integration with AI-native network architecture"], specURL: "https://www.itu.int/en/ITU-T/focusgroups/an/Pages/default.aspx", status: .study),
    ]

    // MARK: - Zero Trust
    static let zeroTrust: [Standard] = [
        Standard(id: "zt_s1", specNumber: "TS 33.501", title: "Security Architecture and Procedures for 5G System", release: "Rel-18", workingGroup: "SA3", summary: "Comprehensive 5G security specification covering authentication (5G-AKA, EAP), NF authorization (OAuth 2.0), SBI security (TLS), and subscriber privacy (SUPI/SUCI).", keyFeatures: ["5G-AKA and EAP-AKA' authentication", "SUPI concealment via SUCI with ECIES", "OAuth 2.0 NF authorization on SBI", "TLS 1.3 mandatory for SBI interfaces", "SEPP for inter-PLMN security"], specURL: "https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3169", status: .frozen),
    ]

    // MARK: - NEF/CAPIF
    static let networkExposure: [Standard] = [
        Standard(id: "ne_s1", specNumber: "TS 23.222", title: "Common API Framework (CAPIF)", release: "Rel-18", workingGroup: "CT3", summary: "Defines the framework for API exposure including API publishing, discovery, authentication, authorization, and logging for third-party access.", keyFeatures: ["CAPIF core function for API lifecycle management", "API invoker authentication and authorization", "API publishing, discovery, and event notification", "Service API routing and topology hiding"], specURL: "https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3337", status: .frozen),
        Standard(id: "ne_s2", specNumber: "TS 29.522", title: "NEF Northbound APIs", release: "Rel-18", workingGroup: "CT3", summary: "Defines Network Exposure Function APIs for traffic influence, monitoring events, QoS management, and analytics exposure to AFs.", keyFeatures: ["AF traffic influence on UPF routing", "Monitoring event subscriptions (UE reachability, location)", "QoS and policy parameter provisioning", "NWDAF analytics exposure to third parties"], specURL: "https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3437", status: .frozen),
    ]
}
