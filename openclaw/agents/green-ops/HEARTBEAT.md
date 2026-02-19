# HEARTBEAT.md — Ops

## Deployment Health
- Check latest Vercel build status (production and any active previews)
- Any failed builds in the last 24 hours?
- Are all environment variables correctly configured?

## Pipeline Status
- GitHub → Vercel integration healthy?
- Supabase branching creating preview databases for PRs?
- Stripe webhooks responding successfully?

## Environment Sync
- DEV, QA, PROD environments all consistent?
- Any environment variable drift between environments?
- Database migrations up to date across all environments?

## Cost Monitoring
- Supabase free tier / Pro tier usage levels?
- Vercel build minutes remaining?
- Stripe test mode vs. live mode configured correctly?

If nothing needs attention, reply HEARTBEAT_OK.
