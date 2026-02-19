---
name: deploy-to-production
description: Deploy a Next.js application to Vercel with Supabase backend integration. First deployment and ongoing auto-deployments.
requirements:
  - Vercel account (free tier)
  - Supabase project with database and auth configured
  - GitHub repository with the project
---

# Deploy to Production Skill

## First-Time Deployment

### Step 1: Prepare Vercel
1. Sign up at vercel.com (free tier works)
2. Link Vercel to your GitHub account
3. Import project from GitHub
4. **Set the root directory** to the frontend folder (e.g., `frontend`) if the Next.js app isn't at the repo root

### Step 2: Configure Environment Variables
Import these into Vercel's dashboard:

| Variable | Source |
|----------|--------|
| `NEXT_PUBLIC_SUPABASE_URL` | Supabase → Project Settings → API |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Supabase → Project Settings → API |
| `SUPABASE_SERVICE_ROLE_KEY` | Supabase → Project Settings → API |

Plus any Stripe keys, site URLs, etc.

### Step 3: Deploy
Click "Deploy" in Vercel. Wait for the build to complete.

### Step 4: Verify
Open the Vercel URL. Check:
- Page loads without errors
- Authentication works (login/signup)
- Data loads from Supabase
- All features functional

## Auto-Deployment (Ongoing)

After the first deployment, Vercel auto-deploys on every push to main:

1. Push code to GitHub
2. Vercel detects the push
3. Build starts automatically
4. New version goes live (~30-60 seconds)

## Troubleshooting Common Issues

### Build Fails
- Share the error log with Claude Code
- Common cause: missing environment variables
- Common cause: TypeScript errors not caught locally

### Auth Not Working
- Check `SITE_URL` environment variable
- Ensure Supabase redirect URLs include the Vercel domain

### Git Identity Mismatch
- Vercel may not auto-build if the commit author email doesn't match the Vercel account email
- Fix: update git config email to match Vercel login

### CORS Errors
- Edge Functions not deployed to the correct branch
- Environment variables pointing to wrong Supabase project ref

## Environment Variable Management

- **Production:** Set in Vercel dashboard, applies to main branch
- **Preview:** Set separately in Vercel, or auto-synced via Supabase integration
- **Never** hardcode secrets in source code
- **Always** use `.env` files locally (which are .gitignored)
