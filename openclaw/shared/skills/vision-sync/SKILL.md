---
name: vision-sync
description: Synchronize with the team Vision. Read VISION.md, understand current objectives, and align your work accordingly.
requirements:
  - Read access to shared/VISION.md
  - Read access to shared/standup-log.md
---

# Vision Sync Skill

This skill ensures all agents stay aligned with the team's Vision across sessions.

## When to Use

- At the start of every session (you wake up fresh — the Vision is your orientation)
- During every heartbeat/standup
- Before starting any new task (verify it serves the Vision)
- When you're unsure what to prioritize

## Sync Protocol

### Step 1: Read the Vision
Read `shared/VISION.md` completely. Pay attention to:
- The mission statement (your north star)
- Success criteria (how you know you're done)
- Constraints (boundaries you must respect)
- Priority order (when you must choose, what wins)
- Current phase and active priorities (maintained by the team)

### Step 2: Check Team Context
Read `shared/standup-log.md` for the latest team state:
- What have other agents accomplished?
- What decisions were made?
- What blockers exist?
- What's the current division of labor?

### Step 3: Align Your Work
Based on your role, determine:
- **What should I work on?** (Highest-impact task within your role)
- **Does my current work serve the Vision?** (If not, pivot)
- **Am I duplicating someone else's work?** (Coordinate, don't collide)
- **Are there gaps no one is covering?** (Flag them for the team)

### Step 4: Update Shared State
If the Vision status has changed based on your work:
- Update the "Current Phase" section of VISION.md
- Update "Active Priorities" if priorities have shifted
- Log any key decisions in the decisions table
- Flag new blockers if discovered

## Role-Specific Alignment

**Red Architect:** Focus on whether specs are complete and accurate for current priorities. Size and create GitHub Issues ahead of Builder's needs.

**Yellow Builder:** Focus on implementing the highest-priority Issues. Follow trunk-based workflow. Ship small, merge fast.

**Green Ops:** Focus on pipeline health and deployment status. Ensure environments are correctly configured for current work.

**Blue QA:** Focus on reviewing open PRs and running tests. Validate that implementations match specs.

## Vision Not Configured?

If `shared/VISION.md` still contains the placeholder template:
1. Do NOT start working on arbitrary tasks
2. Notify the human: "The Vision hasn't been configured yet. Please update shared/VISION.md with your project's mission."
3. In the meantime, each agent should prepare:
   - Architect: Review spec-first-development skill
   - Builder: Verify dev environment and tools
   - Ops: Check infrastructure connections
   - QA: Prepare testing frameworks
