---
root: true
description: Project rules
---
## MANDATORY: Use td for Task Management (td-task-management skill)

Run td usage --new-session at conversation start (or after /clear). This tells you what to work on next.

## Agent skills

### Issue tracker

Issues are tracked with `td`; use the td task-management workflow for creating, reading, updating, handing off, and reviewing issues. See `docs/agents/issue-tracker.md`.

### Triage labels

Triage roles map to td-native statuses/workflow notes rather than external labels. See `docs/agents/triage-labels.md`.

### Domain docs

Single-context domain docs: read root `CONTEXT.md` and `docs/adr/` when present. See `docs/agents/domain.md`.
