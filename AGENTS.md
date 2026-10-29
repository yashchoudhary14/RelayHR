# AGENTS.md — standing rules for coding agents in this repo

Project: **RelayHR**, our TBO VoyageHack 4.0 entry for the *AI-Native HR Services Platform (Darwinbox)* problem statement.
Current stage is the Round 1 concept submission: a 2-slide deck, a document of up to 6 pages, and a 5-minute video. The internal freeze is 10 Nov 2026.

## Read first, every session
1. `handoff/SESSION_LOG.md`, **latest entry only**: what the previous session finished and what comes next.
2. `handoff/CODEX_SUBMISSION_PLAYBOOK.md`: **only the section for the phase you were asked to run**. Run that phase, then stop at its GATE.
3. `handoff/DECISIONS.md`, plus the earlier-phase outputs this phase needs.
   Do not re-read everything. `handoff/STATUS_REVIEW.md` is background; open it only when you need the reasoning behind a decision.

## Authority
- Requirements: `problem_statement/Problem Statement/Zendesk-Darwin box Automation.pdf`, **pages 8–13** (HR). Pages 1–8 are a different challenge.
- Portal rules: `research/portal_rules.md`, which records what the user confirmed in the Unstop dashboard.
- Numbers: `analysis/cost_summary.md` is the only source for cost and volume figures.
- When this playbook disagrees with `handoff/codex_round1_plan_original.md`, the playbook wins.

## Rules
- Use only facts recorded in `research/claims_register.md`, with source and access date. If you cannot verify a fact, leave it out.
- Label every number on slides, document and video as one of:
  - T = target
  - E = estimate
  - M = measured (n, date, machine)
  - B = from the brief
- Never write "first", "only", "unique", "guaranteed", "100%", "DPDP-compliant", "certified", "zero cost" or "replaces Darwinbox". Never write savings claims without a formula. Never fake screenshots, logos or testimonials.
- Never disparage Darwinbox or other vendors. Competitor names belong only in speaker notes or `research/`.
- Use only fictional people and data.
- Edit the generator scripts, never only the binary output, so builds stay reproducible.
- After every deck or document change, run `tools/check_pptx.py` (deck) and render with `tools/render_pptx.ps1` or the Word render script. Then **look at every rendered page** before reporting.
- Ask the user before installing software, downloading models, or publishing anything online. Never run git write commands yourself; give the user the commands (see "Git and authorship").
- Log non-trivial choices in `handoff/DECISIONS.md` (date, decision, reason).
- Use `python -P -E` (or a venv) when a script reads files under `problem_statement/`.

## Working efficiently (sessions, models, subagents, skills)

### Sessions: keep context fresh
- **One phase = one new thread.** Every session starts from the files, never from an old chat.
- Before you stop, invoke `$session-handoff`. It appends to `handoff/SESSION_LOG.md`: what was done, files changed, checks run, next step, and open questions. The next thread depends on this entry.
- **Open the next thread yourself.** Do not ask the user to do it. Open a new thread when any of these happens:
  - the phase is finished and the next phase does not need the user
  - `/status` shows context more than about 60% used
  - the work switches type, for example from research to building
  - a debugging detour or failed approach has filled the chat with noise
  - you notice yourself re-reading the same files

  How to do it:
  1. Run `$session-handoff`.
  2. Open a new thread in this project with the model and effort from the playbook calendar for the next phase.
  3. Give it this kickoff message: "Continue the RelayHR work. Read AGENTS.md and only the latest entry in handoff/SESSION_LOG.md, then run its Next step (Phase <X> of handoff/CODEX_SUBMISSION_PLAYBOOK.md). Continue automatically per AGENTS.md."
  4. Tell the user in one line which thread you opened and for what.
- **Do not open a new thread; stop and wait in the current one** when the next step needs the user:
  - P1 facts
  - git setup or commits (see "Git and authorship")
  - P3 numbers approval
  - the P3B install
  - Fable reviews
  - the doc and video links
  - video recording
  - submission
  - any install, download or publish

  After the user answers, continue as above.
