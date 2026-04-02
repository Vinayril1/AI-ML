#!/usr/bin/env python3
"""
Communication Skills Coach — Interactive CLI Application
=========================================================
Tailored for Telecom Solution Architects working on 5G Advanced & 6G Core Networks.

Modules:
  1. Presentation Coach     — Practice technical presentations with feedback
  2. Negotiation Simulator  — Role-play vendor, enterprise, and internal negotiations
  3. Communication Lab      — Email writing, meeting facilitation, vocabulary building
  4. Leadership Academy     — Decision making, team management, stakeholder scenarios
  5. Progress Dashboard     — Track scores, streaks, and improvement trends
"""

import random
import sys
import textwrap

from rich.console import Console
from rich.markdown import Markdown
from rich.panel import Panel
from rich.prompt import Confirm, IntPrompt, Prompt
from rich.table import Table
from rich.text import Text
from rich import box

from communication_coach.config import LEVELS, SCORING, TELECOM_DOMAIN
from communication_coach.scoring import analyze_text, compute_scores, generate_feedback
from communication_coach.progress_tracker import (
    get_progress_summary,
    get_recommendations,
    record_exercise,
)
from communication_coach.presentation_coach import (
    evaluate_presentation_structure,
    get_all_scenarios as get_all_presentation_scenarios,
    get_scenario as get_presentation_scenario,
    get_tips as get_presentation_tips,
)
from communication_coach.negotiation_simulator import (
    evaluate_negotiation_response,
    get_all_scenarios as get_all_negotiation_scenarios,
    get_scenario as get_negotiation_scenario,
    get_tactic,
    get_response_framework,
)
from communication_coach.communication_exercises import (
    evaluate_email,
    get_email_exercise,
    get_explanation_challenge,
    get_meeting_exercise,
    get_vocabulary,
)
from communication_coach.leadership_coach import (
    evaluate_leadership_response,
    get_all_scenarios as get_all_leadership_scenarios,
    get_daily_quote,
    get_framework as get_leadership_framework,
    get_scenario as get_leadership_scenario,
)

console = Console()

# ── Helpers ──────────────────────────────────────────────────────────────────


def print_banner():
    """Print the application banner."""
    banner = Text()
    banner.append("  COMMUNICATION SKILLS COACH  \n", style="bold white on blue")
    banner.append("  For Telecom Solution Architects  \n", style="bold cyan")
    banner.append("  5G Advanced | 6G | Core Network  ", style="dim cyan")
    console.print(Panel(banner, box=box.DOUBLE, border_style="blue", expand=False))
    quote, author = get_daily_quote()
    console.print(f'\n  [italic]"{quote}"[/italic]')
    console.print(f"  [dim]— {author}[/dim]\n")


def print_score_table(scores: dict):
    """Display scores in a formatted table."""
    table = Table(title="Your Scores", box=box.ROUNDED, border_style="cyan")
    table.add_column("Dimension", style="bold")
    table.add_column("Score", justify="center")
    table.add_column("Rating", justify="center")

    for dim in SCORING:
        score = scores.get(dim, 0)
        if score >= 80:
            rating = "[bold green]Excellent[/bold green]"
        elif score >= 60:
            rating = "[yellow]Good[/yellow]"
        elif score >= 40:
            rating = "[dark_orange]Fair[/dark_orange]"
        else:
            rating = "[red]Needs Work[/red]"
        table.add_row(
            SCORING[dim]["description"],
            f"{score}/100",
            rating,
        )

    overall = scores.get("overall", 0)
    table.add_section()
    if overall >= 75:
        style = "bold green"
    elif overall >= 50:
        style = "bold yellow"
    else:
        style = "bold red"
    table.add_row("OVERALL", f"[{style}]{overall}/100[/{style}]", "")
    console.print(table)


def print_feedback(tips: list[str]):
    """Display feedback tips."""
    console.print("\n[bold cyan]Feedback & Tips:[/bold cyan]")
    for i, tip in enumerate(tips, 1):
        console.print(f"  {i}. {tip}")
    console.print()


