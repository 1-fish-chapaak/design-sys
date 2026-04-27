# ADR template

Filename: `decisions/NNNN-<slug>.md` where NNNN is the next sequential number (don't recycle, don't skip). Look at `ls decisions/` to pick.

## When to add an ADR (triggers from CLAUDE.md)

- A new dependency, framework, or service is adopted (or rejected)
- A change touches deploy, migration, or auth flow
- A trade-off is made that a future contributor would otherwise revisit blind
- A reviewer asks "why did we choose X?" and the answer isn't already written down

## Template

```markdown
# ADR NNNN: <decision in one line>

**Status:** Accepted / Deferred / Rejected (YYYY-MM-DD)
**Context:** Brief — what triggered this decision, what was the prior state.

## Decision

What we decided. Be specific. Name files/services/versions.

## Considered alternatives

1. **<Alternative A>** — why rejected (one sentence).
2. **<Alternative B>** — why rejected (one sentence).
3. (deferred alternatives go here too — explain why later)

## Consequences

- Positive consequence
- Negative consequence
- Things to revisit
```

## Rules

- Once Accepted, **do not rewrite or delete** an ADR. Supersede with a new ADR if the decision changes ("Supersedes ADR NNNN").
- Status `Deferred` is valid — for explicit "we considered this but not now" entries.
- Numbered prefix ensures chronological sort.
- Keep it under one page. ADR ≠ design doc.

## Where it sits next to notes

- `decisions/` = durable, load-bearing.
- `notes/` = transient (review reports, follow-ups, design notes). Branch-tagged variant: `notes/NNNN-<branch>-<slug>.md` for traceability.
