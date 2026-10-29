# VoyageHack 4.0: where we stand (29 Oct 2026)

Reviewed by Claude (Opus 5.5) on 29 Oct 2026, the last working days before Claude Code access ends on 31 Oct.
Inputs reviewed: everything in this folder, the five problem-statement PDFs, Codex's selection report
(`tmp/documents/report.md` → `output/documents/…Project_Selection.docx`), Codex's Round 1 plan
(`handoff/codex_round1_plan_original.md`), and the live Unstop listing (fetched 29 Oct).

## 1. What exists today

| Item | State |
|---|---|
| Problem analysis | **Done.** A 32-page DOCX/PDF that explains all six challenges. It picks **AI-Native HR Services Platform (Darwinbox brief)** first and Multi-Supplier Optimization second. The choice is sound and fits the published rubric well. |
| Round 1 plan | **Written, not executed.** "RelayHR": onboarding after offer approval, with leave as the extension workflow. Stack: Temporal, OPA, Postgres, FastAPI, Next.js, Ollama with Qwen3.5 4B/9B. |
| Submission deck | **Not started.** |
| 6-page architecture document | **Not started.** |
| 5-minute video | **Not started.** |
| Code / prototype | **None.** The folder is not a git repo. |
| Starter kit (synthetic HR data, mock APIs, policies) | **Not received.** No release date is published. |
| Machine | RTX 5080 Laptop GPU with 16 GB VRAM (verified). Python 3.12 has python-pptx, python-docx, pymupdf, matplotlib. PowerPoint and Word are installed, so PDF/PNG rendering via COM works (verified). Docker is installed. **Ollama is not installed.** |
| New tools added today | `tools/render_pptx.ps1` exports a PPTX to PDF plus one PNG per slide. `tools/check_pptx.py` is a deterministic deck QA check. Both were tested. |

## 2. Facts that drive the submission

**From the brief** (`problem_statement/Problem Statement/Zendesk-Darwin box Automation.pdf`; HR section on pages 8–13):
- The Round 1 deliverable is an **architecture document of up to 6 pages** and a **5-minute video**. It must cover the chosen service line, the **agent design**, the governance model, the model choice **with an estimated cost per workflow**, and the extension model. Teams are shortlisted on **soundness of design, governance and cost logic** (p.12).
- "Your submission must show **all eight objectives**" (p.9).
- Guardrails are non-negotiable. If an agent can complete any reserved decision on its own, the team is **disqualified from the top scores** (p.9–10).
- Weights: Governance 20, Extensibility 20, Automation 20, Cost 15, Engineering 15, Experience 10 (p.12).

**From the Unstop portal** (fetched 29 Oct 2026):
- Idea round: "a **2-slider PPT** (excluding the cover slide and the 'Thank You' slide)". Submission in "PDF/PPTs". The deck must cover **Potential Impact, Implementation & Technical Feasibility, Innovation, Adoption Risk/Feasibility**, and the team must "record and attach a **video** explaining your idea". One submission per team.
- **Registration deadline: 12 Nov 2026, 11:59 PM IST.** The **idea-submission deadline is not shown** on the public page today. Codex's 26 Oct snapshot said 20 Nov; this must be confirmed in the logged-in dashboard.
- Prototype round: 26 Nov to 24 Dec 2026. Finale: 8 Jan 2027, 10:00–18:00 IST. Prizes: ₹3L, ₹2L and ₹1L, plus PPIs.
- No template, file-size limit or form fields are published, and the page does not mention HR tracks or the starter kit.

**Competitor context** (verified 29 Oct; use in notes only, never as slide claims):
- Darwinbox **Super Agent** (12 Sep 2025): agentic HR teammate with an MCP server, audit trails and approval workflows.
- Darwinbox **Cortex** (4 Aug 2026): "AI-Native HCM platform". It claims "a receipt of every decision".
- Workday **ASOR**: an agent system of record.

Darwinbox wrote this brief, so "agents plus governance plus receipts" will not sound new to the judges. Our edge has to be **specific, testable proof** (see §3), and our framing has to be respectful.

**Model facts** (verified 29 Oct): Qwen3.5-4B and Qwen3.5-9B exist on Hugging Face under **Apache-2.0** (Feb 2026). **Thinking mode is on by default** and is disabled with `enable_thinking: false` (Ollama: `think: false`). Ollama tags `qwen3.5:4b` (about 3.3–4.0 GB) and `qwen3.5:9b` (about 6.6–7.6 GB) both fit the 16 GB GPU.

## 3. Review of Codex's Round 1 plan

