import Foundation

// MARK: - Proverb

struct Proverb: Identifiable {
    let id = UUID()
    let proverb: String
    let meaning: String
    let scenario: String
    let category: String
}

// MARK: - Wisdom Quote

struct WisdomQuote: Identifiable {
    let id = UUID()
    let text: String
    let author: String
    let source: String
    let category: String
    let application: String
}

// MARK: - Storytelling Technique

struct StorytellingTechnique: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let steps: [String]
    let telecomExample: String
}

// MARK: - Data

struct WisdomData {

    // MARK: - Bhagavad Gita Verses for Leadership & Communication

    static let gitaVerses: [WisdomQuote] = [
        WisdomQuote(
            text: "You have the right to perform your actions, but you are not entitled to the fruits of your actions.",
            author: "Bhagavad Gita",
            source: "Chapter 2, Verse 47",
            category: "Gita",
            application: "Focus on delivering your best presentation without obsessing over the outcome. When pitching a 6G strategy to the board, concentrate on clarity and conviction — the decision is theirs."
        ),
        WisdomQuote(
            text: "Reshape yourself through the power of your will. Do not degrade yourself. The self is the only friend of the self, and the self is the only enemy of the self.",
            author: "Bhagavad Gita",
            source: "Chapter 6, Verse 5",
            category: "Gita",
            application: "Self-improvement is self-driven. Your communication skills, negotiation prowess, and leadership presence grow through deliberate daily practice — no one else can do that work for you."
        ),
        WisdomQuote(
            text: "The wise see that there is action in the midst of inaction and inaction in the midst of action.",
            author: "Bhagavad Gita",
            source: "Chapter 4, Verse 18",
            category: "Gita",
            application: "In negotiations, strategic silence is action. When a vendor makes an offer, pause before responding. That silence speaks louder than words and creates space for better terms."
        ),
        WisdomQuote(
            text: "When meditation is mastered, the mind is unwavering like the flame of a lamp in a windless place.",
            author: "Bhagavad Gita",
            source: "Chapter 6, Verse 19",
            category: "Gita",
            application: "Under pressure — a board presentation, a critical negotiation, or a crisis — a calm, focused mind communicates authority. Practice composure before high-stakes moments."
        ),
        WisdomQuote(
            text: "Set thy heart upon thy work but never its reward.",
            author: "Bhagavad Gita",
            source: "Chapter 2, Verse 47",
            category: "Gita",
            application: "When presenting a $50M investment proposal, pour your expertise into the analysis and delivery. Detachment from the outcome paradoxically makes your delivery more powerful and authentic."
        ),
        WisdomQuote(
            text: "There is neither this world, nor the world beyond, nor happiness for the one who doubts.",
            author: "Bhagavad Gita",
            source: "Chapter 4, Verse 40",
            category: "Gita",
            application: "Self-doubt kills leadership presence. When you speak as a solution architect, speak with conviction. If you don't believe in your recommendation, no one else will."
        ),
        WisdomQuote(
            text: "A person can rise through the efforts of one's own mind; one can also degrade oneself. Because each person is one's own friend or enemy.",
            author: "Bhagavad Gita",
            source: "Chapter 6, Verse 5-6",
            category: "Gita",
            application: "Your inner dialogue shapes your outer communication. Replace 'I'm not good enough for this keynote' with 'I have 10 years of deep domain expertise that this audience needs.'"
        ),
        WisdomQuote(
            text: "He who has no attachments can really love others, for his love is pure and divine.",
            author: "Bhagavad Gita",
            source: "Chapter 2, Verse 64",
            category: "Gita",
            application: "Lead without ego attachment. When your architecture proposal is challenged in a 3GPP meeting, detach from 'being right' and focus on finding the best solution. This earns lasting respect."
        ),
    ]

    // MARK: - Famous Author & Book Quotes

