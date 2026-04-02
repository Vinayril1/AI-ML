import Foundation

// MARK: - Text Analysis Result

struct TextAnalysis {
    let wordCount: Int
    let sentenceCount: Int
    let avgSentenceLength: Double
    let fillerCount: Int
    let weakPhrases: [String]
    let strongPhrases: [String]
    let transitionsFound: [String]
    let techTermsUsed: [String]
    let vocabularyRichness: Double
}

// MARK: - Score Result

struct ScoreResult: Codable {
    var clarity: Int
    var structure: Int
    var technicalAccuracy: Int
    var persuasiveness: Int
    var conciseness: Int
    var overall: Double

    var asDictionary: [(dimension: ScoringDimension, score: Int)] {
        [
            (.clarity, clarity),
            (.structure, structure),
            (.technicalAccuracy, technicalAccuracy),
            (.persuasiveness, persuasiveness),
            (.conciseness, conciseness),
        ]
    }

    func rating(for score: Int) -> String {
        if score >= 80 { return "Excellent" }
        if score >= 60 { return "Good" }
        if score >= 40 { return "Fair" }
        return "Needs Work"
    }
}

// MARK: - Scoring Engine

class ScoringEngine {
    static let shared = ScoringEngine()

    private let fillerWords = [
        "um", "uh", "like", "you know", "basically", "actually", "sort of",
        "kind of", "i mean", "right", "so yeah", "honestly", "literally",
    ]

    private let weakPhrases = [
        "i think maybe", "i'm not sure but", "this might be wrong",
        "i guess", "probably", "hopefully", "if that makes sense",
        "does that make sense", "sorry but",
    ]

    private let strongPhrases = [
        "i recommend", "the data shows", "based on our analysis",
        "the key benefit is", "this ensures", "this enables",
        "the strategic advantage", "our approach delivers",
        "the evidence suggests", "let me walk you through",
        "here is what i propose", "the impact will be",
    ]

    private let transitionPhrases = [
        "first", "second", "third", "next", "finally",
        "moreover", "furthermore", "in addition",
        "however", "on the other hand", "conversely",
        "therefore", "consequently", "as a result",
        "in summary", "to conclude", "in conclusion",
        "for example", "specifically", "in particular",
    ]

    // MARK: - Analysis

    func analyze(_ text: String) -> TextAnalysis {
        let lower = text.lowercased()
        let words = lower.split(separator: " ").map(String.init)
        let wordCount = words.count
        let sentences = text.split(omittingEmptySubsequences: true) { ".!?".contains($0) }
        let sentenceCount = max(sentences.count, 1)
        let avgSentenceLength = Double(wordCount) / Double(sentenceCount)

        let fillerCount = fillerWords.reduce(0) { $0 + lower.countOccurrences(of: $1) }
        let weakFound = weakPhrases.filter { lower.contains($0) }
        let strongFound = strongPhrases.filter { lower.contains($0) }
        let transitionsFound = transitionPhrases.filter { lower.contains($0) }

        let techTerms = TelecomDomain.technologies.filter { lower.contains($0.lowercased()) }

        let uniqueWords = Set(words).count
        let richness = Double(uniqueWords) / max(Double(wordCount), 1.0)

        return TextAnalysis(
            wordCount: wordCount,
            sentenceCount: sentenceCount,
            avgSentenceLength: avgSentenceLength.rounded(toPlaces: 1),
            fillerCount: fillerCount,
            weakPhrases: weakFound,
            strongPhrases: strongFound,
            transitionsFound: transitionsFound,
            techTermsUsed: techTerms,
            vocabularyRichness: richness.rounded(toPlaces: 2)
        )
    }

    // MARK: - Scoring