- If opening threads is unavailable in the current surface, fall back to spawning a fresh-context **worker subagent** for the phase with the same kickoff message, and check its result yourself.
- Use `/compact` only to continue the **same** task while needing its history. Otherwise prefer a new thread plus the session log.
- Never run two threads that write the same files at the same time. Only one phase thread works at a time.

### Git and authorship: the humans commit, not Codex
The brief says finalists are questioned individually and asks for a clean commit history, so every commit must be made by a team member from their own machine and identity.
- **Never run** `git init`, `git add`, `git commit`, `git push`, or anything else that creates or rewrites history. Read-only git (`git status`, `git diff`, `git log`) is fine.
- **Never add** `Co-authored-by` trailers or AI attribution to commit messages. The AI-assistance disclosure belongs in the README or the thank-you slide.
- At each GATE (and whenever a coherent chunk of work is done), give the user a **ready-to-run command block**:
  - First time only, setup:
    ```
    git init
    git config user.name "<Your Name>"
    git config user.email "<your GitHub email>"
    git branch -M main
    ```
    Also give the `.gitignore` content to create, and later the `gh repo create` or `git remote add origin <url>` and `git push -u origin main` commands, once the user has made the GitHub repo.
  - Every commit: `git status`, then `git add <explicit paths for this chunk>` (never `git add .` blindly), then `git commit -m "<imperative, specific message>"`, then `git push`.
  - Split work into small, meaningful commits, for example "Add requirements matrix and claims register", not "update files".
  - When different teammates own different parts, say **who** should commit **which** paths, so each person's history shows their own work.
- Before the commands, show a 3-line summary of what changed, so the committer can explain it if asked.

### Models and reasoning effort: cheapest model that does the job well
Check the model picker or `/model` for what is actually available. As of 29 Oct 2026 the docs list:
- `gpt-6.1-sol`: the default
- `gpt-6.1-terra`: fast
- `gpt-6-luna`: smallest and cheapest
- `gpt-6-astra`: most capable

| Work | Model · effort |
|---|---|
| Mechanical: rename, fill links, grep for banned words, run checks, reformat tables | `gpt-6-luna` · medium (or `gpt-6.1-terra` · low) |
| Reading and summarising sources, extracting facts | subagent `researcher` (luna · high) |
| Normal phase work: writing copy, building the deck or document, scripts | `gpt-6.1-sol` · medium |
| Reasoning-heavy work: cost model, architecture consistency, fixing a stubborn layout bug | `gpt-6.1-sol` · high |
| Stuck after two failed attempts at the same thing | escalate once to `gpt-6-astra`, then drop back |

Higher effort costs more tokens and time. Only raise it when the lower level has actually failed.

### Subagents: keep the main thread clean
- **Delegate read-heavy or noisy work:**
  - researching several sources in parallel
  - checking a deck or document against the requirements matrix
  - scanning for banned phrases and unlabelled numbers
  - reading long logs
  The subagent returns a **short summary with file or URL references**, not raw dumps.
- **Do not delegate:**
  - one-line tasks (subagent workflows use more total tokens than doing it yourself)
  - writes to the same files in parallel
  - decisions the user must make
- Project custom agents (in `.codex/agents/`):
  - `researcher`: read-only, cites sources
  - `reviewer`: read-only QA against these rules
  Spawn them by name, for example: "Spawn 4 researcher subagents, one per topic in P2.2 rows 2–5; wait for all; merge into research/."
- Subagents inherit your sandbox and approvals. They must still never install, publish or run git write commands.

### Skills and plugins: give yourself ways to verify
- `$deck-qa`: the full verify loop for the deck (build → check → render → inspect PNGs → fix). Run it after every deck change.
- `$session-handoff`: end-of-session log entry.
- Built-in plugins are enabled in this Codex app; use them when they fit:
  - **Browser**: JS-heavy pages such as Unstop
  - **PDF**: reading the brief
  - **Presentations / Documents**: PPTX and DOCX work
  Any output must still pass `tools/check_pptx.py` and a render check.
- For multi-step or unclear work, write a short plan first (`/plan`). Then work toward a **goal with a verifiable "done when"**, not a vague task.
