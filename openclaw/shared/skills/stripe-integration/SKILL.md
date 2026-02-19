---
name: stripe-integration
description: Integrate Stripe payments with subscription tiers, checkout flow, and webhook handling via Supabase Edge Functions.
requirements:
  - Stripe account (Sandbox mode for development)
  - Supabase with Edge Functions enabled
  - Vercel for frontend deployment
---

# Stripe Integration Skill

Add payment processing with subscription tiers to any application.

## Architecture

```
Frontend (Vercel) → Supabase Edge Function → Stripe API
                                           ↓
Stripe Webhooks → Supabase Edge Function → Database Update
```

Four systems in play: Website, Vercel, Supabase, Stripe.

## Setup Steps

### 1. Create Stripe Account
- Sign up at stripe.com
- **Use Sandbox/Test mode** for development (fake money)
- Switch to Live mode only for production

### 2. Design Subscription Tiers
Example structure:
| Tier | Price | Features |
|------|-------|----------|
| Free | $0 | Basic access |
| Pro | $19/month | Full features, priority support |
| Enterprise | $49-99/month | Team features, custom integrations |

### 3. Create Products in Stripe
- Stripe Dashboard → Product Catalog
- Create each tier as a Product with recurring pricing
- Note the **Price IDs** for each tier

### 4. Get API Keys
- Stripe Dashboard → Developers → API Keys
- **Publishable Key** — for client-side (Vercel env var)
- **Secret Key** — for server-side (Supabase Edge Function env var)

### 5. Create Webhook Endpoint
- Stripe Dashboard → Developers → Webhooks
- Point to your Supabase Edge Function URL
- Subscribe to these events:
  - `checkout.session.completed`
  - `customer.subscription.created`
  - `customer.subscription.updated`
  - `customer.subscription.deleted`
  - `invoice.payment.failed`
  - `invoice.payment.succeeded`
- Note the **Webhook Secret**

### 6. Set Environment Variables

**In Supabase (Edge Functions):**
- `STRIPE_SECRET_KEY`
- `STRIPE_WEBHOOK_SECRET`
- `STRIPE_PRO_PRICE_ID`
- `STRIPE_ENTERPRISE_PRICE_ID`

**In Vercel (Frontend):**
- `NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY`
- `SITE_URL` (for redirect after checkout)

### 7. Database Tables
Create tables for tracking customers and subscriptions:
- `customers` — maps Supabase user IDs to Stripe customer IDs
- `subscriptions` — tracks active subscriptions, tiers, status

### 8. Edge Functions
Create Supabase Edge Functions for:
- **Checkout** — creates Stripe Checkout session, redirects user to Stripe
- **Webhooks** — receives events from Stripe, updates database
- **Customer portal** — lets users manage their subscriptions

## Testing

- Use Stripe test card: `4242 4242 4242 4242`
- Any future expiry date, any CVC
- Verify in Stripe Dashboard that payments appear
- Check database tables update correctly via webhooks

## Common Issues

| Problem | Cause | Fix |
|---------|-------|-----|
| CORS errors | Edge Function not deployed to correct branch | Deploy to branch: `npx supabase functions deploy --branch` |
| Redirect to localhost | `SITE_URL` not set or set to localhost | Update Vercel env var to actual deployment URL |
| Webhook failures | Wrong endpoint URL or missing webhook secret | Verify URL and secret in Stripe Dashboard |
| Wrong project ref | Env vars pointing to wrong Supabase instance | Double-check project ref ID in all env vars |

## Deployment Order

1. Deploy Edge Functions to branch (not production) first
2. Set Vercel env vars for preview branch
3. Test in preview environment
4. After merge, deploy Edge Functions to production
5. Update Vercel production env vars if needed