def select_level() -> int:
    """Let user select a difficulty level."""
    console.print("\n[bold]Select Difficulty Level:[/bold]")
    for lvl, desc in LEVELS.items():
        console.print(f"  {lvl}. {desc}")
    return IntPrompt.ask("\nLevel", choices=["1", "2", "3", "4"], default=2)


def get_user_response(prompt_text: str = "Your response") -> str:
    """Get a multi-line response from the user."""
    console.print(f"\n[bold green]{prompt_text}[/bold green]")
    console.print("[dim](Type your response. Enter a blank line to finish.)[/dim]\n")
    lines = []
    while True:
        try:
            line = input()
        except EOFError:
            break
        if line == "" and lines:
            break
        lines.append(line)
    return "\n".join(lines)


def pause():
    """Pause before returning to menu."""
    console.print()
    Prompt.ask("[dim]Press Enter to continue[/dim]", default="")


# ── Module 1: Presentation Coach ────────────────────────────────────────────


def run_presentation_coach():
    """Run the Presentation Coach module."""
    console.print(Panel("[bold]PRESENTATION COACH[/bold]", border_style="green"))
    console.print("  1. Practice a presentation scenario")
    console.print("  2. Browse all scenarios")
    console.print("  3. View presentation tips")
    console.print("  0. Back to main menu")
    choice = Prompt.ask("\nChoice", choices=["0", "1", "2", "3"], default="1")

    if choice == "0":
        return

    if choice == "2":
        scenarios = get_all_presentation_scenarios()
        table = Table(title="All Presentation Scenarios", box=box.SIMPLE)
        table.add_column("#", justify="center", width=3)
        table.add_column("Level", justify="center")
        table.add_column("Title", style="bold")
        table.add_column("Audience")
        for i, s in enumerate(scenarios, 1):
            table.add_row(str(i), str(s["level"]), s["title"], s["audience"])
        console.print(table)
        pause()
        return

    if choice == "3":
        tips = get_presentation_tips()
        for category, tip_list in tips.items():
            console.print(f"\n[bold cyan]{category.upper()}:[/bold cyan]")
            for tip in tip_list:
                console.print(f"  • {tip}")
        pause()
        return

    # Practice a scenario
    level = select_level()
    scenario = get_presentation_scenario(level)

    console.print(Panel(
        f"[bold]{scenario['title']}[/bold]\n\n"
        f"{scenario['scenario']}\n\n"
        f"[cyan]Audience:[/cyan] {scenario['audience']}\n"
        f"[cyan]Time Limit:[/cyan] {scenario['time_limit']}\n\n"
        f"[bold yellow]Key Points to Cover:[/bold yellow]",
        title=f"Level {scenario['level']} Scenario",
        border_style="green",
    ))
    for point in scenario["key_points"]:
        console.print(f"  • {point}")

    response = get_user_response("Deliver your presentation (type it out)")

    if not response.strip():
        console.print("[red]No response provided.[/red]")
        return

    # Analyze and score
    analysis = analyze_text(response)
    scores = compute_scores(analysis, "presentation")
    structure_eval = evaluate_presentation_structure(response)

    # Boost structure score with presentation-specific evaluation
    scores["structure"] = max(
        scores["structure"],
        structure_eval["structure_score"],
    )
    scores["overall"] = sum(
        scores[dim] * SCORING[dim]["weight"] for dim in SCORING
    )
    scores["overall"] = round(scores["overall"], 1)

    print_score_table(scores)

    # Combined feedback
    tips = generate_feedback(analysis, scores)
    tips.extend(structure_eval["feedback"])
    print_feedback(tips)

    # Show analysis details
    console.print("[bold]Analysis Details:[/bold]")
    console.print(f"  Word count: {analysis['word_count']}")
    console.print(f"  Sentences: {analysis['sentence_count']}")
    console.print(f"  Technical terms used: {', '.join(analysis['tech_terms_used']) or 'None detected'}")
    if analysis["strong_phrases"]:
        console.print(f"  Strong phrases: {', '.join(analysis['strong_phrases'])}")

    record_exercise("Presentation", scenario["title"], scores)
    console.print("\n[green]Progress saved![/green]")
    pause()


