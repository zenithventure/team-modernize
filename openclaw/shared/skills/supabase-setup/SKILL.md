---
name: supabase-setup
description: Set up and configure a Supabase backend including database, authentication, Edge Functions, and Row Level Security.
requirements:
  - Supabase account (free tier for basics, Pro for branching)
  - GitHub repository for integration
---

# Supabase Setup Skill

Supabase is the complete backend solution: database, authentication, APIs, vector database, and file storage in one platform.

## Initial Setup

### Create Project
1. Go to supabase.com, create an account (GitHub login supported)
2. Create a new project, name it (e.g., "my-app")
3. Set a database password (save it securely)
4. Wait for project to provision

### Get API Credentials
Navigate to Project Settings → API:
- **Project URL** — your Supabase endpoint
- **Anon Key (public)** — safe for client-side use
- **Service Role Key (private)** — server-side only, never expose to clients

### Connect to Frontend
Provide Claude Code with the URL and Anon Key:
```
Claude, here are the Supabase credentials. Please update the project configuration.
URL: https://xxxxx.supabase.co
Anon Key: eyJhbGci...
```

## Database

### Schema Design
- Define tables based on Architect's data model spec
- Use Supabase SQL Editor for manual queries when needed
- Claude Code handles migrations via `npx supabase`

### Seeding Demo Data
When Claude Code can't push data via CLI:
1. Copy the INSERT SQL statements from generated code
2. Open Supabase → SQL Editor
3. Paste and run

### Row Level Security (RLS)
- **Always enable RLS** on every table
- RLS policies control who can read/write what data
- Without RLS, any authenticated user can access all data
- Claude Code generates RLS policies from specs

## Authentication

Supabase Auth provides:
- Email/password signup and login
- Email confirmation flow
- OAuth providers (Google, GitHub, etc.)
- Session management

### Configuration
1. Enable desired auth providers in Supabase → Authentication → Providers
2. Configure redirect URLs (include Vercel domain)
3. Set email templates if needed

## Edge Functions

Server-side functions for operations that need secrets (e.g., Stripe):
- Written in TypeScript/Deno
- Deployed via Supabase CLI
- Access to service role key and other secrets
- **Deploy to branch first, test, then deploy to production**

### Deploy Commands
```bash
npx supabase functions deploy function-name          # to production
npx supabase functions deploy function-name --branch  # to branch
```

## Branching (Pro Plan)

- Every GitHub PR gets its own Supabase branch database
- Branch databases are fully isolated from production
- Perfect for testing data mutations safely
- Branch is deleted when PR is merged or closed

## Integration Checklist

- [ ] Project created and provisioned
- [ ] API credentials saved in environment variables
- [ ] Authentication configured and tested
- [ ] RLS enabled on all tables
- [ ] Database schema matches spec
- [ ] GitHub integration connected
- [ ] Vercel integration connected (for auto env var sync)
