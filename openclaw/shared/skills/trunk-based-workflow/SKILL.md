---
name: trunk-based-workflow
description: The complete issue-driven, trunk-based development lifecycle. From GitHub Issue to merged PR in under a day.
requirements:
  - GitHub CLI (gh) authenticated
  - Claude Code
  - Git configured with correct identity
---

# Trunk-Based Development Workflow Skill

This is the core development lifecycle. Every change follows this exact pattern. No exceptions.

## The Golden Rule

**Main is always deployable.** Every commit on main should represent working software. Branches are short-lived detours that merge back quickly.

## Why Trunk-Based?

The analogy: building a house. The wrong way — everyone goes away for months building their piece, then tries to assemble it all at once. The right way — measure, cut, test-fit, and adjust continuously on-site.

In the AI-assisted era, branches should merge every day or every other day. If a feature takes weeks on a branch, it needs to be broken into smaller pieces.

## The Complete Lifecycle

### 1. Create a GitHub Issue

Before fixing or building anything, create a GitHub Issue:

```
Claude, in the contacts page, when the user clicks on a contact, we want to see
the contact's detail. Please create a detailed GitHub issue.
```

Claude reads the codebase, analyzes the request, and creates a well-structured Issue with specs.

**Issue sizing rule:** Each issue should be completable by Claude Code in ~10 minutes. Larger features must be broken into multiple issues.

### 2. Create a Branch and Fix

Start a fresh Claude Code session (the Issue is the standalone spec):

```
Claude, please fix GitHub Issue #N. Make sure you create a new branch for the fix.
```

Claude creates a branch, implements the fix, and handles compilation errors.

### 3. Test Locally

```
npm run dev
```

Verify the feature works in the browser. If visual bugs appear, screenshot them and paste into Claude Code.

### 4. Commit and Push

```
Claude, please commit and push.
```

Claude commits with a descriptive message and pushes the branch to GitHub.

### 5. Create a Pull Request

Claude creates a PR automatically. The PR is a request for review before merging.

### 6. Review and Merge

After QA approves:
- Merge via GitHub web interface or CLI
- Delete the branch (GitHub offers this automatically after merge)

### 7. Update Local Main

```
Claude, we have merged the PR, please update main from remote.
```

Claude runs `git pull origin main` to sync local with remote.

### 8. Repeat

Pick up the next Issue. Start from step 1.

## Branch Hygiene Rules

- One branch per Issue
- Branch names should reference the Issue number
- Delete branches immediately after merge
- Never maintain long-lived feature branches
- If a branch is open for more than 2 days, it's too large — break it up

## Always Be Integrating (ABI)

This is the guiding principle. Integrate constantly. The fear of "messing up main" causes more problems than frequent merging ever will.