# ── Module 2: Negotiation Simulator ─────────────────────────────────────────


def run_negotiation_simulator():
    """Run the Negotiation Simulator module."""
    console.print(Panel("[bold]NEGOTIATION SIMULATOR[/bold]", border_style="yellow"))
    console.print("  1. Practice a negotiation scenario")
    console.print("  2. Browse all scenarios")
    console.print("  3. Learn negotiation tactics")
    console.print("  4. Response frameworks")
    console.print("  0. Back to main menu")
    choice = Prompt.ask("\nChoice", choices=["0", "1", "2", "3", "4"], default="1")

    if choice == "0":
        return

    if choice == "2":
        scenarios = get_all_negotiation_scenarios()
        table = Table(title="All Negotiation Scenarios", box=box.SIMPLE)
        table.add_column("#", justify="center", width=3)
        table.add_column("Level", justify="center")
        table.add_column("Category", style="cyan")
        table.add_column("Title", style="bold")
        for i, s in enumerate(scenarios, 1):
            table.add_row(str(i), str(s["level"]), s["category"], s["title"])
        console.print(table)
        pause()
        return

    if choice == "3":
        tactics = get_tactic()
        for name, tactic in tactics.items():
            console.print(Panel(
                f"[bold]{tactic['name']}[/bold]\n\n"
                f"{tactic['description']}\n\n"
                f"[cyan]Example:[/cyan] {tactic['example']}\n\n"
                f"[yellow]Telecom Tip:[/yellow] {tactic['telecom_tip']}",
                border_style="yellow",
            ))
        pause()
        return

    if choice == "4":
        frameworks = get_response_framework()
        for situation, tips in frameworks.items():
            console.print(f"\n[bold yellow]{situation.replace('_', ' ').upper()}:[/bold yellow]")
            for tip in tips:
                console.print(f"  • {tip}")
        pause()
        return

    # Practice a scenario
    level = select_level()
    scenario = get_negotiation_scenario(level)

    console.print(Panel(
        f"[bold]{scenario['title']}[/bold]\n\n"
        f"{scenario['scenario']}\n\n"
        f"[cyan]Your Position:[/cyan]\n"
        f"  Budget: {scenario['your_position']['budget']}\n"
        f"  Leverage: {scenario['your_position']['leverage']}\n"
        f"  Must-haves: {', '.join(scenario['your_position']['must_haves'])}\n"
        f"  Nice-to-haves: {', '.join(scenario['your_position']['nice_to_haves'])}\n\n"
        f"[cyan]Counterpart:[/cyan] {scenario['counterpart']}\n\n"
        f"[bold yellow]Tactics to Practice:[/bold yellow] {', '.join(scenario['tactics_to_practice'])}",
        title=f"Level {scenario['level']} — {scenario['category'].upper()}",
        border_style="yellow",
    ))

    console.print(Panel(
        f"[italic]{scenario['opening_message']}[/italic]",
        title="Counterpart Says",
        border_style="dim yellow",
    ))

    response = get_user_response("Your negotiation response")

    if not response.strip():
        console.print("[red]No response provided.[/red]")
        return

    # Analyze
    analysis = analyze_text(response)
    scores = compute_scores(analysis, "negotiation")
    neg_eval = evaluate_negotiation_response(response)

    # Blend negotiation-specific score into overall
    scores["persuasiveness"] = max(scores["persuasiveness"], neg_eval["score"])
    scores["overall"] = sum(
        scores[dim] * SCORING[dim]["weight"] for dim in SCORING
    )
    scores["overall"] = round(scores["overall"], 1)

    print_score_table(scores)

    # Negotiation-specific feedback
    console.print(f"\n[bold]Tone Assessment:[/bold] {neg_eval['tone']}")
    console.print(f"  Assertive signals: {neg_eval['assertive_count']}")
    console.print(f"  Collaborative signals: {neg_eval['collaborative_count']}")
    console.print(f"  Uses data/evidence: {'Yes' if neg_eval['has_data'] else 'No'}")
    console.print(f"  References alternatives (BATNA): {'Yes' if neg_eval['has_batna'] else 'No'}")

    tips = generate_feedback(analysis, scores)
    tips.extend(neg_eval["feedback"])
    print_feedback(tips)

    record_exercise("Negotiation", scenario["title"], scores)
    console.print("\n[green]Progress saved![/green]")
    pause()


