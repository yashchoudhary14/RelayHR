# Copy-paste prompts for Codex (one per thread)

## Easiest way: one prompt, Codex chains the threads itself
Open **one** new thread on `gpt-6.1-sol` · medium and paste:
```
Start the RelayHR Round 1 work. Follow AGENTS.md: run Phase P0 now, and after each phase open the next thread yourself (with the model from the playbook calendar and the kickoff message in AGENTS.md). Stop only at the user gates listed in AGENTS.md. Never run git write commands; give me the commands to run.
P1 facts: deadline <..>; file types/size <..>; video upload or link <..>; form fields <..>; team name <..>; members <..>; contact email <..>; narrator <..>; video host <..>.
```
What happens next:
- Codex finishes a phase, writes its `SESSION_LOG.md` entry, **opens the next thread itself**, and tells you which one it opened. Follow the newest thread.
- When it needs you (approvals, numbers, Fable review, links, recording, submission), it stops in that thread. Answer there, and it carries on.
- At each gate it gives you **git commands to run yourself** (see "Your commits" below).
- If it ever stops without opening a thread, open one yourself and paste the **reset prompt** at the bottom of this file.

## Your commits (so GitHub shows your work, not Codex's)
- Codex never commits. At each gate it prints a command block: `git add <paths>` and `git commit -m "..."`. **Run it yourself** in your own terminal, or in the terminal of the teammate who owns that part.
- **One-time setup on each teammate's machine:** `git config user.name` and `git config user.email` must match that person's GitHub account. Otherwise GitHub will not link the commits to their profile.
- **Read the 3-line change summary before you commit.** Finalists are asked individually about the parts they built.

## Manual alternative (if you prefer to drive each thread)
1. **Start a new thread** (the New thread button in the Codex app, or `/new` in the CLI) with the project folder `C:\dev\Voyage Hackathon` open.
   Never continue a previous phase's thread. Each new thread reads `AGENTS.md`, plus the latest entry in `handoff/SESSION_LOG.md`, and nothing else from the past.
2. **Set the model and reasoning level** shown in the session header below, using the composer's model picker (or `/model`).
3. Paste the prompt, which is written as a **goal with a "done when"** so Codex can check its own work. In manual mode, add: "Do not open the next thread; stop at the gate."
4. If a thread gets long or confused, use the **reset prompt** at the bottom.

**What Codex does by itself** (from `AGENTS.md`):
- reads only the files it needs
- sends read-heavy work to cheap read-only subagents (`researcher`, `reviewer` in `.codex/agents/`)
- verifies decks with the `$deck-qa` skill
- writes a `$session-handoff` entry before stopping
- opens the next thread itself, and hands you git commands instead of committing

**First run only:** in Session 1, Codex checks that the project's custom agents and skills load (`/agents`, `/skills`). It also checks that the model names in `.codex/agents/*.toml` exist in your model picker.

---

### Session 1 · P0 setup + P1 record · `gpt-6.1-sol` · medium · 1 Nov
```
Goal: workspace ready for the Round 1 build, and the portal facts recorded.
Run Phase P0 of handoff/CODEX_SUBMISSION_PLAYBOOK.md. Give me the git setup commands to run myself; do not run them.
Verify that the project custom agents (researcher, reviewer) and skills ($deck-qa, $session-handoff) are loaded.
If a model named in .codex/agents/*.toml is not available to me, change it to the cheapest available model and log the change in handoff/DECISIONS.md.
Then write research/portal_rules.md from these P1 facts and list any P1 items still missing:
- Idea submission deadline: <fill>
- File types / max size: <fill>
- Video: upload or link? <fill>
- Form fields: <fill>
- Template provided? <fill>
- Can we edit after submitting? <fill>
- Organiser reply (if any): <fill>
- Team name: <fill>; Members: <fill>; Contact email: <fill>; Video narrator: <fill>; Video host: YouTube Unlisted / Drive
Done when: folders exist, agents/skills verified, portal_rules.md written, $session-handoff entry added. Stop at GATE P0.
```

### Session 2 · P2 research · `gpt-6.1-sol` · medium (subagents run on luna) · 1 Nov
```
Goal: every fact the package needs is sourced in research/, with no unverified claims.
Run Phase P2. First write research/requirements_matrix.md yourself from the brief (pp.8-13; use the PDF plugin or pymupdf).
Then spawn researcher subagents in parallel, one per topic row of the P2.2 table (portal, TBO headcount/turnover, competitors, models, cost inputs, DPDP, Labour Codes, tech refs, licences, name check).
Wait for all of them, merge their summaries into the research/*.md files named in the table, and build research/claims_register.md.
Use the Browser plugin for JS-heavy pages such as Unstop.
Done when: every P2.2 row has a file with URL, access date and a short quote; claims_register.md exists; contradictions with the playbook are listed. Then run $session-handoff and stop at GATE P2.
```

### Session 3 · P3 content core + cost model · `gpt-6.1-sol` · **high** · 2 Nov
```
Goal: a locked message house, agent roster and cost model whose every number traces to research/.
Run Phase P3: research/message_house.md, the P3.2 agent roster, analysis/cost_inputs.json, analysis/cost_model.py and analysis/cost_summary.md.
Run cost_model.py and check the arithmetic by hand for one row.
Then ask me whether to run optional P3B (install Ollama, pull qwen3.5:4b and 9b, 30-case benchmark).
Done when: cost_summary.md shows every intermediate value with its label (M/E/B), plus a sensitivity line. Show me a short numbers table, run $session-handoff, and stop at GATE P3.
```
If you approve P3B, it runs in the **same thread**, because it feeds the same cost model.