    func computeScores(_ analysis: TextAnalysis, exerciseType: String = "general") -> ScoreResult {
        // Clarity
        var clarity = 70
        if analysis.avgSentenceLength < 20 { clarity += 10 }
        else if analysis.avgSentenceLength > 30 { clarity -= 15 }
        clarity -= analysis.fillerCount * 5
        clarity += min(analysis.transitionsFound.count * 5, 20)
        clarity = clarity.clamped(to: 0...100)

        // Structure
        var structure = 50
        structure += min(analysis.transitionsFound.count * 8, 30)
        if analysis.sentenceCount >= 3 { structure += 10 }
        if analysis.wordCount >= 50 { structure += 10 }
        structure = structure.clamped(to: 0...100)

        // Technical accuracy
        var tech = 50
        tech += min(analysis.techTermsUsed.count * 10, 40)
        if ["presentation", "negotiation"].contains(exerciseType) && analysis.techTermsUsed.count >= 2 {
            tech += 10
        }
        tech = tech.clamped(to: 0...100)

        // Persuasiveness
        var persuasion = 50
        persuasion += analysis.strongPhrases.count * 10
        persuasion -= analysis.weakPhrases.count * 10
        persuasion += min(analysis.transitionsFound.count * 3, 15)
        persuasion = persuasion.clamped(to: 0...100)

        // Conciseness
        var conciseness = 70
        if analysis.avgSentenceLength > 25 { conciseness -= 15 }
        if analysis.fillerCount > 2 { conciseness -= 15 }
        if analysis.wordCount > 500 { conciseness -= 10 }
        else if analysis.wordCount < 20 { conciseness -= 20 }
        conciseness = conciseness.clamped(to: 0...100)

        let overall = Double(clarity) * 0.25 + Double(structure) * 0.20 +
                      Double(tech) * 0.20 + Double(persuasion) * 0.20 +
                      Double(conciseness) * 0.15

        return ScoreResult(
            clarity: clarity,
            structure: structure,
            technicalAccuracy: tech,
            persuasiveness: persuasion,
            conciseness: conciseness,
            overall: overall.rounded(toPlaces: 1)
        )
    }

    // MARK: - Feedback

    func generateFeedback(_ analysis: TextAnalysis, scores: ScoreResult) -> [String] {
        var tips: [String] = []

        if analysis.fillerCount > 0 {
            tips.append("Reduce filler words (\(analysis.fillerCount) detected). Replace with deliberate pauses or transition phrases.")
        }
        if !analysis.weakPhrases.isEmpty {
            let examples = analysis.weakPhrases.prefix(3).map { "\"\($0)\"" }.joined(separator: ", ")
            tips.append("Avoid hedging language: \(examples). Use confident assertions backed by data.")
        }
        if analysis.strongPhrases.isEmpty {
            tips.append("Use assertive phrases like \"I recommend...\", \"The data shows...\", \"Our approach delivers...\"")
        }
        if analysis.transitionsFound.count < 2 {
            tips.append("Add transition phrases (first, moreover, therefore) to improve logical flow.")
        }
        if analysis.techTermsUsed.isEmpty {
            tips.append("Incorporate relevant technical terms (Network Slicing, SBA, NWDAF) to demonstrate domain expertise.")
        }
        if analysis.avgSentenceLength > 28 {
            tips.append("Sentences average \(Int(analysis.avgSentenceLength)) words — aim for 15-20 for better comprehension.")
        }
        if scores.persuasiveness < 60 {
            tips.append("Lead with benefits, use concrete numbers, and tie technical features to business outcomes.")
        }
        if scores.structure < 60 {
            tips.append("Use a clear opening statement, organized body points, and a strong conclusion with call to action.")
        }
        if tips.isEmpty {
            tips.append("Excellent work! Your communication is clear, structured, and persuasive.")
        }
        return tips
    }

    // MARK: - Presentation-Specific

    func evaluatePresentation(_ text: String) -> (structureScore: Int, feedback: [String]) {
        let lower = text.lowercased()
        let hasOpening = ["today i", "let me", "i'd like to", "good morning", "good afternoon", "thank you for", "welcome"].contains(where: { lower.contains($0) })
        let hasBody = text.split(omittingEmptySubsequences: true) { $0 == "." }.count >= 3
        let hasConclusion = ["in conclusion", "to summarize", "in summary", "to wrap up", "key takeaway", "next steps", "call to action", "finally", "i recommend", "let's move forward"].contains(where: { lower.contains($0) })
        let hasTransitions = ["first", "second", "next", "moreover", "furthermore", "however", "therefore", "moving on"].contains(where: { lower.contains($0) })

        let score = (hasOpening ? 25 : 0) + (hasBody ? 25 : 0) + (hasConclusion ? 25 : 0) + (hasTransitions ? 25 : 0)

        var feedback: [String] = []
        if !hasOpening { feedback.append("Add a strong opening — greet audience and state your purpose.") }
        if !hasTransitions { feedback.append("Use transition phrases to guide the audience through your points.") }
        if !hasConclusion { feedback.append("Include a clear conclusion with summary or call to action.") }
        return (score, feedback)
    }

