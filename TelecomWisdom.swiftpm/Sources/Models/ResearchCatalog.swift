import Foundation

struct ResearchCatalog {

    // MARK: - Network Slicing
    static let networkSlicing: [ResearchItem] = [
        ResearchItem(id: "ns_r1", title: "Network Slicing for 5G and Beyond: A Survey", authors: "X. Foukas, G. Patounas, A. Elmokashfi, M. Marina", source: "IEEE Communications Surveys & Tutorials", year: 2017, summary: "Comprehensive survey covering end-to-end network slicing architecture, resource isolation techniques, and management challenges across RAN, transport, and core.", keyFindings: ["Isolation between slices is critical for SLA guarantees", "Dynamic slice lifecycle management is a key research gap", "Cross-domain orchestration remains an open challenge"], sourceURL: "https://ieeexplore.ieee.org/document/8004168", status: .activeResearch),
        ResearchItem(id: "ns_r2", title: "An Overview of Network Slicing for 5G", authors: "GSMA", source: "GSMA Whitepaper", year: 2021, summary: "Industry perspective on network slicing deployment, covering business models, interoperability, roaming, and enterprise use cases.", keyFindings: ["Enterprise slicing is the primary revenue driver", "Slice SLA assurance requires AI-based analytics", "Inter-operator slice federation is critical for roaming"], sourceURL: "https://www.gsma.com/futurenetworks/resources/network-slicing-overview", status: .deployment),
        ResearchItem(id: "ns_r3", title: "Dynamic Network Slicing with NWDAF-Assisted Closed-Loop Automation", authors: "ETSI ZSM ISG", source: "ETSI GR ZSM 009-3", year: 2024, summary: "Study on zero-touch slice management using NWDAF analytics for real-time SLA monitoring and autonomous slice scaling.", keyFindings: ["Closed-loop latency under 100ms is achievable", "NWDAF slice-level analytics enable predictive scaling", "Intent-based slice management reduces OPEX by 35%"], sourceURL: "https://www.etsi.org/deliver/etsi_gr/ZSM/001_099/009/", status: .activeResearch),
    ]

    // MARK: - SBA
    static let sba: [ResearchItem] = [
        ResearchItem(id: "sba_r1", title: "5G Service Based Architecture: Design Principles and Implementation", authors: "3GPP SA2, Ericsson, Nokia, Huawei", source: "3GPP TR 23.501 Background", year: 2018, summary: "Foundational design of the 5G Core SBA with HTTP/2-based service interfaces, service discovery via NRF, and microservice decomposition.", keyFindings: ["RESTful APIs replace legacy Diameter/GTP-C interfaces", "NRF enables dynamic service discovery and load balancing", "Service mesh patterns from IT are applicable to telco"], sourceURL: "https://www.3gpp.org/specifications/79-specification-numbering", status: .mature),
        ResearchItem(id: "sba_r2", title: "Cloud-Native 5G Core: From Monolith to Microservices", authors: "Linux Foundation Networking", source: "LFN Whitepaper", year: 2023, summary: "Analysis of cloud-native transformation of 5G Core NFs, covering Kubernetes orchestration, service mesh, observability, and CI/CD for telecom.", keyFindings: ["Kubernetes is the de facto platform for 5G CNFs", "Service mesh (Istio/Envoy) critical for inter-NF security", "GitOps practices reducing deployment errors by 60%"], sourceURL: "https://www.lfnetworking.org/resources/", status: .deployment),
    ]

    // MARK: - UPF
    static let upf: [ResearchItem] = [
        ResearchItem(id: "upf_r1", title: "User Plane Function Acceleration with SmartNICs and DPDK", authors: "Intel, NVIDIA, Ericsson", source: "Intel Whitepaper", year: 2023, summary: "Performance analysis of UPF implementations using DPDK, SR-IOV, and SmartNIC offload for achieving 100Gbps+ throughput.", keyFindings: ["DPDK-based UPFs achieve 10x throughput vs kernel path", "SmartNIC offload reduces CPU consumption by 40%", "P4-programmable switches enable UPF-as-a-pipeline"], sourceURL: "https://www.intel.com/content/www/us/en/communications/5g-network-infrastructure.html", status: .deployment),
        ResearchItem(id: "upf_r2", title: "Distributed UPF Architecture for Edge Computing", authors: "5G-ACIA", source: "5G-ACIA Whitepaper", year: 2024, summary: "Architecture for deploying UPF at the edge for industrial IoT, covering ULCL (Uplink Classifier) and local breakout scenarios.", keyFindings: ["Edge UPF reduces latency from 20ms to 1ms for industrial use cases", "ULCL enables selective traffic steering to local/central paths", "Multi-UPF session management requires enhanced SMF"], sourceURL: "https://www.5g-acia.org/publications/", status: .trial),
    ]

    // MARK: - MEC
    static let mec: [ResearchItem] = [
        ResearchItem(id: "mec_r1", title: "Multi-access Edge Computing (MEC) in 5G Networks", authors: "ETSI MEC ISG", source: "ETSI GS MEC 003", year: 2022, summary: "Framework for MEC integration with 5G Core, covering MEC platform APIs, application lifecycle management, and service orchestration.", keyFindings: ["MEC enables sub-10ms application latency", "5G-MEC integration via NEF/AF provides network awareness", "MEC federation needed for mobility across edge sites"], sourceURL: "https://www.etsi.org/technologies/multi-access-edge-computing", status: .deployment),
    ]

