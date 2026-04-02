"""Scoring and feedback engine for communication exercises."""

import re
from collections import Counter

from communication_coach.config import SCORING, TELECOM_DOMAIN


# Common filler words and weak phrases to detect
FILLER_WORDS = [
    "um", "uh", "like", "you know", "basically", "actually", "sort of",
    "kind of", "i mean", "right", "so yeah", "honestly", "literally",
]

WEAK_PHRASES = [
    "i think maybe", "i'm not sure but", "this might be wrong",
    "i guess", "probably", "hopefully", "if that makes sense",
    "does that make sense", "sorry but",
]

STRONG_PHRASES = [
    "i recommend", "the data shows", "based on our analysis",
    "the key benefit is", "this ensures", "this enables",
    "the strategic advantage", "our approach delivers",
    "the evidence suggests", "let me walk you through",
    "here is what i propose", "the impact will be",
]

TRANSITION_PHRASES = [
    "first", "second", "third", "next", "finally",
    "moreover", "furthermore", "in addition",
    "however", "on the other hand", "conversely",
    "therefore", "consequently", "as a result",
    "in summary", "to conclude", "in conclusion",
    "for example", "specifically", "in particular",
    "let me elaborate", "building on this",
]


def analyze_text(text: str) -> dict:
    """Analyze a text response and return detailed metrics."""
    text_lower = text.lower()
    words = text_lower.split()
    sentences = [s.strip() for s in re.split(r'[.!?]+', text) if s.strip()]
    word_count = len(words)
    sentence_count = max(len(sentences), 1)
    avg_sentence_length = word_count / sentence_count

    # Filler word detection
    filler_count = sum(text_lower.count(f) for f in FILLER_WORDS)

    # Weak phrase detection
    weak_count = sum(text_lower.count(w) for w in WEAK_PHRASES)
    weak_found = [w for w in WEAK_PHRASES if w in text_lower]

    # Strong phrase detection
    strong_count = sum(text_lower.count(s) for s in STRONG_PHRASES)
    strong_found = [s for s in STRONG_PHRASES if s in text_lower]

    # Transition phrase detection
    transition_count = sum(text_lower.count(t) for t in TRANSITION_PHRASES)
    transitions_found = [t for t in TRANSITION_PHRASES if t in text_lower]

    # Technical term usage
    tech_terms_used = [
        t for t in TELECOM_DOMAIN["technologies"]
        if t.lower() in text_lower
    ]

    # Vocabulary richness (type-token ratio)
    unique_words = len(set(words))
    vocabulary_richness = unique_words / max(word_count, 1)

    return {
        "word_count": word_count,
        "sentence_count": sentence_count,
        "avg_sentence_length": round(avg_sentence_length, 1),
        "filler_count": filler_count,
        "weak_phrases": weak_found,
        "strong_phrases": strong_found,
        "transitions_found": transitions_found,
        "tech_terms_used": tech_terms_used,
        "vocabulary_richness": round(vocabulary_richness, 2),
        "strong_count": strong_count,
        "weak_count": weak_count,
        "transition_count": transition_count,
    }


def compute_scores(analysis: dict, exercise_type: str = "general") -> dict:
    """Compute scores across all dimensions based on text analysis."""
    scores = {}

    # Clarity score (0-100)
    clarity = 70
    if analysis["avg_sentence_length"] < 20:
        clarity += 10
    elif analysis["avg_sentence_length"] > 30:
        clarity -= 15
    clarity -= analysis["filler_count"] * 5
    clarity += min(analysis["transition_count"] * 5, 20)
    scores["clarity"] = max(0, min(100, clarity))

    # Structure score (0-100)
    structure = 50
    structure += min(analysis["transition_count"] * 8, 30)
    if analysis["sentence_count"] >= 3:
        structure += 10
    if analysis["word_count"] >= 50:
        structure += 10
    scores["structure"] = max(0, min(100, structure))

    # Technical accuracy score (0-100)
    tech = 50
    tech += min(len(analysis["tech_terms_used"]) * 10, 40)
    if exercise_type in ("presentation", "negotiation"):
        tech += 10 if len(analysis["tech_terms_used"]) >= 2 else 0
    scores["technical_accuracy"] = max(0, min(100, tech))

    # Persuasiveness score (0-100)
    persuasion = 50
    persuasion += analysis["strong_count"] * 10
    persuasion -= analysis["weak_count"] * 10
    persuasion += min(analysis["transition_count"] * 3, 15)
    scores["persuasiveness"] = max(0, min(100, persuasion))

    # Conciseness score (0-100)
    conciseness = 70
    if analysis["avg_sentence_length"] > 25:
        conciseness -= 15
    if analysis["filler_count"] > 2:
        conciseness -= 15
    if analysis["word_count"] > 500:
        conciseness -= 10
    elif analysis["word_count"] < 20:
        conciseness -= 20
    scores["conciseness"] = max(0, min(100, conciseness))

    # Weighted overall
    overall = sum(
        scores[dim] * SCORING[dim]["weight"] for dim in SCORING
    )
    scores["overall"] = round(overall, 1)

    return scores


def generate_feedback(analysis: dict, scores: dict) -> list[str]:
    """Generate actionable feedback tips based on analysis and scores."""
    tips = []

    if analysis["filler_count"] > 0:
        tips.append(
            f"Reduce filler words — detected {analysis['filler_count']} instances. "
            "Replace them with deliberate pauses or transition phrases."
        )

    if analysis["weak_phrases"]:
        tips.append(
            "Avoid hedging language: "
            + ", ".join(f'"{w}"' for w in analysis["weak_phrases"][:3])
            + ". Replace with confident assertions backed by data."
        )

    if analysis["strong_count"] == 0:
        tips.append(
            'Use assertive phrases like "I recommend...", "The data shows...", '
            '"Our approach delivers..." to convey confidence.'
        )

    if analysis["transition_count"] < 2:
        tips.append(
            "Add transition phrases (first, moreover, therefore, in conclusion) "
            "to improve logical flow between ideas."
        )

    if len(analysis["tech_terms_used"]) == 0:
        tips.append(
            "Incorporate relevant technical terms (e.g., Network Slicing, SBA, NWDAF) "
            "to demonstrate domain expertise and credibility."
        )

    if analysis["avg_sentence_length"] > 28:
        tips.append(
            f"Average sentence length is {analysis['avg_sentence_length']} words — "
            "aim for 15-20 words per sentence for better audience comprehension."
        )

    if analysis["vocabulary_richness"] < 0.5 and analysis["word_count"] > 30:
        tips.append(
            "Expand vocabulary variety — repeating the same words can reduce impact. "
            "Use synonyms and varied phrasing."
        )

    if scores["persuasiveness"] < 60:
        tips.append(
            "Strengthen persuasiveness: lead with benefits, use concrete numbers, "
            "and tie technical features to business outcomes."
        )

    if scores["structure"] < 60:
        tips.append(
            "Improve structure: use a clear opening statement, organized body points, "
            "and a strong conclusion with a call to action."
        )

    if not tips:
        tips.append("Excellent work! Your communication is clear, structured, and persuasive.")

    return tips