# ── Module 3: Communication Lab ─────────────────────────────────────────────


def run_communication_lab():
    """Run the Communication Lab module."""
    console.print(Panel("[bold]COMMUNICATION LAB[/bold]", border_style="magenta"))
    console.print("  1. Email writing exercise")
    console.print("  2. Meeting facilitation practice")
    console.print("  3. Explain a concept simply")
    console.print("  4. Technical vocabulary builder")
    console.print("  0. Back to main menu")
    choice = Prompt.ask("\nChoice", choices=["0", "1", "2", "3", "4"], default="1")

    if choice == "0":
        return

    if choice == "4":
        vocab = get_vocabulary()
        for category, terms in vocab.items():
            console.print(f"\n[bold magenta]{category}:[/bold magenta]")
            for term, description in terms.items():
                console.print(f"  [cyan]{term}[/cyan]")
                console.print(f"    {description}")
        pause()
        return

    if choice == "2":
        level = select_level()
        exercise = get_meeting_exercise(min(level, 3))
        console.print(Panel(
            f"[bold]{exercise['title']}[/bold]\n\n"
            f"{exercise['scenario']}\n\n"
            f"[bold yellow]Skills Practiced:[/bold yellow] {', '.join(exercise['skills_practiced'])}",
            title="Meeting Facilitation Exercise",
            border_style="magenta",
        ))
        console.print("\n[bold cyan]Useful Phrases:[/bold cyan]")
        for phrase in exercise["key_phrases"]:
            console.print(f"  • {phrase}")

        response = get_user_response(
            "Write your meeting facilitation plan (opening, key discussion points, how you'll handle conflict, closing)"
        )
        if not response.strip():
            console.print("[red]No response provided.[/red]")
            return

        analysis = analyze_text(response)
        scores = compute_scores(analysis, "general")
        print_score_table(scores)
        print_feedback(generate_feedback(analysis, scores))
        record_exercise("Communication", exercise["title"], scores)
        console.print("\n[green]Progress saved![/green]")
        pause()
        return

    if choice == "3":
        challenge = get_explanation_challenge()
        console.print(Panel(
            f"[bold]Explain: {challenge['concept']}[/bold]\n\n"
            f"[cyan]Audience:[/cyan] {challenge['explain_to']}\n"
            f"[cyan]Constraint:[/cyan] {challenge['constraint']}",
            title="Concept Explanation Challenge",
            border_style="magenta",
        ))
        response = get_user_response("Your explanation")
        if not response.strip():
            console.print("[red]No response provided.[/red]")
            return

        analysis = analyze_text(response)
        scores = compute_scores(analysis, "general")
        print_score_table(scores)
        print_feedback(generate_feedback(analysis, scores))

        console.print("\n[bold cyan]Reference Example:[/bold cyan]")
        console.print(f"  [italic]{challenge['good_example']}[/italic]")

        record_exercise("Communication", f"Explain: {challenge['concept']}", scores)
        console.print("\n[green]Progress saved![/green]")
        pause()
        return

    # Email writing (choice == "1")
    level = select_level()
    exercise = get_email_exercise(min(level, 3))
    console.print(Panel(
        f"[bold]{exercise['title']}[/bold]\n\n"
        f"{exercise['scenario']}\n\n"
        f"[cyan]Audience:[/cyan] {exercise['audience']}",
        title=f"Level {exercise['level']} Email Exercise",
        border_style="magenta",
    ))
    console.print("\n[bold yellow]Guidelines:[/bold yellow]")
    for g in exercise["guidelines"]:
        console.print(f"  • {g}")

    response = get_user_response("Write your email (include Subject line)")

    if not response.strip():
        console.print("[red]No response provided.[/red]")
        return

    # Analyze with both general and email-specific scoring
    analysis = analyze_text(response)
    scores = compute_scores(analysis, "general")
    email_eval = evaluate_email(response)

    # Blend email score
    scores["overall"] = round((scores["overall"] + email_eval["score"]) / 2, 1)

    print_score_table(scores)

    console.print("\n[bold]Email Quality Check:[/bold]")
    checks = [
        ("Subject line", email_eval["has_subject"]),
        ("Greeting", email_eval["has_greeting"]),
        ("Clear action item", email_eval["has_action_item"]),
        ("Structured sections", email_eval["has_structure"]),
        ("Professional closing", email_eval["has_closing"]),
        ("Concise (<250 words)", email_eval["is_concise"]),
    ]
    for label, passed in checks:
        icon = "[green]✓[/green]" if passed else "[red]✗[/red]"
        console.print(f"  {icon} {label}")

    print_feedback(email_eval["feedback"])

    console.print("\n[bold cyan]Good Example Elements:[/bold cyan]")
    for elem in exercise["good_example_elements"]:
        console.print(f"  • {elem}")

    record_exercise("Communication", exercise["title"], scores)
    console.print("\n[green]Progress saved![/green]")
    pause()