    // MARK: - NWDAF
    static let nwdaf: [ResearchItem] = [
        ResearchItem(id: "nwdaf_r1", title: "AI/ML in 5G Core Network: NWDAF Architecture and Use Cases", authors: "3GPP SA2, SA5", source: "3GPP TR 23.700-81", year: 2023, summary: "Study on NWDAF enhancements for Rel-18 including federated learning, model transfer between NWDAFs, and horizontal/vertical NWDAF split.", keyFindings: ["NWDAF MTLF/AnLF split enables scalable ML deployment", "Federated learning preserves data privacy across operators", "Rel-18 adds real-time analytics for dynamic slicing"], sourceURL: "https://www.3gpp.org/ftp/Specs/archive/23_series/23.700-81/", status: .standardization),
        ResearchItem(id: "nwdaf_r2", title: "6G AI-Native Network Architecture", authors: "Samsung Research, Nokia Bell Labs", source: "IEEE Network Magazine", year: 2024, summary: "Vision for 6G where AI is a first-class citizen in the network architecture, with distributed inference, on-device AI, and network-AI co-design.", keyFindings: ["6G network architecture must be designed for AI from scratch", "Distributed AI across device-edge-cloud is essential", "AI energy consumption is a key 6G design constraint"], sourceURL: "https://ieeexplore.ieee.org/xpl/RecentIssue.jsp?punumber=65", status: .earlyResearch),
        ResearchItem(id: "nwdaf_r3", title: "Closed-Loop Network Automation Using NWDAF Analytics", authors: "Ericsson Research, ETSI ZSM", source: "ETSI ZSM Whitepaper", year: 2024, summary: "Framework for autonomous network operations using NWDAF analytics driving closed-loop actions through PCF, NSSF, and AMF.", keyFindings: ["Closed-loop automation reduces MTTR by 70%", "Anomaly detection accuracy exceeds 95% with NWDAF", "Intent-based policies bridge operator goals and automation actions"], sourceURL: "https://www.etsi.org/technologies/zero-touch-network-service-management", status: .activeResearch),
    ]

    // MARK: - Intent-Based Networking
    static let intentBased: [ResearchItem] = [
        ResearchItem(id: "ibn_r1", title: "Intent-Based Networking for 5G and Beyond", authors: "TM Forum, ETSI ZSM", source: "TM Forum TR 290", year: 2023, summary: "Framework for intent-driven network management where operators express business objectives and the system autonomously translates to configurations.", keyFindings: ["Intent decomposition uses AI to map business goals to network config", "Conflict resolution between intents is an open research area", "Natural language intent interfaces are emerging"], sourceURL: "https://www.tmforum.org/resources/", status: .activeResearch),
    ]

    // MARK: - Digital Twin
    static let digitalTwin: [ResearchItem] = [
        ResearchItem(id: "dt_r1", title: "Digital Twin Network: Concepts and Reference Architecture", authors: "ITU-T FG-NET2030", source: "ITU-T Y.3090", year: 2023, summary: "ITU-T framework defining digital twin network architecture, data models, and interfaces for network simulation and optimization.", keyFindings: ["DTN requires real-time synchronization with physical network", "ML models trained on DTN reduce outages by 60%", "DTN enables what-if analysis for capacity planning"], sourceURL: "https://www.itu.int/en/ITU-T/focusgroups/net2030/", status: .standardization),
        ResearchItem(id: "dt_r2", title: "Network Digital Twin for 6G: Vision and Challenges", authors: "China Mobile, Huawei, ZTE", source: "IMT-2030 (6G) Promotion Group", year: 2024, summary: "Vision for network digital twins in 6G including AI-driven twin construction, multi-domain twin federation, and twin-in-the-loop optimization.", keyFindings: ["6G DTN must handle 100x more network elements than 5G", "Federated DTN across operators enables ecosystem optimization", "Twin-in-the-loop replaces human-in-the-loop for network ops"], sourceURL: "https://www.imt2030.org.cn/", status: .earlyResearch),
    ]

    // MARK: - THz Communications
    static let thz: [ResearchItem] = [
        ResearchItem(id: "thz_r1", title: "THz Communications for 6G: Challenges and Opportunities", authors: "T. Kurner, A. Fricke, Nokia Bell Labs", source: "IEEE Communications Magazine", year: 2024, summary: "Survey of THz technology maturity covering channel modeling, device capabilities, antenna design, and system-level feasibility for 6G.", keyFindings: ["THz enables 100+ Gbps peak data rates", "Atmospheric absorption limits range to 10-100m outdoors", "III-V semiconductor devices reaching 1 THz operation", "Beam management at THz is orders of magnitude more challenging"], sourceURL: "https://ieeexplore.ieee.org/xpl/RecentIssue.jsp?punumber=35", status: .earlyResearch),
    ]

