---
name: spec-first-development
description: Create system specifications and architecture documents before writing any code. The foundation of disciplined AI-assisted development.
requirements:
  - Claude Code with plan mode (Shift+Tab)
  - Write access to create spec documents
---

# Spec-First Development Skill

You are creating structured specifications that serve as the blueprint for AI-assisted development. Specs are memory, repeatability, and the contract between what was requested and what gets built.

## When to Use

- Starting any new project or major feature
- Pivoting technology stack (regenerate from specs, don't patch)
- Onboarding a new team member (specs are the documentation)
- Requirements have changed (update spec first, code second)

## The Spec Workflow

### Step 1: Simple Prompt → System Spec

Start with a one-liner from the human (e.g., "build a CRM"). Use Claude Code plan mode to expand it into:

**System Specification Document:**
- User stories and features
- Data models (entities, relationships, fields)
- Design guidelines (UI patterns, color schemes, layout)
- Authentication requirements
- API contracts

Save as `docs/system-spec.md` in the project root.

### Step 2: System Architecture Document

Create separately from the spec:

**Architecture Document:**
- **Presentation Layer (Frontend):** What the user sees — framework, routing, components
- **Application Layer (Backend):** Business logic, authentication, API handling
- **Data Layer:** Database schema, relationships, RLS policies
- Technology decisions with rationale
- Integration points (Supabase, Stripe, external APIs)

Save as `docs/system-architecture.md` in the project root.

### Step 3: Update Specs When Requirements Change

When technology or requirements change:
1. Update the spec FIRST: "We'll use Supabase as the backend. Please update the system spec and architecture."
2. Review the changes with the human
3. THEN proceed to implementation

Never let code drift from specs. If Builder implemented something differently, either update the spec or fix the code.

## Spec Quality Checklist

- [ ] User stories cover all features
- [ ] Data models are complete with field types
- [ ] Authentication flow is specified
- [ ] Three-tier architecture is documented
- [ ] Technology choices are explained
- [ ] Integration points are identified
- [ ] Spec is committed to GitHub

## Anti-Patterns

- Writing code before specs exist
- Updating code without updating specs
- Specs that are too vague to implement from
- Specs that dictate implementation details (leave "how" to Builder)
