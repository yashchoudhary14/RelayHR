# Prompts for Fable 5.1 via Cline (independent reviews)

**Why use Fable here:** Codex builds the package, so a second, stronger model reviewing it as a judge panel catches
blind spots that Codex's self-review misses. Spend credits only at these two gates. The handoff itself did not need Fable.

**How to run**
1. Open `C:\dev\Voyage Hackathon` in VS Code, open Cline, and pick **Fable 5.1** as the model. Use **Act** mode, and approve only the commands and the one file write it asks for.
2. **Attach images:** drag the rendered slide PNGs into the Cline chat together with the prompt, because not every Cline setup can read images from disk.
   - Deck: `output/submission/render_RelayHR_Round1_Deck/slide-1.png` … `slide-4.png`
   - Document (review #2): the document page PNGs
3. Watch the cost counter in Cline. Each review should cost a few dollars at most. If one passes about $5, stop it and paste whatever it has written so far.
4. Hand the output file to Codex using session 6 or session 9 in `handoff/CODEX_PROMPTS.md`.

---

## Prompt 1: judge-panel review of deck v1 (after Codex GATE P5, about 5 Nov)

```
You are reviewing a hackathon submission. Do NOT edit any file except the one output file named below. Do NOT browse the web.

CONTEXT
We are entering TBO VoyageHack 4.0, problem statement "AI-Native HR Services Platform (Darwinbox)". Round 1 is a concept round.
Portal requirement: a 2-content-slide deck (cover and thank-you excluded) covering Potential Impact, Implementation & Technical Feasibility, Innovation, Adoption Risk/Feasibility, plus a video.
Brief requirement (pp.8-13): concept must cover service line, agent design, governance model, model choice with estimated cost per workflow, extension model; teams are shortlisted on "soundness of design, governance and cost logic". Rubric weights: Governance 20, Extensibility 20, Automation 20, Cost 15, Engineering 15, Experience 10. Any design letting an agent complete a reserved decision alone is disqualified from top scores.

READ (in this order)
1. AGENTS.md (our honesty and labelling rules; your suggestions must obey them)
2. Brief text: run  python -P -E -c "import pymupdf;d=pymupdf.open(r'problem_statement/Problem Statement/Zendesk-Darwin box Automation.pdf');print(''.join(d[i].get_text() for i in range(7,13)))"
3. research/portal_rules.md, research/requirements_matrix.md, research/claims_register.md, analysis/cost_summary.md
4. deck/content.json (exact slide text) and the attached slide PNGs (what judges actually see)

TASK
Act as a panel of three judges reading this deck for 90 seconds each:
(a) TBO HR operations head, (b) Darwinbox product & engineering lead, (c) TBO platform architect.
Write reviews/fable_review_1.md with these sections:
1. Verdict in 3 lines: would this be shortlisted? Why or why not?
2. Scores 1-10, each with a one-line justification:
   - shortlisting criteria: design soundness, governance, cost logic
   - each portal topic
   - each of the six weighted rubric criteria
3. Disqualification check: is any reserved decision ambiguous or automatable as drawn? Quote the exact element.
4. 60-second skim test: from the titles and largest elements only, can a stranger say what is built, where humans decide, why it is cheap, how it extends, and whether it is feasible by January? Answer each.
5. Top 10 fixes, highest impact first. For each:
   - location (slide/zone)
   - problem
   - EXACT replacement copy that fits the same space (respect about 240 words per slide, minimum 10pt)
   - which rubric line it improves
6. Overclaims or unsupported statements: anything not backed by claims_register.md or cost_summary.md, or missing a T/E/M/B label.
7. Cost logic stress test: recompute the per-workflow and monthly figures from cost_summary.md. Flag arithmetic errors, missing cost components (hosting, GPU, retries, failed runs), and unrealistic assumptions.
8. Five hard questions the Darwinbox judge would ask, each with a 2-sentence answer we should be ready to give.
9. Visual design notes (max 8 bullets): hierarchy, density, alignment, colour semantics, legibility.

CONSTRAINTS
- Never suggest inventing numbers, testimonials, screenshots or competitor comparisons on slides.
- Never suggest claiming "first/only/unique/compliant/certified".
- Prefer cutting words over adding them.
- Be specific and blunt. No generic advice.
```

---

## Prompt 2: final pre-submission audit (after Codex session 9, about 10 Nov)

```
You are the final auditor before a hackathon submission. Do NOT edit any file except reviews/fable_review_2.md. Do NOT browse the web.

READ
- AGENTS.md
- research/portal_rules.md, research/requirements_matrix.md, research/claims_register.md, analysis/cost_summary.md
- deck/content.json and output/submission/RelayHR_Round1_Deck.pdf (extract text with pymupdf)
- output/submission/RelayHR_Round1_Architecture.pdf (extract text with pymupdf; also report its page count)
- video/script.md
- reviews/deck_qa.md and reviews/fable_1_actions.md
- the attached PNGs of the deck slides and document pages

Write reviews/fable_review_2.md containing:
1. A PASS/FAIL table for each check:
   - deck has 4 slides (cover + 2 + thank-you)
   - document has 6 pages or fewer
   - video script has 690 words or fewer and timings total 5:00 or less
   - every portal topic is visibly covered
   - every Round-1 brief item is covered (service line, agent design, governance, model choice + cost per workflow, extension model)
   - all 8 objectives appear
   - all six reserved-decision groups appear and are identical across deck and document
   - the agent roster is identical across deck, document and script
   - every number is identical across deck, document, script and cost_summary.md (list each number and where it appears)
   - every number carries a T/E/M/B label
   - no banned words (first, only, unique, guaranteed, 100%, compliant, certified, zero cost, replaces Darwinbox)
   - no placeholders, TODO or {BRACES} left
   - doc and video links are present on the cover and thank-you slides
   - AI-assistance disclosure is present
   - competitor names do not appear on slides
2. For each FAIL: the exact location and the exact fix (replacement text).
3. A list of any claim not traceable to claims_register.md.
4. Top 3 remaining risks to shortlisting, and whether each is worth fixing in the time left (one line each).

Be exhaustive on consistency, and brief everywhere else.
```

---

## Optional later prompt: finale Q&A drill (December, not needed for Round 1)
Use Fable to grill the team on the state model, approval boundary, retry and reconcile behaviour, and cost figures before
the 8 Jan finale. The brief warns that finalists are questioned individually about the parts they built.