    static let authorQuotes: [WisdomQuote] = [
        // International Bestsellers
        WisdomQuote(
            text: "The most important thing in communication is hearing what isn't said.",
            author: "Peter Drucker",
            source: "Management Challenges for the 21st Century",
            category: "Authors",
            application: "In stakeholder meetings, listen for concerns behind the words. When the VP says 'I'm not sure about the timeline,' they may be worried about resource allocation, not the plan itself."
        ),
        WisdomQuote(
            text: "Start with Why. People don't buy what you do; they buy why you do it.",
            author: "Simon Sinek",
            source: "Start with Why",
            category: "Authors",
            application: "Don't open a presentation with 'We propose to deploy NWDAF.' Start with 'Our network generates terabytes of data daily that we're ignoring — here's how we turn it into competitive advantage.'"
        ),
        WisdomQuote(
            text: "If you can't explain it simply, you don't understand it well enough.",
            author: "Albert Einstein",
            source: "Attributed",
            category: "Authors",
            application: "The ultimate test of your 5G/6G expertise: can you explain Network Slicing to a CEO in 30 seconds using an everyday analogy? Complexity is easy; simplicity requires mastery."
        ),
        WisdomQuote(
            text: "The key to successful leadership today is influence, not authority.",
            author: "Ken Blanchard",
            source: "The One Minute Manager",
            category: "Authors",
            application: "As a solution architect, you rarely have direct authority over decisions. Your power comes from the quality of your analysis, the clarity of your communication, and the trust you build."
        ),
        WisdomQuote(
            text: "Vulnerability is the birthplace of innovation, creativity, and change.",
            author: "Brene Brown",
            source: "Daring Greatly",
            category: "Authors",
            application: "Saying 'I don't know, but I'll find out' in a technical review builds more credibility than bluffing. Authentic leaders acknowledge gaps — it invites collaboration."
        ),
        WisdomQuote(
            text: "In the middle of difficulty lies opportunity.",
            author: "Albert Einstein",
            source: "Attributed",
            category: "Authors",
            application: "A major network outage is a crisis — and also your chance to demonstrate leadership. How you communicate during the crisis defines your reputation far more than smooth sailing."
        ),
        WisdomQuote(
            text: "The single biggest problem in communication is the illusion that it has taken place.",
            author: "George Bernard Shaw",
            source: "Attributed",
            category: "Authors",
            application: "After every critical meeting, send a written summary of decisions and action items. What you said and what people heard are often very different things."
        ),
        WisdomQuote(
            text: "Think before you speak. Read before you think.",
            author: "Fran Lebowitz",
            source: "The Fran Lebowitz Reader",
            category: "Authors",
            application: "Before a vendor negotiation, research their financial reports, recent deals, and competitive position. Preparation is 90% of negotiation success."
        ),
        WisdomQuote(
            text: "Habits are the compound interest of self-improvement.",
            author: "James Clear",
            source: "Atomic Habits",
            category: "Authors",
            application: "Practicing one presentation skill for 10 minutes daily compounds into transformational change over a year. Don't aim for perfection — aim for consistency."
        ),
        WisdomQuote(
            text: "When you show deep empathy toward others, their defensive energy goes down, and positive energy replaces it.",
            author: "Stephen Covey",
            source: "The 7 Habits of Highly Effective People",
            category: "Authors",
            application: "In difficult conversations — performance reviews, budget cuts, restructuring — lead with empathy. 'I understand this change is unsettling, and here's how we'll support you through it.'"
        ),
        WisdomQuote(
            text: "The art of war is of vital importance to the State. It is a matter of life and death.",
            author: "Sun Tzu",
            source: "The Art of War",
            category: "Authors",
            application: "Preparation for high-stakes negotiations (multi-million dollar vendor contracts) deserves the same rigor as military strategy. Map the terrain, know your opponent, and have contingency plans."
        ),
        WisdomQuote(
            text: "A reader lives a thousand lives before he dies. The man who never reads lives only one.",
            author: "George R.R. Martin",
            source: "A Dance with Dragons",
            category: "Authors",
            application: "Read broadly — not just telecom. History, psychology, and biography give you stories and frameworks that make your technical presentations memorable and relatable."
        ),
    ]

    // MARK: - Historians & Poets