    // MARK: - RIS
    static let ris: [ResearchItem] = [
        ResearchItem(id: "ris_r1", title: "Reconfigurable Intelligent Surfaces: Bridging the Gap Between Scattering and Reflection", authors: "E. Basar, M. Di Renzo, J. de Rosny", source: "IEEE JSAC", year: 2023, summary: "Comprehensive study on RIS channel modeling, hardware prototypes, and system-level performance for 5G-Advanced and 6G.", keyFindings: ["RIS can extend coverage by 40% in urban environments", "256-element RIS prototypes demonstrated 15dB gain", "RIS-aided MIMO achieves near-optimal performance with low-cost elements"], sourceURL: "https://ieeexplore.ieee.org/xpl/RecentIssue.jsp?punumber=49", status: .activeResearch),
    ]

    // MARK: - NTN
    static let ntn: [ResearchItem] = [
        ResearchItem(id: "ntn_r1", title: "5G Non-Terrestrial Networks: Integration of Satellite and 5G", authors: "3GPP, ESA, Thales", source: "3GPP TR 38.811 / TR 23.737", year: 2023, summary: "Study on NTN architecture for 5G including LEO/GEO satellite integration, NR-NTN waveform adaptation, and core network impacts.", keyFindings: ["LEO satellites achieve 30-50ms RTT feasible for 5G services", "Modified HARQ needed for long propagation delays", "GNSS-independent positioning for NTN UEs is key research area"], sourceURL: "https://www.3gpp.org/technologies/ntn", status: .standardization),
        ResearchItem(id: "ntn_r2", title: "Direct-to-Device Satellite Communications for 6G", authors: "Qualcomm, SpaceX, 3GPP", source: "Qualcomm Whitepaper", year: 2024, summary: "Vision for direct satellite-to-smartphone communication without specialized equipment, covering spectrum sharing, link budget, and protocol adaptation.", keyFindings: ["D2D satellite requires NR modifications for extreme delay/Doppler", "LEO mega-constellations enable global sub-second connectivity", "Spectrum coordination between terrestrial and satellite is critical"], sourceURL: "https://www.qualcomm.com/research/5g/non-terrestrial-networks", status: .trial),
    ]

    // MARK: - ISAC
    static let isac: [ResearchItem] = [
        ResearchItem(id: "isac_r1", title: "Integrated Sensing and Communication for 6G", authors: "F. Liu, Y. Cui, C. Masouros", source: "IEEE JSAC Special Issue", year: 2024, summary: "Framework for joint communication and sensing waveform design, covering OFDM-based sensing, MIMO radar-communication, and resource allocation.", keyFindings: ["ISAC can achieve radar-grade sensing with minimal throughput loss", "Joint beamforming optimizes sensing accuracy and communication rate", "Sub-meter positioning accuracy achievable with 5G-Advanced signals"], sourceURL: "https://ieeexplore.ieee.org/xpl/RecentIssue.jsp?punumber=49", status: .earlyResearch),
    ]

    // MARK: - Semantic Communications
    static let semanticComms: [ResearchItem] = [
        ResearchItem(id: "sem_r1", title: "Semantic Communication: A Survey of Theory and Applications", authors: "Q. Lan, D. Wen, Z. Zhang", source: "IEEE Communications Surveys & Tutorials", year: 2024, summary: "Survey of semantic communication from Shannon-Weaver model evolution to modern deep learning-based semantic codecs for text, image, and speech.", keyFindings: ["Semantic coding achieves 10x compression vs traditional methods", "Task-oriented semantic comms outperform bit-level in goal-directed tasks", "Shared knowledge base between Tx/Rx is the core enabler"], sourceURL: "https://ieeexplore.ieee.org/xpl/RecentIssue.jsp?punumber=9739", status: .conceptual),
    ]

    // MARK: - Zero Trust
    static let zeroTrust: [ResearchItem] = [
        ResearchItem(id: "zt_r1", title: "Zero Trust Architecture for 5G Core Networks", authors: "GSMA, ENISA", source: "GSMA FS.40", year: 2023, summary: "Guidelines for applying zero-trust principles to 5G SBA, covering API gateway security, mTLS, OAuth 2.0, service mesh, and micro-segmentation.", keyFindings: ["Every NF-to-NF call must be authenticated and authorized", "Service mesh enables zero-trust without NF code changes", "API rate limiting critical for DoS protection on SBI"], sourceURL: "https://www.gsma.com/security/resources/", status: .deployment),
    ]

    // MARK: - NEF/CAPIF
    static let networkExposure: [ResearchItem] = [
        ResearchItem(id: "ne_r1", title: "CAMARA Project: Open Network APIs for Developers", authors: "GSMA, Linux Foundation", source: "CAMARA Project", year: 2024, summary: "Industry initiative to create standardized, operator-agnostic network APIs for QoS, location, device status, and network slicing exposure.", keyFindings: ["CAMARA defines 15+ APIs across QoD, location, and slicing", "Federated API model enables cross-operator service exposure", "Developer adoption requires simplified OAuth-based onboarding"], sourceURL: "https://camaraproject.org/", status: .activeResearch),
    ]
}