### What is strong (keep it)
1. It reads the rubric correctly and puts governance and extensibility (40%) at the centre.
2. It scopes the right thing: **onboarding** for depth, **leave** to prove extension, and hiring and compensation explicitly out.
3. The four "anchor demonstrations" are excellent and testable: verified completion, lost-response recovery with exactly one laptop, governed policy change, and extension with zero engine edits.
4. Its reliability thinking is sound: persist intent before dispatch, reconcile before retrying a write, and send uncertain outcomes to a human.
5. It is honest throughout: targets are labelled as targets, there are no fake screenshots, and DPDP is described precisely.
6. It already sees that the portal format (2 slides) and the brief format (6 pages) conflict, and plans for both.

### Gaps and risks (fixed in the playbook)
| # | Gap | Why it matters | Fix |
|---|---|---|---|
| G1 | **"Agent design" is never stated.** The plan describes an engine, a gateway and capabilities, but no agents. | Round 1 explicitly asks for agent design, and the brief's title is *agent-first*. Without it, judges may read "workflow automation with an LLM bolted on". | Add a named **agent roster**: each agent's job, model or no model, tools, permissions, and what it can never do. Message: "6 agents, 2 use a model". |
| G2 | **The eight objectives are not traced.** | The brief says the submission "must show all eight". | Add an 8-objective strip on slide 1 and a trace table in the document. |
| G3 | **The 2-slide spec is overloaded and has no layout, word budget or visual hierarchy.** Codex's writing style is careful but hedge-heavy. | Reviewers will skim hundreds of decks. | Concrete grid, semantic colours, a word cap of about 220 per slide, action titles, and a 60-second skim test. |
| G4 | **No Thank-You slide.** | It does not count toward the slide limit and is the natural place for the **6-page doc and video links**. The portal may have no field for the doc. | Add a Thank-You slide with links, team and AI disclosure. Put the links on the cover as well. |
| G5 | **The video is under-planned.** The portal *requires* it for the idea round. | A script alone is not a submission. | Build a separate **video deck** (the video is not limited to 2 slides), narrate it with PowerPoint Record, export MP4, upload unlisted. |
| G6 | **The cost logic is fragile.** "₹0.20 per completion" assumes 100 completions in 2 serving hours, but onboarding waits days for humans. There is no monthly projection and no comparison with a frontier model. | "Cost logic" is one of the three shortlisting criteria. | Estimate cost per workflow as (model calls × measured GPU-seconds) + allocated fixed hosting. Project monthly cost from **TBO's own public headcount and attrition** (annual report BRSR). Show the frontier-API cost of the same workflow for contrast. Run a short **local benchmark** if possible. |
| G7 | **The labour-law rule register is thin.** Only DPDP is cited. | The brief lists notice, F&F, PF, gratuity and leave as rules. India's **four Labour Codes** were brought into force in Nov 2025 (verify). | The rule register cites statute, state and effective date, signed off by HR. Codex must verify the current status before citing it. |
| G8 | **Deadline risk.** The internal target is 16 Nov, but the idea deadline is unconfirmed and registration closes 12 Nov. | Missing the deadline ends the run. | Freeze the package on **10 Nov** and submit by **11 Nov**. Use the time after that only to improve. |
| G9 | **Build scope is ambitious** (5 views, policy preview, two inference backends) for a student team in 4 weeks. | The concept must not promise what the build round cannot show. | On slides, commit to the core proofs and mark extras such as llama.cpp and policy preview as "planned (Dec)". |
| G10 | **No user checklist for the portal.** | Codex cannot log in to Unstop. | The playbook's Phase 1 is a user-only checklist plus a ready-to-send organiser question. |

### Not re-opened
The challenge choice (HR), the service line (onboarding plus leave), the tech stack, and the name RelayHR all stay. Codex only does a quick name-collision check. These are reasonable decisions, and changing them now costs time we do not have.

## 4. What happens next
1. **You (now, before 31 Oct):** do Phase 1 of `handoff/CODEX_SUBMISSION_PLAYBOOK.md`: confirm registration, read the deadline in the dashboard, send the organiser question, and collect team names.
2. **Codex (1–10 Nov):** run phases 0 and 2–8 of the playbook, one phase per session, using the kick-off prompts in `handoff/CODEX_PROMPTS.md`.
3. **Fable 5.1 via Cline (optional, about $3–6 of credits):** two independent reviews at fixed gates. Prompts are in `handoff/CLINE_FABLE_PROMPTS.md`.
4. **Team (11 Nov):** submit. Keep the confirmation screenshot.