    static let historianPoetQuotes: [WisdomQuote] = [
        WisdomQuote(
            text: "In the middle of every difficulty lies opportunity.",
            author: "Winston Churchill",
            source: "World War II Speeches",
            category: "Historians",
            application: "Churchill's wartime speeches turned despair into resolve through sheer communication power. When presenting bad news (outages, delays), frame it as a catalyst for improvement."
        ),
        WisdomQuote(
            text: "Those who cannot remember the past are condemned to repeat it.",
            author: "George Santayana",
            source: "The Life of Reason",
            category: "Historians",
            application: "In post-mortem reviews, document lessons learned thoroughly. The same PCF misconfiguration that caused today's outage will happen again if we don't institutionalize the fix."
        ),
        WisdomQuote(
            text: "The pen is mightier than the sword.",
            author: "Edward Bulwer-Lytton",
            source: "Richelieu (1839)",
            category: "Poets",
            application: "A well-written architecture document or proposal email can influence decisions more than hours of meetings. Invest time in your written communication."
        ),
        WisdomQuote(
            text: "If you would not be forgotten as soon as you are dead, either write things worth reading or do things worth writing.",
            author: "Benjamin Franklin",
            source: "Poor Richard's Almanack",
            category: "Historians",
            application: "Your 3GPP technical contributions, architecture white papers, and conference talks build a lasting professional legacy in the telecom industry."
        ),
        WisdomQuote(
            text: "Do I dare disturb the universe? In a minute there is time for decisions and revisions which a minute will reverse.",
            author: "T.S. Eliot",
            source: "The Love Song of J. Alfred Prufrock",
            category: "Poets",
            application: "Don't hesitate to propose bold ideas in architecture reviews. The person who dares to challenge the status quo and propose a 6G vision is the one who shapes the company's future."
        ),
        WisdomQuote(
            text: "Where there is no vision, the people perish.",
            author: "Proverbs 29:18",
            source: "Bible / King James Version",
            category: "Historians",
            application: "As a solution architect, you are the vision-holder. Your team needs to understand not just what to build, but why it matters and where it leads."
        ),
        WisdomQuote(
            text: "Two roads diverged in a wood, and I took the one less traveled by, and that has made all the difference.",
            author: "Robert Frost",
            source: "The Road Not Taken",
            category: "Poets",
            application: "When everyone chooses the safe vendor, the obvious architecture, the proven approach — the leader who evaluates the unconventional path often finds the breakthrough innovation."
        ),
        WisdomQuote(
            text: "Not everything that is faced can be changed, but nothing can be changed until it is faced.",
            author: "James Baldwin",
            source: "As Much Truth As One Can Bear (1962)",
            category: "Historians",
            application: "Address technical debt, team issues, and architectural flaws directly. Avoidance never solves problems — courageous communication does."
        ),
    ]

    // MARK: - Scenario-Based Proverbs