    // MARK: - Negotiation-Specific

    func evaluateNegotiation(_ text: String) -> (score: Int, tone: String, feedback: [String], hasData: Bool, hasBATNA: Bool) {
        let lower = text.lowercased()

        let assertiveCount = ["i propose", "we need", "our requirement is", "i recommend", "the fair value is", "based on our analysis", "we expect", "our position is", "let me suggest"].filter { lower.contains($0) }.count
        let aggressiveCount = ["you must", "take it or leave it", "non-negotiable", "we won't accept", "that's unacceptable", "absolutely not"].filter { lower.contains($0) }.count
        let collaborativeCount = ["how can we", "what if we", "i understand your", "let's explore", "mutual benefit", "win-win", "together", "partnership", "i appreciate", "fair to both", "common ground"].filter { lower.contains($0) }.count

        let hasData = ["percent", "%", "data shows", "analysis", "benchmark", "report", "roi", "tco", "cost", "revenue"].contains(where: { lower.contains($0) })
        let hasBATNA = ["alternative", "other option", "other vendor", "competitor", "other bid", "evaluated"].contains(where: { lower.contains($0) })

        let tone: String
        if aggressiveCount > assertiveCount {
            tone = "Too Aggressive — risk damaging relationship"
        } else if assertiveCount == 0 && collaborativeCount == 0 {
            tone = "Too Passive — risk being taken advantage of"
        } else if collaborativeCount > 0 && assertiveCount > 0 {
            tone = "Balanced — assertive yet collaborative (ideal)"
        } else if collaborativeCount > assertiveCount {
            tone = "Collaborative — good, but ensure your interests are met"
        } else {
            tone = "Assertive — strong, consider adding collaborative elements"
        }

        var feedback: [String] = []
        if !hasData { feedback.append("Strengthen with specific data, benchmarks, or ROI figures.") }
        if aggressiveCount > 0 { feedback.append("Soften aggressive language — use firm-but-fair proposals.") }
        if collaborativeCount == 0 { feedback.append("Add collaborative language to build trust.") }
        if !hasBATNA { feedback.append("Reference your alternatives to strengthen your position.") }
        if assertiveCount == 0 { feedback.append("Be more assertive — clearly state requirements.") }

        var score = 50
        score += assertiveCount * 8
        score += collaborativeCount * 7
        score -= aggressiveCount * 10
        score += hasData ? 15 : 0
        score += hasBATNA ? 10 : 0
        score = score.clamped(to: 0...100)

        return (score, tone, feedback, hasData, hasBATNA)
    }

    // MARK: - Leadership-Specific