# ── Module 4: Leadership Academy ────────────────────────────────────────────


def run_leadership_academy():
    """Run the Leadership Academy module."""
    console.print(Panel("[bold]LEADERSHIP ACADEMY[/bold]", border_style="red"))
    console.print("  1. Practice a leadership scenario")
    console.print("  2. Browse all scenarios")
    console.print("  3. Leadership frameworks reference")
    console.print("  0. Back to main menu")
    choice = Prompt.ask("\nChoice", choices=["0", "1", "2", "3"], default="1")

    if choice == "0":
        return

    if choice == "2":
        scenarios = get_all_leadership_scenarios()
        table = Table(title="All Leadership Scenarios", box=box.SIMPLE)
        table.add_column("#", justify="center", width=3)
        table.add_column("Level", justify="center")
        table.add_column("Category", style="cyan")
        table.add_column("Title", style="bold")
        table.add_column("Framework")
        for i, s in enumerate(scenarios, 1):
            table.add_row(str(i), str(s["level"]), s["category"], s["title"], s["framework"])
        console.print(table)
        pause()
        return

    if choice == "3":
        frameworks = get_leadership_framework()
        for name, fw in frameworks.items():
            console.print(Panel(
                f"[bold]{fw['name']}[/bold]\n\n"
                f"{fw['description']}\n\n"
                f"[cyan]Steps:[/cyan]",
                title=name,
                border_style="red",
            ))
            for step in fw["steps"]:
                console.print(f"  • {step}")
            console.print(f"\n  [yellow]When to use:[/yellow] {fw['when_to_use']}\n")
        pause()
        return

    # Practice a scenario
    level = select_level()
    scenario = get_leadership_scenario(level)

    console.print(Panel(
        f"[bold]{scenario['title']}[/bold]\n\n"
        f"{scenario['scenario']}\n\n"
        f"[cyan]Leadership Skill:[/cyan] {scenario['leadership_skill']}\n"
        f"[cyan]Suggested Framework:[/cyan] {scenario['framework']}",
        title=f"Level {scenario['level']} — {scenario['category'].replace('_', ' ').upper()}",
        border_style="red",
    ))
    console.print("\n[bold yellow]Key Considerations:[/bold yellow]")
    for point in scenario["key_considerations"]:
        console.print(f"  • {point}")

    response = get_user_response("Your leadership response")

    if not response.strip():
        console.print("[red]No response provided.[/red]")
        return

    # Analyze
    analysis = analyze_text(response)
    scores = compute_scores(analysis, "general")
    leadership_eval = evaluate_leadership_response(response, scenario["category"])

    # Blend leadership score
    scores["persuasiveness"] = max(scores["persuasiveness"], leadership_eval["score"])
    scores["overall"] = sum(
        scores[dim] * SCORING[dim]["weight"] for dim in SCORING
    )
    scores["overall"] = round(scores["overall"], 1)

    print_score_table(scores)

    # Leadership qualities assessment
    console.print("\n[bold]Leadership Qualities Detected:[/bold]")
    for quality, present in leadership_eval["qualities"].items():
        icon = "[green]✓[/green]" if present else "[red]✗[/red]"
        console.print(f"  {icon} {quality.replace('_', ' ').title()}")

    print_feedback(leadership_eval["feedback"])

    record_exercise("Leadership", scenario["title"], scores)
    console.print("\n[green]Progress saved![/green]")
    pause()


