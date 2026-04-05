import Foundation

// MARK: - Content Fetcher — Auto-Update Engine

actor ContentFetcher {
    static let shared = ContentFetcher()

    private let session: URLSession
    private let decoder = JSONDecoder()
    private let refreshInterval: TimeInterval = 24 * 60 * 60 // 24 hours

    init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        config.waitsForConnectivity = true
        self.session = URLSession(configuration: config)
    }

    // MARK: - 3GPP Spec Fetch

    struct ThreeGPPSpecResult: Codable {
        let specNumber: String
        let title: String
        let release: String
        let status: String
        let lastUpdate: String?
    }

    func fetch3GPPSpecInfo(specNumber: String) async -> ThreeGPPSpecResult? {
        let urlString = "https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=\(specNumber)"
        // Attempt to scrape basic info from 3GPP portal
        guard let url = URL(string: "https://www.3gpp.org/dynareport?code=\(specNumber)") else { return nil }
        do {
            let (data, response) = try await session.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let html = String(data: data, encoding: .utf8) else { return nil }
            return parse3GPPPage(html: html, specNumber: specNumber)
        } catch {
            return nil
        }
    }

    private func parse3GPPPage(html: String, specNumber: String) -> ThreeGPPSpecResult? {
        // Basic HTML parsing for title and status
        let title = extractBetween(html, start: "<title>", end: "</title>") ?? specNumber
        let status = html.contains("Frozen") ? "Frozen" : html.contains("Draft") ? "Draft" : "Active"
        return ThreeGPPSpecResult(specNumber: specNumber, title: title, release: "", status: status, lastUpdate: nil)
    }

    // MARK: - 3GPP Meeting Documents Fetch

    struct MeetingDocResult: Codable {
        let tdocNumber: String
        let title: String
        let source: String
        let meetingDate: String
    }

    func fetchRecentMeetingDocs(workingGroup: String) async -> [MeetingDocResult] {
        // Fetch from 3GPP FTP/portal for recent TDocs
        let wgPath: String
        switch workingGroup.lowercased() {
        case "sa2": wgPath = "tsg_sa/WG2_Arch"
        case "sa3": wgPath = "tsg_sa/WG3_Security"
        case "sa5": wgPath = "tsg_sa/WG5_TM"
        case "ct3": wgPath = "tsg_ct/WG3_interworking"
        case "ct4": wgPath = "tsg_ct/WG4_protocollars_ex-CN4"
        case "ran1": wgPath = "tsg_ran/WG1_RL1"
        default: wgPath = "tsg_sa/WG2_Arch"
        }

        guard let url = URL(string: "https://www.3gpp.org/ftp/\(wgPath)/") else { return [] }
        do {
            let (data, response) = try await session.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let html = String(data: data, encoding: .utf8) else { return [] }
            return parseMeetingIndex(html: html, workingGroup: workingGroup)
        } catch {
            return []
        }
    }

    private func parseMeetingIndex(html: String, workingGroup: String) -> [MeetingDocResult] {
        // Parse FTP directory listing for recent meeting folders
        var results: [MeetingDocResult] = []
        let links = extractAllBetween(html, start: "href=\"", end: "\"")
        for link in links.suffix(5) where link.contains("TSGS") || link.contains("meeting") {
            results.append(MeetingDocResult(
                tdocNumber: link,
                title: "Recent \(workingGroup) meeting document",
                source: workingGroup,
                meetingDate: ""
            ))
        }
        return results
    }

    // MARK: - Research Paper Fetch (arXiv/IEEE)

    struct ArxivResult: Codable {
        let title: String
        let authors: String
        let summary: String
        let published: String
        let link: String
    }

    func fetchLatestResearch(query: String, maxResults: Int = 5) async -> [ArxivResult] {
        let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        guard let url = URL(string: "https://export.arxiv.org/api/query?search_query=all:\(encoded)&start=0&max_results=\(maxResults)&sortBy=submittedDate&sortOrder=descending") else { return [] }

        do {
            let (data, _) = try await session.data(from: url)
            guard let xml = String(data: data, encoding: .utf8) else { return [] }
            return parseArxivFeed(xml: xml)
        } catch {
            return []
        }
    }

    private func parseArxivFeed(xml: String) -> [ArxivResult] {
        var results: [ArxivResult] = []
        let entries = xml.components(separatedBy: "<entry>").dropFirst()

        for entry in entries.prefix(5) {
            let title = extractBetween(entry, start: "<title>", end: "</title>")?
                .replacingOccurrences(of: "\n", with: " ")
                .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let summary = extractBetween(entry, start: "<summary>", end: "</summary>")?
                .replacingOccurrences(of: "\n", with: " ")
                .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let published = extractBetween(entry, start: "<published>", end: "</published>") ?? ""
            let link = extractBetween(entry, start: "<id>", end: "</id>") ?? ""

            // Extract authors
            var authors: [String] = []
            let authorBlocks = entry.components(separatedBy: "<author>").dropFirst()
            for block in authorBlocks.prefix(3) {
                if let name = extractBetween(block, start: "<name>", end: "</name>") {
                    authors.append(name)
                }
            }
            let authorStr = authors.joined(separator: ", ") + (authorBlocks.count > 3 ? " et al." : "")

            if !title.isEmpty {
                results.append(ArxivResult(title: title, authors: authorStr, summary: String(summary.prefix(300)), published: String(published.prefix(10)), link: link))
            }
        }
        return results
    }

    // MARK: - GSMA / Industry News Fetch

    func fetchGSMAUpdates(topic: String) async -> [(title: String, url: String)] {
        guard let url = URL(string: "https://www.gsma.com/futurenetworks/") else { return [] }
        do {
            let (data, response) = try await session.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let html = String(data: data, encoding: .utf8) else { return [] }
            let links = extractAllBetween(html, start: "<a href=\"", end: "\"")
                .filter { $0.contains(topic.lowercased().replacingOccurrences(of: " ", with: "-")) }
                .prefix(5)
            return links.map { (title: $0.components(separatedBy: "/").last ?? $0, url: $0) }
        } catch {
            return []
        }
    }

    // MARK: - Aggregate Refresh for a Service

    func refreshService(_ service: TelecomService) async -> TelecomService {
        var updated = service

        // Fetch latest research from arXiv
        let searchQuery = "\(service.name) 5G 6G 3GPP"
        let arxivResults = await fetchLatestResearch(query: searchQuery, maxResults: 3)

        for (i, result) in arxivResults.enumerated() {
            let newItem = ResearchItem(
                id: "\(service.id)_live_\(i)",
                title: result.title,
                authors: result.authors,
                source: "arXiv (Auto-fetched)",
                year: Calendar.current.component(.year, from: Date()),
                summary: result.summary,
                keyFindings: ["Auto-fetched from arXiv — review for key findings"],
                sourceURL: result.link,
                status: .activeResearch
            )
            // Only add if not duplicate
            if !updated.researchItems.contains(where: { $0.title == newItem.title }) {
                updated.researchItems.append(newItem)
            }
        }

        // Fetch recent meeting documents
        let mainWG = service.standards.first?.workingGroup ?? "SA2"
        let meetingDocs = await fetchRecentMeetingDocs(workingGroup: mainWG)
        // Meeting docs added as supplementary info
        for (i, doc) in meetingDocs.prefix(2).enumerated() {
            let newMeeting = MeetingDiscussion(
                id: "\(service.id)_live_m\(i)",
                meetingNumber: "Recent",
                workingGroup: mainWG,
                date: doc.meetingDate.isEmpty ? "2024-latest" : doc.meetingDate,
                topic: "\(service.name) — Recent Update",
                summary: "Auto-fetched from 3GPP \(mainWG) — \(doc.tdocNumber). Check source for latest discussion details.",
                keyDecisions: ["See source document for details"],
                tdocReferences: [doc.tdocNumber],
                sourceURL: "https://www.3gpp.org/ftp/\(doc.tdocNumber)"
            )
            if !updated.meetingDiscussions.contains(where: { $0.id == newMeeting.id }) {
                updated.meetingDiscussions.append(newMeeting)
            }
        }

        updated.lastUpdated = Date()
        return updated
    }

    // MARK: - HTML Parsing Helpers

    private func extractBetween(_ text: String, start: String, end: String) -> String? {
        guard let startRange = text.range(of: start),
              let endRange = text.range(of: end, range: startRange.upperBound..<text.endIndex) else { return nil }
        return String(text[startRange.upperBound..<endRange.lowerBound])
    }

    private func extractAllBetween(_ text: String, start: String, end: String) -> [String] {
        var results: [String] = []
        var searchRange = text.startIndex..<text.endIndex
        while let startRange = text.range(of: start, range: searchRange),
              let endRange = text.range(of: end, range: startRange.upperBound..<text.endIndex) {
            results.append(String(text[startRange.upperBound..<endRange.lowerBound]))
            searchRange = endRange.upperBound..<text.endIndex
        }
        return results
    }
}
