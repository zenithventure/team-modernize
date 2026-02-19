---
name: daily-report
description: Compile and send a consolidated team report to the human. Three times daily — morning (9:00), midday (13:00), and end-of-day (17:00).
requirements:
  - Read access to shared workspace and standup logs
  - Ability to send messages to human via configured channel
---

# Daily Report Skill

You are compiling a team status report for the human. Reports are sent three times per day: morning, midday, and end-of-day.

## Who Compiles the Report

**Green Ops** is responsible for compiling the final consolidated report. Other agents contribute their sections, and Ops assembles and sends it.

Fallback order: Red Architect → Yellow Builder → Blue QA.

## Report Timing

| Report | Time | Purpose |
|--------|------|---------|
| Morning | 9:00 AM | Set the day's plan and priorities |
| Midday | 1:00 PM | Check progress and surface blockers |
| End-of-Day | 5:00 PM | Summarize results and preview tomorrow |

_(Times in the human's configured timezone)_

## Report Format

### Morning Report
```
Good morning. Here's the team's plan for today.

VISION STATUS: [On track / Adjusting / Blocked]

TODAY'S PRIORITIES:
1. [Task] — Owner: [Agent]
2. [Task] — Owner: [Agent]
3. [Task] — Owner: [Agent]

DECISIONS NEEDED FROM YOU:
- [Decision, if any]
- None today

PIPELINE HEALTH: [All green / Issues detected]
```

### Midday Report
```
Midday check-in.

PROGRESS SINCE MORNING:
- [Completed items]
- [In progress: item — ETA]

BLOCKERS:
- [Blocker, if any]

PR STATUS:
- [Open PRs and their review state]

TEST RESULTS:
- Unit: [X passing / Y failing]
- E2E: [X passing / Y failing]
```

### End-of-Day Report
```
EOD report. Here's how today went.

ACCOMPLISHED TODAY:
- [Deliverables]

CARRIED OVER TO TOMORROW:
- [Incomplete items with reason]

DEPLOYMENTS:
- [What was deployed to production today]

TOMORROW'S PREVIEW:
1. [Top priority]
2. [Second priority]
```

## Guidelines

- **Scannable in 60 seconds.** Details are in standup logs if needed.
- **Honest.** Surface problems early with proposed solutions.
- **Consolidated.** One team report, not four individual reports.
- **Quantified.** "Completed 3 of 5 issues" beats "made progress."