### Session 4 · P4 deck v1 · `gpt-6.1-sol` · medium · 3 Nov
```
Goal: a 4-slide deck (cover, 2 content, thank-you) that passes $deck-qa.
Run Phase P4: deck/content.json, deck/build_deck.py, output/submission/RelayHR_Round1_Deck.pptx, following P4.1-P4.3 exactly, with all numbers from analysis/cost_summary.md.
Use the $deck-qa loop after every change. If you get stuck on the same layout bug twice, tell me and suggest switching to high effort.
Done when: $deck-qa passes (DOC_URL/VIDEO_URL placeholders allowed) and you have inspected all four PNGs. Show me the PNGs, run $session-handoff, and stop at GATE P4.
```

### Session 5 · P5 deck QA · `gpt-6.1-sol` · medium · 4 Nov
```
Goal: deck v1 meets every P5 checklist item.
Spawn three reviewer subagents in parallel:
(1) coverage against research/requirements_matrix.md and the four portal topics;
(2) honesty: T/E/M/B labels, claims register, banned words, competitor names;
(3) visual review of the slide PNGs (clipping, overlaps, contrast, colour semantics, the 60-second skim test).
Merge their findings, fix them yourself, and re-run $deck-qa.
Done when: reviews/deck_qa.md has PASS for every item. Run $session-handoff and stop at GATE P5.
```

### Session 6 · Apply Fable review #1 · `gpt-6.1-sol` · medium · 5 Nov
```
Goal: deck v2 with accepted external-review fixes applied.
Read reviews/fable_review_1.md. In reviews/fable_1_actions.md, decide accept or reject for each finding, with a one-line reason (reject anything that breaks AGENTS.md rules or adds unverifiable claims).
Apply the accepted fixes in deck/content.json or deck/build_deck.py and run $deck-qa.
Done when: $deck-qa passes. Show me before/after PNGs and run $session-handoff.
```

### Session 7 · P6 six-page document · `gpt-6.1-sol` · **high** · 6–7 Nov
```
Goal: output/submission/RelayHR_Round1_Architecture.docx and .pdf, 6 pages or fewer, consistent with the deck.
Run Phase P6. Write doc/architecture.md and adapt tmp/documents/build_report.py and tmp/documents/render_word.ps1 into doc/build_doc.py and doc/render_doc.ps1. Build doc/figures.pptx for the diagrams and render it with tools/render_pptx.ps1.
After building, spawn one reviewer subagent to check that the numbers, agent roster and reserved list match the deck word for word.
Done when: the Word render reports 6 pages or fewer, you have inspected every page PNG, and the reviewer reports all PASS. Run $session-handoff and stop at GATE P6.
```
If this thread passes about 60% context (`/status`) before it is done, Codex should hand off. Start a new thread and say:
"continue from the latest SESSION_LOG entry".

### Session 8 · P7 video prep · `gpt-6.1-sol` · medium · 8 Nov
```
Goal: a video script and video deck ready for a human to record.
Doc link: <paste DOC_URL>.
Run Phase P7 steps 1-2: video/script.md (max 690 words, timed to the P7 table) and video/RelayHR_video_deck.pptx built by video/build_video_deck.py, with each slide's script in its speaker notes. Use $deck-qa for the video deck.
Then give me step-by-step PowerPoint recording instructions (Record, then Export to MP4 1080p) tailored to this deck.
Done when: the video deck passes $deck-qa, the script word count is 690 or fewer, and the recording steps are written. Run $session-handoff.
```

### Session 9 · Links in, final rebuild + audit · `gpt-6-luna` · high (switch to sol · medium for any rewrite) · 9–10 Nov
```
Goal: final package passes every P8 checklist item.
Video: <paste VIDEO_URL>. Doc: <paste DOC_URL>.
Put both links into deck/content.json, the thank-you slide and the document, then rebuild everything.
Run the final $deck-qa WITHOUT --allow-placeholder.
Read reviews/fable_review_2.md if present, log accept/reject in reviews/fable_2_actions.md, and apply fixes.
Spawn one reviewer subagent for the cross-file consistency check (numbers, roster, reserved list, links).
Done when: every P8 checklist item is PASS. Report each item, then run $session-handoff.
```

### Session 10 · After submission · `gpt-6-luna` · medium · 11 Nov
```
Goal: Round 2 is ready to start on 26 Nov.
We submitted Round 1. Write handoff/ROUND2_KICKOFF.md as described in P8 step 4, and give me the git commands to commit and push it. Run $session-handoff.
```

---

## Reset prompt (paste into a NEW thread when a session went off the rails or ran out of context)
```
Continue the RelayHR work. Read AGENTS.md and only the latest entry in handoff/SESSION_LOG.md, then the playbook section for that phase. Do not redo finished steps. Start with the "Next step" from the log.
```

## Mid-thread nudges
- Drifting off-phase: "Re-read AGENTS.md and the current phase only. Do only that phase."
- Getting long: "Check /status. If context is over 60%, run $session-handoff and tell me to start a new thread."
- Stuck: "You have tried this twice. Summarise what failed in 3 lines, then try one different approach. If it still fails, stop and ask me."