    func evaluateLeadership(_ text: String) -> (score: Int, qualities: [(String, Bool)], feedback: [String]) {
        let lower = text.lowercased()

        let empathy = ["i understand", "i appreciate", "i hear you", "i recognize", "their perspective", "empathize", "concern", "well-being"].contains(where: { lower.contains($0) })
        let decisiveness = ["i recommend", "my decision is", "i propose", "we will", "the plan is", "i've decided", "here is what we'll do"].contains(where: { lower.contains($0) })
        let accountability = ["i take responsibility", "my role is", "i own", "i am accountable", "i will ensure"].contains(where: { lower.contains($0) })
        let structured = ["first", "second", "third", "step 1", "phase 1", "criteria", "framework", "approach"].contains(where: { lower.contains($0) })
        let people = ["team", "people", "engineers", "morale", "development", "growth", "career", "training", "support", "mentor"].contains(where: { lower.contains($0) })
        let dataDriven = ["data", "metrics", "measure", "kpi", "roi", "analysis", "evidence", "benchmark", "percent", "%", "cost", "revenue"].contains(where: { lower.contains($0) })

        var score = 30
        score += empathy ? 15 : 0
        score += decisiveness ? 15 : 0
        score += accountability ? 10 : 0
        score += structured ? 10 : 0
        score += people ? 10 : 0
        score += dataDriven ? 10 : 0
        score = score.clamped(to: 0...100)

        var feedback: [String] = []
        if !decisiveness { feedback.append("Be more decisive — state your decision and reasoning clearly.") }
        if !empathy { feedback.append("Show empathy — acknowledge the human impact of decisions.") }
        if !accountability { feedback.append("Demonstrate accountability — say 'I will ensure...' not 'The team should...'") }
        if !structured { feedback.append("Use a structured approach — walk through reasoning step by step.") }
        if !people { feedback.append("Consider people impact — how decisions affect team dynamics and culture.") }
        if !dataDriven { feedback.append("Back up decisions with data, metrics, and evidence.") }
        if feedback.isEmpty { feedback.append("Excellent leadership response!") }

        let qualities: [(String, Bool)] = [
            ("Empathy", empathy),
            ("Decisiveness", decisiveness),
            ("Accountability", accountability),
            ("Structured Thinking", structured),
            ("People Focus", people),
            ("Data-Driven", dataDriven),
        ]

        return (score, qualities, feedback)
    }

    // MARK: - Email-Specific

    func evaluateEmail(_ text: String) -> (score: Int, checks: [(String, Bool)], feedback: [String]) {
        let lower = text.lowercased()
        let lines = text.components(separatedBy: "\n")

        let hasSubject = lines.contains(where: { $0.lowercased().hasPrefix("subject:") })
        let hasGreeting = ["hi ", "hello ", "dear ", "good morning", "good afternoon", "team,"].contains(where: { lower.hasPrefix($0) })
        let hasClosing = ["regards", "thanks", "best", "sincerely", "thank you"].contains(where: { lower.contains($0) })
        let hasAction = ["action needed", "please", "could you", "i need", "by friday", "deadline", "next steps", "decision needed", "approval needed"].contains(where: { lower.contains($0) })
        let hasStructure = ["summary:", "status:", "risk", "update:", "recommendation:", "options:", "ask:", "action:"].contains(where: { lower.contains($0) })
        let wordCount = text.split(separator: " ").count
        let isConcise = wordCount <= 250

        var score = 40
        score += hasSubject ? 10 : 0
        score += hasGreeting ? 10 : 0
        score += hasClosing ? 10 : 0
        score += hasAction ? 15 : 0
        score += hasStructure ? 10 : 0
        score += isConcise ? 5 : 0
        score = score.clamped(to: 0...100)

        let checks: [(String, Bool)] = [
            ("Subject Line", hasSubject),
            ("Greeting", hasGreeting),
            ("Clear Action Item", hasAction),
            ("Structured Sections", hasStructure),
            ("Professional Closing", hasClosing),
            ("Concise (<250 words)", isConcise),
        ]

        var feedback: [String] = []
        if !hasSubject { feedback.append("Always include a descriptive subject line.") }
        if !hasGreeting { feedback.append("Start with an appropriate greeting.") }
        if !hasAction { feedback.append("Include a clear call-to-action.") }
        if !hasStructure { feedback.append("Use headers/sections for scannability.") }
        if !hasClosing { feedback.append("End with a professional closing.") }
        if !isConcise { feedback.append("Aim for under 200 words for maximum impact.") }
        if feedback.isEmpty { feedback.append("Well-structured professional email!") }

        return (score, checks, feedback)
    }
}

// MARK: - Helpers

extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let multiplier = pow(10.0, Double(places))
        return (self * multiplier).rounded() / multiplier
    }
}

extension String {
    func countOccurrences(of substring: String) -> Int {
        let lower = self.lowercased()
        let sub = substring.lowercased()
        var count = 0
        var searchRange = lower.startIndex..<lower.endIndex
        while let range = lower.range(of: sub, range: searchRange) {
            count += 1
            searchRange = range.upperBound..<lower.endIndex
        }
        return count
    }
}