    static let proverbs: [Proverb] = [
        Proverb(
            proverb: "Measure twice, cut once.",
            meaning: "Careful planning prevents costly mistakes.",
            scenario: "Before deploying a new 5G Core configuration to production, validate it in the digital twin environment first. The 4 hours spent testing saves the 4-hour outage that affects 2 million subscribers.",
            category: "Planning"
        ),
        Proverb(
            proverb: "The best time to plant a tree was 20 years ago. The second best time is now.",
            meaning: "Don't delay important actions because you didn't start earlier.",
            scenario: "Your competitors started 6G research 2 years ago. Instead of lamenting lost time, start today with a focused initiative. Present a phased 6G readiness plan to the CTO this week.",
            category: "Action"
        ),
        Proverb(
            proverb: "A chain is only as strong as its weakest link.",
            meaning: "One weak component can bring down the entire system.",
            scenario: "Your 5G Core may have 99.999% availability on the AMF and SMF, but if the PCF has a single point of failure, that's your weakest link. Address it in your architecture review.",
            category: "Quality"
        ),
        Proverb(
            proverb: "Still waters run deep.",
            meaning: "Quiet people often have the most profound ideas.",
            scenario: "In your architecture review meeting, the quiet junior engineer might have the best insight. Actively invite their input: 'I'd like to hear your perspective on the distributed NWDAF approach.'",
            category: "Leadership"
        ),
        Proverb(
            proverb: "Don't put all your eggs in one basket.",
            meaning: "Diversify to reduce risk.",
            scenario: "Relying on a single vendor for your entire 5G Core stack creates dangerous lock-in. Negotiate multi-vendor strategies and maintain a credible BATNA.",
            category: "Strategy"
        ),
        Proverb(
            proverb: "Actions speak louder than words.",
            meaning: "What you do matters more than what you say.",
            scenario: "After promising the team that 6G research is a priority, actually allocate engineers and budget. Empty promises erode trust faster than no promise at all.",
            category: "Leadership"
        ),
        Proverb(
            proverb: "Rome wasn't built in a day.",
            meaning: "Great achievements take time and patience.",
            scenario: "Migrating from VM-based 5G Core to cloud-native CNFs is a multi-year journey. Present a realistic phased roadmap rather than overpromising quick results.",
            category: "Planning"
        ),
        Proverb(
            proverb: "When the winds of change blow, some people build walls and others build windmills.",
            meaning: "Adapt to change rather than resisting it.",
            scenario: "When 3GPP introduces new Release 19 requirements that disrupt your architecture, don't resist. Lead the adaptation and position your team as the ones who turn disruption into advantage.",
            category: "Strategy"
        ),
        Proverb(
            proverb: "Give a man a fish and you feed him for a day. Teach a man to fish and you feed him for a lifetime.",
            meaning: "Empower people rather than creating dependency.",
            scenario: "Instead of always solving escalations yourself, mentor your senior engineers to handle vendor negotiations and architecture decisions independently. Scale your impact through others.",
            category: "Leadership"
        ),
        Proverb(
            proverb: "The tongue has no bones, but it is strong enough to break a heart.",
            meaning: "Words carry immense power — use them wisely.",
            scenario: "In a performance review, saying 'Your code quality has been terrible' damages trust. Instead: 'I've noticed the code review feedback has increased — let's talk about what's changed and how I can help.'",
            category: "Communication"
        ),
        Proverb(
            proverb: "Empty vessels make the most noise.",
            meaning: "Those who know the least often talk the most.",
            scenario: "In standards meetings, the most respected delegates are those who speak concisely with deep technical backing. Let your preparation and data do the talking, not volume.",
            category: "Communication"
        ),
        Proverb(
            proverb: "A journey of a thousand miles begins with a single step.",
            meaning: "Even the largest task starts with one action.",
            scenario: "The 6G research program feels overwhelming. Start with one focused workstream — AI-native networking. Build momentum with small wins before expanding scope.",
            category: "Action"
        ),
    ]

    // MARK: - Storytelling Techniques

