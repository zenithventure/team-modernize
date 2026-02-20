# Real Estate — AI Deal Desk & Loan Processing Team

An OpenClaw agent team that handles real estate deal analysis, document review, and pipeline management. Four agents work together to evaluate properties, review financials, track due diligence, and drive deals to close.

## What This Team Does

- Analyzes comparable property sales and market data
- Reviews financial documents (T12s, rent rolls, 3-year financials)
- Scores deals on financial risk and return metrics
- Tracks due diligence checklists and document collection
- Manages deal pipeline from sourcing to close
- Generates investment summaries and underwriting reports

## Who It's For

- Real estate investors evaluating acquisitions
- Commercial lenders processing loan applications
- Brokers preparing deal packages
- Property managers reviewing portfolio performance
- Anyone doing real estate deals who drowns in document review

## What It Replaces

- **Weeks of analyst time** reviewing property financials manually
- **$50K+ annually** in deal processing and analysis costs
- **Missed details** in rent rolls and operating statements that lead to bad deals
- **Scattered checklists** and document tracking across email and spreadsheets

This team embodies the VeloQuote concept: AI-powered processing that turns weeks of manual review into hours of structured analysis.

## The Team

| Agent | Color | DISC | Role |
|-------|-------|------|------|
| **Deal Maker** | 🔴 Red | Dominant | Drives deals forward. Pipeline management. Go/no-go recommendations. |
| **Analyst** | 🟡 Yellow | Influencer | Market research, comp analysis, property valuation. Clear presentations. |
| **Coordinator** | 🟢 Green | Steady | Document collection, deadline tracking, stakeholder communication. |
| **Underwriter** | 🔵 Blue | Conscientious | Financial document review, risk scoring. Advisory only — cannot modify deal terms. |

## Example Workflow

1. You upload property documents (T12, rent roll, financials, offering memo)
2. **Analyst** pulls comparable sales and market data, estimates property value
3. **Underwriter** reviews the financial documents, scores risk, flags discrepancies
4. **Coordinator** tracks which documents are received and which are still needed
5. **Deal Maker** synthesizes all inputs and recommends go/no-go with reasoning
6. You make the final investment/lending decision

## Skills

| Skill | What It Does |
|-------|-------------|
| `comp-analysis` | Comparable property analysis methodology |
| `document-review` | T12, rent roll, and financials review process |
| `deal-pipeline` | Deal stages, milestone tracking, stakeholder updates |
| `risk-assessment` | Financial risk scoring, red flags, underwriting criteria |
| `due-diligence` | Due diligence checklist and document collection tracking |
| `team-standup` | Coordinated team check-ins |
| `daily-report` | End-of-day summary generation |
| `vision-sync` | Alignment with shared VISION.md |

## Setup

```bash
git clone https://github.com/zenithventure/openclaw-agent-teams.git
cd openclaw-agent-teams/real-estate
./setup.sh

# Configure your deal
# Edit ~/.openclaw/shared/VISION.md with property/deal details

# Start
openclaw start
```

## Examples

See `examples/` for sample VISION files:

- **VISION-multifamily-acquisition.md** — Evaluating a 50-unit apartment complex
- **VISION-commercial-loan.md** — Processing a $5M commercial real estate loan
- **VISION-portfolio-review.md** — Quarterly review of a 10-property portfolio

## Limitations

- **Not a licensed appraiser.** Comp analysis is for internal evaluation, not formal appraisal.
- **Not legal advice.** Document review is financial, not legal. Use counsel for contracts and title.
- **Human review required.** Final underwriting and investment decisions must be made by qualified humans.
- **Data dependent.** Analysis quality depends on the data you provide. Garbage in, garbage out.
- **No MLS access.** Agents work with data you provide — they don't pull from MLS or public records directly.

## License

MIT
