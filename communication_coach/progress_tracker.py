"""Track user progress across exercises and sessions."""

import json
import os
from datetime import datetime

PROGRESS_FILE = os.path.join(
    os.path.dirname(os.path.abspath(__file__)), "..", "progress_data.json"
)


def _load_progress() -> dict:
    """Load progress data from file."""
    if os.path.exists(PROGRESS_FILE):
        with open(PROGRESS_FILE, "r") as f:
            return json.load(f)
    return {
        "sessions": [],
        "total_exercises": 0,
        "category_counts": {},
        "best_scores": {},
        "streak_days": [],
    }


def _save_progress(data: dict) -> None:
    """Save progress data to file."""
    with open(PROGRESS_FILE, "w") as f:
        json.dump(data, f, indent=2, default=str)


def record_exercise(category: str, exercise_name: str, scores: dict) -> None:
    """Record a completed exercise with its scores."""
    data = _load_progress()
    session = {
        "timestamp": datetime.now().isoformat(),
        "category": category,
        "exercise": exercise_name,
        "scores": scores,
    }
    data["sessions"].append(session)
    data["total_exercises"] += 1

    # Update category counts
    data["category_counts"][category] = data["category_counts"].get(category, 0) + 1

    # Update best scores
    overall = scores.get("overall", 0)
    if category not in data["best_scores"] or overall > data["best_scores"][category]:
        data["best_scores"][category] = overall

    # Track streak days
    today = datetime.now().strftime("%Y-%m-%d")
    if today not in data["streak_days"]:
        data["streak_days"].append(today)

    _save_progress(data)


def get_progress_summary() -> dict:
    """Get a summary of the user's progress."""
    data = _load_progress()

    # Calculate current streak
    streak = 0
    if data["streak_days"]:
        sorted_days = sorted(data["streak_days"], reverse=True)
        today = datetime.now().strftime("%Y-%m-%d")
        if sorted_days[0] == today:
            streak = 1
            for i in range(1, len(sorted_days)):
                prev = datetime.strptime(sorted_days[i - 1], "%Y-%m-%d")
                curr = datetime.strptime(sorted_days[i], "%Y-%m-%d")
                if (prev - curr).days == 1:
                    streak += 1
                else:
                    break

    # Recent session scores for trend
    recent = data["sessions"][-10:] if data["sessions"] else []
    recent_scores = [s["scores"].get("overall", 0) for s in recent]

    # Average scores by category
    category_averages = {}
    for session in data["sessions"]:
        cat = session["category"]
        score = session["scores"].get("overall", 0)
        if cat not in category_averages:
            category_averages[cat] = []
        category_averages[cat].append(score)

    for cat in category_averages:
        vals = category_averages[cat]
        category_averages[cat] = round(sum(vals) / len(vals), 1)

    return {
        "total_exercises": data["total_exercises"],
        "category_counts": data["category_counts"],
        "best_scores": data["best_scores"],
        "current_streak": streak,
        "recent_scores": recent_scores,
        "category_averages": category_averages,
    }


def get_recommendations() -> list[str]:
    """Get personalized recommendations based on progress."""
    summary = get_progress_summary()
    recommendations = []

    if summary["total_exercises"] == 0:
        return [
            "Welcome! Start with a Presentation exercise to establish your baseline.",
            "Try a Negotiation scenario to practice vendor discussions.",
            "Complete a Leadership exercise to build stakeholder management skills.",
        ]

    # Recommend least-practiced categories
    all_categories = ["Presentation", "Negotiation", "Communication", "Leadership"]
    for cat in all_categories:
        if cat not in summary["category_counts"]:
            recommendations.append(f"You haven't tried {cat} exercises yet — give it a go!")

    # Recommend based on weak scores
    for cat, avg in summary["category_averages"].items():
        if avg < 60:
            recommendations.append(
                f"Your average score in {cat} is {avg}/100 — focus on this area."
            )

    if summary["current_streak"] == 0:
        recommendations.append("Practice daily to build a streak — consistency is key!")

    if not recommendations:
        recommendations.append(
            "Great progress! Try increasing the difficulty level for more challenge."
        )

    return recommendations[:5]