    static let storytellingTechniques: [StorytellingTechnique] = [
        StorytellingTechnique(
            name: "The Hero's Journey",
            description: "Take your audience on a journey: a protagonist faces a challenge, overcomes obstacles, and emerges transformed. Your customer or team is the hero — your solution is the guide.",
            steps: [
                "Set the scene: 'Last year, our enterprise customer was losing $2M/month to factory downtime...'",
                "Introduce the challenge: '...their Wi-Fi network couldn't handle real-time robotic control...'",
                "Present the journey: '...we deployed a private 5G network with URLLC slicing...'",
                "Reveal the transformation: '...today, downtime is down 95% and they've expanded to three more factories.'",
            ],
            telecomExample: "Use this when presenting case studies to enterprise customers or at industry conferences. The customer is the hero; your 5G solution is the magical tool that enabled their success."
        ),
        StorytellingTechnique(
            name: "The Contrast Principle",
            description: "Paint a vivid picture of 'before' and 'after.' The sharper the contrast, the more compelling your message. Use concrete details.",
            steps: [
                "Describe the painful 'before' state with specific details",
                "Create a clear transition moment ('Then we...')",
                "Paint the aspirational 'after' state with measurable results",
                "Make the audience feel the gap between the two states",
            ],
            telecomExample: "BEFORE: 'Deploying a new service took 6 months, 3 teams, and 47 manual configurations.' AFTER: 'With our cloud-native SBA and intent-based networking, the same service deploys in 4 hours with zero manual steps.'"
        ),
        StorytellingTechnique(
            name: "The Analogy Bridge",
            description: "Connect an unfamiliar technical concept to something your audience already understands. The best analogies are simple, visual, and emotionally resonant.",
            steps: [
                "Identify what's unfamiliar to your audience",
                "Find a parallel in everyday life",
                "Draw the connection explicitly",
                "Acknowledge where the analogy breaks down (builds credibility)",
            ],
            telecomExample: "Network Slicing = Highway lanes. Digital Twin = Flight simulator for networks. Zero-Trust = Airport security (verify everyone, every time, even frequent flyers)."
        ),
        StorytellingTechnique(
            name: "The Rule of Three",
            description: "Structure your message around exactly three points. Three is the magic number for human memory — two feels incomplete, four overwhelms.",
            steps: [
                "Identify your single core message",
                "Support it with exactly three pillars",
                "Each pillar gets one concrete example",
                "Summarize by restating all three in one sentence",
            ],
            telecomExample: "'Our 6G strategy rests on three pillars: AI-native architecture for autonomous operations, THz communication for 100x bandwidth, and digital twins for zero-risk innovation. That's smarter, faster, and safer.'"
        ),
        StorytellingTechnique(
            name: "The Curiosity Gap",
            description: "Open with an intriguing statement or question that creates a gap between what the audience knows and what they want to know. Then fill that gap.",
            steps: [
                "Start with an unexpected fact, statistic, or question",
                "Let the tension build — don't answer immediately",
                "Provide context that deepens the mystery",
                "Deliver the insight that resolves the gap",
            ],
            telecomExample: "'What if I told you our network generates more data every day than Netflix serves to all its subscribers combined — and we throw 99% of it away? Today I'll show you how NWDAF turns that waste into our biggest competitive advantage.'"
        ),
        StorytellingTechnique(
            name: "The Personal Stake",
            description: "Share a personal moment of failure, learning, or conviction. Vulnerability creates connection and makes your message authentic.",
            steps: [
                "Choose a genuine personal experience (not fabricated)",
                "Share the moment of doubt, failure, or realization",
                "Connect it to the lesson or message",
                "Show how it changed your perspective or approach",
            ],
            telecomExample: "'Two years ago, I pushed for a VM-based deployment because it was safe. That decision cost us 6 months when we had to re-architect for cloud-native. That failure taught me: in telecom, the biggest risk is not taking risks. That's why I'm advocating for AI-native 6G now.'"
        ),
        StorytellingTechnique(
            name: "The Bookend",
            description: "Open and close with the same story, image, or phrase — but the second time, the audience sees it with new understanding.",
            steps: [
                "Open with a vivid scene, question, or statement",
                "Deliver your full message in the body",
                "Return to the opening scene at the end",
                "Show how the audience's understanding has changed",
            ],
            telecomExample: "Open: 'This morning, 2 billion people connected to 5G networks worldwide. Most don't even notice.' Close: 'Remember those 2 billion people? By 2035, it'll be 10 billion — humans, machines, and AI agents — and the network we're designing today will make that invisible magic possible.'"
        ),
        StorytellingTechnique(
            name: "Data as Story",
            description: "Don't just present numbers — give them context, meaning, and emotion. A single data point with a story outperforms a slide full of charts.",
            steps: [
                "Lead with one powerful number",
                "Give it human context ('That's equivalent to...')",
                "Show the trend or change over time",
                "Connect it to a decision or action",
            ],
            telecomExample: "'$500,000. That's what one hour of 5G Core downtime costs us in SLA penalties. Last year we had 12 hours of unplanned downtime — that's $6 million. Our digital twin investment of $2 million pays for itself in 4 months by eliminating 60% of those outages.'"
        ),
    ]

    // MARK: - Daily Wisdom (all combined for daily rotation)

    static func dailyWisdom() -> WisdomQuote {
        let all = gitaVerses + authorQuotes + historianPoetQuotes
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 1
        return all[dayOfYear % all.count]
    }

    static func randomProverb() -> Proverb {
        proverbs.randomElement() ?? proverbs[0]
    }
}
