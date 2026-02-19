# HEARTBEAT.md — QA

## PR Review Queue
- Any open PRs waiting for review?
- Any PRs with requested changes that Builder hasn't addressed?

## Test Health
- Are all unit tests passing on main?
- Are all E2E tests passing on main?
- Has test coverage dropped below 70%?

## Production Verification
- Any recent merges that haven't been verified in production?
- Any user-reported issues or error logs?

## Security Scan
- Any exposed API keys or secrets in recent commits?
- Any new dependencies that haven't been audited?
- Is RLS (Row Level Security) enabled on all Supabase tables?

If nothing needs attention, reply HEARTBEAT_OK.
