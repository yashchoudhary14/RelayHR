---
name: session-handoff
description: End-of-session handoff for RelayHR. Appends a short entry to handoff/SESSION_LOG.md so the next fresh thread can continue without the old chat. Use before stopping at any GATE, before recommending a new thread, or when context is getting full.
---

# Session handoff

Append one entry to the **end** of `handoff/SESSION_LOG.md`. Never rewrite earlier entries. Keep it to 15 lines or fewer:

```
## YYYY-MM-DD HH:MM · <phase, e.g. P4 deck v1> · model <name> · effort <level>
- Done: <what is finished, 1–3 bullets>
- Files changed: <paths>
- Checks run: <command → result>
- Decisions: <one line each; also add them to handoff/DECISIONS.md>
- Open questions for the user: <or "none">
- Next step: <exact next action; which playbook phase/step>
- Suggested model for next step: <model · effort>
```

If files changed, also give the user the **git commands** for this chunk, following "Git and authorship" in AGENTS.md: explicit paths, a specific message, and who should commit. Never run them yourself.

Then:
- If the next step needs the user (see the gate list in AGENTS.md), stop and say exactly what you need.
- Otherwise **open the new thread yourself** with the kickoff message from AGENTS.md, and tell the user in one line which thread you opened.
- If you are a worker subagent (the fallback mode), just return your 10-line summary to the parent.
