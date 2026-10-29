# Global Codex habits (applies to every project)

<!-- Installed at C:\Users\yashc\.codex\AGENTS.md. Restart Codex after editing. Project rules go in each repo's own AGENTS.md;
     project rules override these when they conflict. To uninstall, empty that file. -->

## Sessions
- One task or phase per thread.
- For work that spans several sessions, keep a short `SESSION_LOG.md` in the project. Before stopping, append about 10 lines: done, files changed, checks run, next step, open questions. Skip this for quick one-off tasks.
- Open the next thread yourself (do not ask me) when any of these happens:
  - the task is done and a new one begins
  - `/status` shows more than about 60% context used
  - the work changes type (research → build → review)
  - a failed approach has cluttered the chat
- Use `/compact` only to keep going on the same task.
- Before opening it, write the session-log entry and give the new thread a short kickoff message pointing to that entry. Tell me in one line which thread you opened.
- Do not move on when the next step needs me (decisions, approvals, installs, publishing); stop and wait instead.

## Models
- Use the cheapest model and effort that does the job.
  - Mechanical edits and checks: the smallest model at medium effort.
  - Normal work: the default model at medium.
  - Hard reasoning or debugging: high effort.
  - The most capable model only after two failed attempts.
- When a task ends, say which model and effort you would recommend for the next step.

## Subagents
- Delegate read-heavy or noisy work (searching, reading many files or pages, logs, review checklists) to read-only subagents on a small model. They return short summaries with references.
- Don't delegate one-liners, parallel writes to the same files, or decisions I must make.

## Verification
- Work toward a goal with a "done when" you can check: tests, linters, builds, renders, screenshots, page or slide counts.
- Run the check, look at the result, fix, and repeat before reporting. Never report "done" without evidence.

## Safety
- Ask before installing software, downloading large files, or publishing anything.

## Git: I commit, not you
- Never run git commands that change history (`init`, `add`, `commit`, `push`, `rebase`, `reset`). Read-only ones (`status`, `diff`, `log`) are fine.
- Never add `Co-authored-by` or AI attribution trailers.
- When a meaningful chunk is done, give me a ready-to-run block: `git add <explicit paths>`, then `git commit -m "<specific imperative message>"`, then `git push`. Put a 3-line summary of the change above it, so I can explain it.
