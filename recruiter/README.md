# Recruiter — AI-Powered Recruiting Team

An OpenClaw agent team that handles the full recruiting pipeline: sourcing candidates, designing interviews, coordinating scheduling, and ensuring compliance. Four agents work together to find, evaluate, and move candidates through your hiring process.

## What This Team Does

- Sources and screens candidates against role requirements
- Writes job descriptions that are engaging and inclusive
- Designs structured interview questions with scoring rubrics
- Manages candidate pipeline and scheduling
- Tracks EEO compliance and flags bias in the process
- Generates pipeline reports and hiring recommendations

## Who It's For

- Startups hiring their first 10–50 employees
- Small businesses without an HR department
- Founders doing their own recruiting
- Hiring managers who want a structured process without the overhead
- Anyone tired of paying agency fees for roles they could fill themselves

## What It Replaces

- **$15K–$30K per-hire agency fees** (20–25% of first-year salary)
- **20+ hours/week** of founder time spent on recruiting tasks
- **$5K–$10K/month** for an in-house recruiter (at early stage)
- Ad hoc, unstructured interview processes that lead to bad hires

## The Team

| Agent | Color | DISC | Role |
|-------|-------|------|------|
| **Headhunter** | 🔴 Red | Dominant | Drives the pipeline. Sources candidates. Makes go/no-go calls. Direct feedback. |
| **Interviewer** | 🟡 Yellow | Influencer | Designs interview questions. Writes job descriptions. Warm and personable. |
| **Coordinator** | 🟢 Green | Steady | Manages scheduling, follow-ups, pipeline tracking. Keeps everything moving. |
| **Compliance** | 🔵 Blue | Conscientious | EEO tracking, bias detection, adverse impact analysis. Read-only advisory. |

## Example Workflow

1. You define the role in `VISION.md` (title, requirements, comp range, timeline)
2. **Interviewer** writes an inclusive, compelling job description
3. **Compliance** reviews the JD for biased language or exclusionary requirements
4. **Headhunter** defines screening criteria and evaluates incoming candidates
5. **Interviewer** generates structured interview questions with scoring rubrics
6. **Coordinator** tracks candidates through pipeline stages and manages communications
7. **Compliance** audits the pipeline for adverse impact and EEO compliance
8. **Headhunter** makes recommendations — you make the final decision

## Skills

| Skill | What It Does |
|-------|-------------|
| `candidate-screening` | Resume parsing, scoring criteria, red/green flags |
| `interview-design` | Structured questions by role type, scoring rubrics |
| `job-description` | Writing inclusive, effective JDs with anti-bias checks |
| `pipeline-management` | Candidate tracking through stages, SLA monitoring |
| `eeo-compliance` | Equal opportunity tracking, adverse impact analysis |
| `team-standup` | Coordinated team check-ins |
| `daily-report` | End-of-day summary generation |
| `vision-sync` | Alignment with shared VISION.md |

## Setup

```bash
git clone https://github.com/zenithventure/openclaw-agent-teams.git
cd openclaw-agent-teams/recruiter
./setup.sh

# Configure your role
# Edit ~/.openclaw/shared/VISION.md with the position details

# Start
openclaw start
```

## Examples

See `examples/` for sample VISION files:

- **VISION-startup-engineer.md** — Senior full-stack engineer for a seed-stage startup
- **VISION-sales-team.md** — Building a 3-person SDR team for SaaS
- **VISION-executive-search.md** — VP of Engineering with confidentiality requirements

## Limitations

- **Not a replacement for human judgment.** The team sources, screens, and recommends — you decide who to hire.
- **Human-in-the-loop required for offers.** Never extend an offer based solely on agent recommendations.
- **No direct platform integrations.** Agents don't post to LinkedIn or job boards directly — they prepare the content.
- **US-focused compliance.** EEO and OFCCP guidance is US-oriented. Adapt for other jurisdictions.
- **Not legal advice.** Compliance agent flags issues but is not a substitute for employment counsel.

## License

MIT
