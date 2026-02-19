---
name: cicd-pipeline
description: Set up and maintain CI/CD pipelines across DEV, QA, and PROD environments using GitHub, Vercel, and Supabase.
requirements:
  - Vercel account connected to GitHub
  - Supabase Pro plan (for branching)
  - GitHub repository
---

# CI/CD Pipeline Skill

Continuous Integration and Continuous Delivery. The entire purpose is speed and safety — eliminating the temptation to fix things directly in production.

## The Three Environments

| Environment | Purpose | Components |
|-------------|---------|------------|
| **DEV** | Sandbox for experimentation | Local machine, `npm run dev`, localhost |
| **QA / Preview** | Mimics production for testing | Vercel preview deployment + Supabase branch database |
| **PROD** | Real customer-facing environment | Vercel production + Supabase production database |

**Rule:** Never fix bugs directly in production. Always flow through DEV → QA → PROD.

## Pipeline Architecture

```
GitHub (code) ←→ Vercel (frontend hosting) ←→ Supabase (backend/database)
```

All three systems are connected and sync automatically.

## Setup Steps

### Connect Supabase to GitHub
1. Supabase Dashboard → Project Settings → Integrations
2. Connect GitHub → select your repository
3. Enable automatic branching
4. Turn OFF "Supabase changes only" (every GitHub branch should get a Supabase branch)

### Connect Vercel to Supabase
1. Same Integrations page → Connect Vercel
2. Select your Vercel project
3. Enable preview settings for automatic env var sync

### Result
- Every GitHub branch → Vercel preview deployment
- Every PR → Supabase branch database (isolated from production)
- Merge to main → Vercel rebuilds production, Supabase reconnects to production DB

## The Three-Step Deploy Flow

### Step 1: Push Feature Branch
- Vercel auto-deploys a preview
- ⚠️ Preview points to PRODUCTION database at this stage
- Safe for UI-only changes, risky for data mutations

### Step 2: Create PR
- Vercel redeploys the preview
- Supabase creates a branch database (isolated copy)
- Preview now has its own database — fully safe to test
- Can iterate: push more commits, preview auto-updates

### Step 3: Merge PR
- Merge into main
- Vercel rebuilds production (~48 seconds typical)
- Supabase reconnects to production database
- Changes are live for customers

## Database Migrations

When schema changes are needed (e.g., changing a field from single value to array):
1. Write migration SQL
2. Test in branch database first
3. Include migration in the PR
4. Migration runs automatically on merge to production

## Monitoring Checklist

- [ ] Vercel builds succeeding on every push
- [ ] Supabase branches creating for every PR
- [ ] Environment variables synced across systems
- [ ] Preview deployments accessible and functional
- [ ] Production stable after every merge

## Historical Context

In the 1990s, a dedicated team would spend a week pushing code to production. Today, robots handle this in minutes. CI/CD is what makes trunk-based development possible.
