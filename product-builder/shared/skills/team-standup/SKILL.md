---
name: team-standup
description: Run a structured standup check-in across all agents every 30 minutes. Track progress, surface blockers, and align priorities.
requirements:
  - Read access to shared workspace and agent workspaces
  - Write access to shared/standup-log.md
---

# Team Standup Skill

Every 30 minutes, the team synchronizes through a structured standup.

## Who Runs the Standup

**Red Architect** leads the standup. If Architect is unavailable, fallback order: Green Ops → Yellow Builder → Blue QA.

## Standup Protocol

### Step 1: Architect Opens
Review the current Vision and active priorities from `shared/VISION.md`.

### Step 2: Each Agent Reports (30 seconds each)

**Three questions:**
1. What did you accomplish since last standup?
2. What are you working on next?
3. What's blocking you?

**Order:** Architect → Builder → Ops → QA

### Step 3: Priority Alignment
- Are we all working toward the same Vision?
- Any priority conflicts?
- Any tasks that should be reprioritized?

### Step 4: Log It
Update `shared/standup-log.md` with:

```markdown
## Standup — YYYY-MM-DD HH:MM

### Accomplished
- [Agent]: [What they did]

### In Progress
- [Agent]: [What they're doing next]

### Blockers
- [Agent]: [What's blocking them]

### Decisions Made
- [Decision and reasoning]

### Priority Changes
- [Any shifts and why]
```

## Rules

- Keep it short. 5 minutes max for the whole standup.
- If no blockers, say so explicitly.
- If a blocker needs human input, escalate it immediately — don't wait for the next standup.
- Don't rehash old information. Focus on what's changed.