# ── Module 5: Progress Dashboard ────────────────────────────────────────────


def run_progress_dashboard():
    """Display the progress dashboard."""
    console.print(Panel("[bold]PROGRESS DASHBOARD[/bold]", border_style="blue"))
    summary = get_progress_summary()

    if summary["total_exercises"] == 0:
        console.print("[yellow]No exercises completed yet. Start practicing to track your progress![/yellow]")
        recommendations = get_recommendations()
        console.print("\n[bold cyan]Recommended Starting Points:[/bold cyan]")
        for rec in recommendations:
            console.print(f"  • {rec}")
        pause()
        return

    # Overview
    console.print(f"  [bold]Total Exercises Completed:[/bold] {summary['total_exercises']}")
    console.print(f"  [bold]Current Daily Streak:[/bold] {summary['current_streak']} day(s)")

    # Category breakdown
    if summary["category_counts"]:
        table = Table(title="\nExercises by Category", box=box.SIMPLE)
        table.add_column("Category", style="bold")
        table.add_column("Completed", justify="center")
        table.add_column("Best Score", justify="center")
        table.add_column("Average", justify="center")
        for cat, count in summary["category_counts"].items():
            best = summary["best_scores"].get(cat, "—")
            avg = summary["category_averages"].get(cat, "—")
            table.add_row(cat, str(count), str(best), str(avg))
        console.print(table)

    # Recent score trend
    if summary["recent_scores"]:
        console.print("\n[bold]Recent Score Trend (last 10):[/bold]")
        for i, score in enumerate(summary["recent_scores"], 1):
            bar_len = int(score / 5)
            bar = "█" * bar_len
            if score >= 75:
                color = "green"
            elif score >= 50:
                color = "yellow"
            else:
                color = "red"
            console.print(f"  {i:2d}. [{color}]{bar}[/{color}] {score}")

    # Recommendations
    recommendations = get_recommendations()
    if recommendations:
        console.print("\n[bold cyan]Personalized Recommendations:[/bold cyan]")
        for rec in recommendations:
            console.print(f"  → {rec}")

    pause()


# ── Main Menu ────────────────────────────────────────────────────────────────


def main():
    """Main application entry point."""
    print_banner()

    while True:
        console.print("\n[bold]═══ MAIN MENU ═══[/bold]\n")
        console.print("  [green]1.[/green] Presentation Coach      — Practice technical presentations")
        console.print("  [yellow]2.[/yellow] Negotiation Simulator   — Vendor & enterprise negotiations")
        console.print("  [magenta]3.[/magenta] Communication Lab       — Emails, meetings, vocabulary")
        console.print("  [red]4.[/red] Leadership Academy      — Decision making & stakeholder management")
        console.print("  [blue]5.[/blue] Progress Dashboard      — Track your improvement")
        console.print("  [dim]0.[/dim] Exit")

        choice = Prompt.ask("\nSelect a module", choices=["0", "1", "2", "3", "4", "5"], default="1")

        if choice == "0":
            console.print("\n[bold cyan]Keep practicing — great leaders never stop improving![/bold cyan]")
            quote, author = get_daily_quote()
            console.print(f'\n  [italic]"{quote}"[/italic]')
            console.print(f"  [dim]— {author}[/dim]\n")
            break
        elif choice == "1":
            run_presentation_coach()
        elif choice == "2":
            run_negotiation_simulator()
        elif choice == "3":
            run_communication_lab()
        elif choice == "4":
            run_leadership_academy()
        elif choice == "5":
            run_progress_dashboard()


if __name__ == "__main__":
    main()
