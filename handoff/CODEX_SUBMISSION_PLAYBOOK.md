# RelayHR: Round 1 submission playbook (for Codex)

Written 29 Oct 2026 by Claude (Opus 5.5) after reviewing the repo, the brief, Codex's earlier plan and the live portal.
Audience: **Codex**, run phase by phase by the user. Teammates can read it too.
Read `handoff/STATUS_REVIEW.md` first. It explains where we stand and why this playbook changes parts of
`handoff/codex_round1_plan_original.md`. **Where they disagree, this playbook wins.**

---

## How to use this playbook

- **One phase = one new Codex thread, and Codex opens it itself.** Each phase ends with `$session-handoff` and the git commands for the user. If the next step needs the user, Codex stops and waits. Otherwise it opens the next thread on its own (see `AGENTS.md`).
- At the start of each thread, read `AGENTS.md`, the **latest** `handoff/SESSION_LOG.md` entry, and **only this phase's section** of the playbook. Do not re-read the whole repo; open earlier outputs only when the phase needs them.
- Follow the "Working efficiently" rules in `AGENTS.md`:
  - start a new thread at about 60% context or when the work changes type
  - use the cheapest model that does the job (see the calendar's model column)
  - send read-heavy work to the `researcher` and `reviewer` subagents
  - verify decks with `$deck-qa`
- Never skip the QA steps. Rendering and inspecting every slide or page is mandatory.
- The user cannot run Claude after 31 Oct. If something here is ambiguous, pick the option that is
  **more honest and more conservative**, write the decision in `handoff/DECISIONS.md`, and continue.

### Calendar (today is 29 Oct 2026; the registration deadline is 12 Nov, 11:59 PM IST)

| Date | Phase | Owner | Codex model · effort (new thread each row) |
|---|---|---|---|
| 29–31 Oct | **P1** Portal and team facts | **User** (Codex cannot log in) | — |
| 1 Nov | **P0** Workspace setup | Codex | sol · medium |
| 1 Nov | **P2** Research | Codex | sol · medium; `researcher` subagents on luna, in parallel |
| 2 Nov | **P3** Content core and cost model (+ optional **P3B** local benchmark) | Codex (user approves the Ollama install) | sol · **high** |
| 3 Nov | **P4** Build deck v1 | Codex | sol · medium (high if stuck) |
| 4 Nov | **P5** Deck QA | Codex | sol · medium; 3 `reviewer` subagents on luna |
| 5 Nov | **Fable review #1** → deck v2 | User runs Cline; Codex applies fixes | sol · medium |
| 6–7 Nov | **P6** 6-page architecture document | Codex | sol · **high**; `reviewer` subagent for the consistency check |
| 8–9 Nov | **P7** Video deck, script, recording, upload | Codex prepares; a **team member records** | sol · medium |
| 10 Nov | **Fable review #2** (final audit) → freeze | User runs Cline; Codex applies fixes | luna · high for mechanical fixes; sol for rewrites |
| 11 Nov | **P8** Submit, a full day before the registration deadline | User | luna · medium (Round 2 kickoff note) |

Model names: `gpt-6.1-sol` (default), `gpt-6-luna` (cheapest), `gpt-6.1-terra` (fast), and `gpt-6-astra` (most capable, used only after two failed attempts). Use whatever the model picker actually shows.

If P1 shows the idea deadline is later (for example 20 Nov), **keep the 10 Nov freeze anyway**. Use the extra days
only for optional improvements, such as adding a real 20-second prototype clip to the video.

### Folder layout (create in P0)

```
AGENTS.md                standing rules for Codex, incl. session/model/subagent rules (already written)
.codex/agents/           project subagents: researcher.toml, reviewer.toml (already written)
.agents/skills/          project skills: deck-qa, session-handoff (already written)
handoff/                 this playbook, status review, prompts, DECISIONS.md, SESSION_LOG.md
problem_statement/       organiser PDFs (authority for requirements)
research/                P2 outputs: requirements matrix, claims register, sources, notes
analysis/                P3 cost model (+ bench/ for P3B)
deck/                    build_deck.py, content.json, render outputs
doc/                     architecture.md, build_doc.py, figures
video/                   video_deck build script, script.md, storyboard
reviews/                 Fable and team reviews
output/submission/       final files only
tools/                   render_pptx.ps1, check_pptx.py (tested 29 Oct)
tmp/                     earlier selection-report work (leave as is)
```

---

## Non-negotiable content rules (apply to every deliverable)

1. **Requirement authority.** The HR brief is `problem_statement/Problem Statement/Zendesk-Darwin box Automation.pdf`, physical pages 8–13. Page 1–8 is a *different* challenge (OpsDesk). Do not mix them.
2. **Label every number** with one of these:
   - **T**: target we will measure in Round 2
   - **E**: estimate from stated assumptions
   - **M**: measured by us; give n, date and machine
   - **B**: stated in the brief
   No unlabeled numbers on slides.
3. **Banned claims:** "first", "only", "unique", "guaranteed", "100%", "DPDP-compliant" or "certified", "zero cost", "replaces Darwinbox", any savings figure without a visible formula, fake logos, testimonials, or UI screenshots presented as real. A clearly captioned **"concept mock-up"** is allowed in the video only.
4. **Respectful positioning.** Darwinbox wrote this brief and already ships agentic HR products (Super Agent, Sep 2025; Cortex, Aug 2026). Never disparage them or claim novelty for "agents + governance + receipts". Our edge is **specific, testable proof**: verified completion, exactly-once effects, governed change, and extension with zero engine edits. Keep competitor names out of the slides; mention them only in speaker notes or `research/`.
5. **Language.** Plain, confident, concrete. Use present tense for the design ("The policy guard blocks…") and future tense for build plans. Avoid hedge-stacking, and put caveats on numbers rather than on every sentence. Use Indian number formatting with the ₹ sign (₹1,20,000).
6. **Synthetic data only.** Every person, employee ID and example is fictional.
7. **One source of truth for numbers:** `analysis/cost_summary.md` (P3). The deck, document and video take numbers from it. They are never retyped from memory.

---

## P0 — Workspace setup (Codex, about 20 minutes)

1. Create the folder layout above. `handoff/DECISIONS.md` already exists, seeded with the decisions made so far; append to it.
2. **Git: the user commits, never Codex** (see "Git and authorship" in `AGENTS.md`). Write the `.gitignore` file, covering `tmp/`, `**/render_*/`, `*.mp4`, `*.mov`, `analysis/bench/*.csv`, `__pycache__/`, `.venv/`.
   Then give the user a ready-to-run block:
   - `git init`
   - `git config user.name "<Name>"` and `git config user.email "<GitHub email>"`
   - `git branch -M main`
   - `git add` with explicit paths
   - the first `git commit -m "..."`
   - how to create the GitHub repo (private for now) and push it: `git remote add origin <url>`, then `git push -u origin main`
   From then on, every GATE ends with a commit command block, and says which teammate should run it.
3. Verify that the project's Codex extensions load:
   - custom agents `researcher` and `reviewer` from `.codex/agents/` (check with `/agents`)
   - skills `$deck-qa` and `$session-handoff` from `.agents/skills/` (check with `/skills`)
   If the project needs to be marked trusted, or git initialised, for these to load, tell the user.
   If a model named in an agent file is not in the user's model picker, switch it to the cheapest available one and log the change.
4. Verify the tools:
   - `python tools/check_pptx.py --help`
   - Render any small PPTX with `powershell -ExecutionPolicy Bypass -File tools/render_pptx.ps1 -Pptx <file>`
5. Use `python -P -E` (or a venv) when a script reads files from `problem_statement/`.

**GATE P0:** report the created folders, the git decision, and whether the agents and skills loaded.

---

## P1 — Portal and team facts (USER does this; Codex records the answers)

The user does these in the logged-in Unstop dashboard (https://unstop.com/competitions/voyagehack-40-tbocom-1774031):

- [ ] Team is **registered** before **12 Nov 2026, 11:59 PM IST**, with all members added (2–5).
- [ ] Open the **Idea Submission** round and record:
  - deadline (date and time)
  - accepted file types
  - **max file size**
  - whether the **video is uploaded or linked**
  - every form field (is there a field for a document link? GitHub?)
  - whether a **template** is provided (download it if so)
  - whether a submission **can be edited** after it is sent
- [ ] Check announcements, FAQ and email for an **HR starter-kit** release date.
- [ ] Send this question through "Send queries to organisers":

  > Hello, we are submitting for the AI-Native HR Services Platform (Darwinbox) problem statement. The brief asks Round 1 teams for an architecture document of up to 6 pages plus a 5-minute video. The Idea Submission round on Unstop asks for a 2-slide PPT (excluding cover and thank-you) plus a video. Should HR teams submit (a) the 2-slide PPT and video, (b) the 6-page document and video, or (c) both? If both, where should we upload or link the document? Could you also confirm the idea-submission deadline, maximum file size, whether the video should be uploaded or linked, and when the HR starter kit (synthetic dataset, mock APIs, sample policies) will be released? Thank you.

- [ ] Collect these from the team:
  - team name
  - member full names (and institutions, if relevant)
  - one contact email
  - who will **narrate the video** (a calm voice and a quiet room)
- [ ] Decide on video hosting: **YouTube (Unlisted)** or **Google Drive (anyone with the link can view)**.

Codex then writes `research/portal_rules.md` with these answers, the date checked, and screenshots if the user provides them.

**Default if the organisers have not answered by 9 Nov:** submit **(c) both**. Upload the 2-slide deck as the file. Put
the 6-page document link and the video link on the deck's cover and thank-you slides **and** in any free-text or link
field. Log this in `DECISIONS.md`.

---

## P2 — Research (Codex, about 1 day)

Goal: every factual statement in the package traces to a source. Use web search. Save the **URL, access date and a short
supporting quote (under 25 words)** for each fact. Do not paste long copyrighted passages.

### P2.1 Requirements matrix (`research/requirements_matrix.md`)
Extract from brief pp.8–13 and the portal. Use one row per requirement, with columns: **ID · Requirement (short) · Source (page) · Where we address it (deck slide / doc page / video time) · Status**.
It must include at least:
- **Round 1 brief (p.12):**
  - R1 doc of 6 pages or fewer
  - R2 5-minute video
  - R3 chosen service line
  - R4 **agent design**
  - R5 governance model
  - R6 model choice plus estimated cost per workflow
  - R7 extension model
  - R8 shortlisting criteria: design soundness, governance, cost logic
- **Objectives O1–O8 (p.9):**
  - O1 end-to-end automation, with the share of steps that need no human touch
  - O2 platform: workflow definitions, agent/skill registry, API-first integrations
  - O3 reserved decisions as HR-editable config
  - O4 versioned, testable, auditable policy layer
  - O5 system of record from hire to exit, with RBAC and audit trail
  - O6 fail safely, with no duplicates
  - O7 conversational interface
  - O8 dashboard: cost per workflow, automation rate, cycle time, escalation rate
- **Guardrails (pp.9–10):**
  - six reserved decision groups, and HR can add more
  - POSH/grievance/whistleblower: route only
  - DPDP: purpose limitation, consent, retention, access/correction
  - PII: what reaches a model and where it is hosted; mask before any external call
  - fair hiring: no automated rejection, and ranking is explained
  - explainability: inputs, rule/prompt version, model, rationale
  - RBAC: an agent never has more rights than its person
  - kill switch without a code change
  - labour law as rules: notice, F&F timelines, PF, gratuity, leave
- **Cost rule (p.11):**
  - measure, don't estimate (Round 2)
  - rules in code
  - routing with a justified threshold
  - provider swap is a config change
  - count hosting, GPU and inference
  - monthly projection at TBO volumes
- **What TBO provides and the rules (pp.11–13):**
  - demo must run on the provided interfaces
  - synthetic data only
  - commercial-use licences listed
  - AI assistants disclosed
  - clean commit history
- **Portal:**
  - 2 content slides (plus cover and thank-you)
  - Potential Impact
  - Implementation and Technical Feasibility
  - Innovation
  - Adoption Risk/Feasibility
  - video
  - one submission per team

### P2.2 Sources to research (`research/sources.md` plus topic notes)

| Topic | Where to look | What to extract | Output |
|---|---|---|---|
| Portal rules | Unstop page above; `api.unstop.com/competitions/voyagehack-40-tbocom-1774031` returns readable text; user's P1 notes | Exact wording of round requirements | `portal_rules.md` |
| **TBO headcount and churn** (for the monthly projection) | TBO Tek investor relations https://www.tbo.com/investors → latest **Annual Report (FY2025-26)** → **BRSR, Section A**: "Employees and workers" (total permanent employees) and "**Turnover rate** for permanent employees". Cross-check NSE/BSE filings (symbol TBOTEK) and the LinkedIn company page (secondary only). | Headcount, turnover %, year, page number | `tbo_volumes.md` |
| Competitor context (notes only) | Darwinbox Super Agent https://darwinbox.com/blog/darwinbox-launches-super-agent ; Darwinbox Cortex https://newsroom.darwinbox.com/darwinbox-launches-cortex-ai-native-hcm-platform ; Workday ASOR https://community-content.workday.com/en-us/public/learn/resources/workday-ai-agents/agent-system-of-record-asor.html | What they already claim, so we don't claim it as new | `competitors.md` |
| Models | https://huggingface.co/Qwen/Qwen3.5-4B , https://huggingface.co/Qwen/Qwen3.5-9B (licence, thinking default and how to disable it), https://ollama.com/library/qwen3.5 (tags and sizes), Ollama docs for **structured outputs** (`format` with a JSON schema) and the **thinking** toggle (`think: false`) at https://docs.ollama.com , llama.cpp https://github.com/ggml-org/llama.cpp (licence) | Licence, sizes, how to force JSON and disable thinking | `models.md` |
| Cost inputs | (a) The team's actual laptop price, or the MSRP of an RTX 5080 laptop. (b) The **commercial electricity tariff** of the team's state DISCOM (cite the tariff order). (c) Production hosting: AWS EC2 on-demand pricing for a small GPU instance (for example g6.xlarge, L4) in **ap-south-1 (Mumbai)** https://aws.amazon.com/ec2/pricing/on-demand/ , and an Indian GPU cloud such as https://www.e2enetworks.com/pricing . (d) Hosted open-weight API price for Qwen3.5-4B/9B-class models (for example https://openrouter.ai/qwen or provider pages). (e) Frontier comparison: https://openai.com/api/pricing and https://www.anthropic.com/pricing (a current flagship model). (f) USD→INR reference rate (RBI/FBIL) with its date. | Every number with source and date | `cost_inputs_sources.md` |
| Data protection | DPDP Act 2023; DPDP Rules 2025 (MeitY PDF https://www.meity.gov.in/static/uploads/2025/11/53450e6e5dc0bfa85ebd78686cadad39.pdf ). **Verify the phased commencement dates**, i.e. which obligations apply when. | Obligations relevant to HR data, with commencement dates | `legal_rules.md` |
| Labour law | **Verify** on https://labour.gov.in and PIB whether the **four Labour Codes** (Code on Wages 2019, Industrial Relations Code 2020, Code on Social Security 2020, OSH Code 2020) are in force (reportedly from 21 Nov 2025) and what is still governed by state rules or Shops & Establishments Acts (leave). Gratuity and PF sit under the Social Security Code. | Statute, effective date, what our rule register must carry. **Do not state legal values on slides**; the register uses TBO's sample policies. | `legal_rules.md` |
| Reliability patterns | Temporal docs: durable execution and activity idempotency; `temporal server start-dev --db-filename` for persistence. Transactional outbox: https://microservices.io/patterns/data/transactional-outbox.html | One-line justifications | `tech_refs.md` |
| Policy engine | OPA policy testing https://www.openpolicyagent.org/docs/policy-testing ; decision-log masking https://www.openpolicyagent.org/docs/management-decision-logs | One-line justifications | `tech_refs.md` |
| Licences | Confirm the licence of every component: Temporal, OPA, PostgreSQL, FastAPI, Pydantic, SQLAlchemy, Next.js, React, Ollama, llama.cpp, Qwen3.5, Playwright, pytest | Table: component · licence · commercial use OK | `licences.md` |
| Name check | Web search "RelayHR" and "Relay HR" | If an HR product already uses that name, list 3 alternatives for the user and **ask** | `DECISIONS.md` |

### P2.3 Claims register (`research/claims_register.md`)
Use one row per claim that will appear anywhere, with columns: **ID · Claim as worded · Type (B/E/T/M/design) · Source · Accessed · Used in**.
Every later phase may only use claims that are in this register.

**GATE P2:** report the headcount and turnover found (or "not found"), any facts that contradict this playbook (especially
Labour Codes or DPDP dates), the name-check result, and open questions.

---

## P3 — Content core and cost model (Codex, about half a day)

### P3.1 Message house (`research/message_house.md`, one page)
- **One-liner:** "RelayHR is an agent-first HR services platform: agents finish routine cross-team work, named humans make the decisions that matter, and every action is checked, recorded and costed."
- **Three pillars**, each mapped to the rubric:
  1. Closes the loop (Automation 20)
  2. Safe by construction (Governance 20 + Engineering 15)
  3. Built to extend, cheap to run (Extensibility 20 + Cost 15)
- **Four proofs** we will demonstrate:
  - verified completion
  - exactly-once effects (lost-response recovery)
  - governed change (approvals bound to exact parameters; policy-change preview)
  - extension with zero engine edits (Leave)

### P3.2 Agent design (the brief requires this; the original plan lacked it)
Use this roster everywhere: deck slide 1, document page 2, and the video.

| Agent role | Model? | Does | Tools / rights | Never |
|---|---|---|---|---|
| **Concierge** (intake) | Qwen3.5-4B | Turns chat into a typed request, resolves the employee, asks clarifying questions, shows a confirmation | directory lookup (read, scoped); request proposal | Submits without the user's confirmation; sees salary, bank or ID data |
| **Orchestrator** | No (durable workflow code) | Loads the versioned workflow, runs independent steps in parallel, sets timers, waits for humans | workflow engine | Skips the policy gate |
| **Fulfilment agents**: IT, Admin, Finance-prep | No (adapter code) | Call the TBO mock APIs, then verify and reconcile the outcome | Each has its own scoped service identity | Exceeds the requester's rights; retries a write blindly |
| **Policy guard** | No (OPA rules) | Returns allow / deny / needs approval / needs human for **every** action | Policy bundle (versioned) | Delegates a decision to a model |
| **Recovery agent** | 4B, escalating to 9B | Diagnoses a failure from receipts, picks a fix **from an allowed list**, writes the exception brief for a human | Read receipts; propose a recovery | Invents actions; approves anything |
| **Reporter** | No (templates) | Status messages, receipts, metrics | Read-only projection | Edits the audit trail |

Headline: **"6 agent roles; only 2 use a model: models where language is, code where rules are."**

### P3.3 Cost model (`analysis/cost_inputs.json`, `analysis/cost_model.py` → `analysis/cost_summary.md`)
Write a small, readable Python script. Every input has `value`, `unit`, `type` (M/E/B/assumption) and `source`.

**Per onboarding workflow, model usage (design estimate, type E):**
- Concierge: about 2 calls (the request plus an average of one clarification). Each is about 1,200 prompt tokens and 250 output tokens.
- Recovery agent: runs in about 20% of workflows. Each run is 1 call of about 2,000 prompt tokens and 300 output tokens.
- 9B fallback: about 10% of model calls.
- Everything else is code or templates.
- Tune these numbers after P3B if it runs.

**Compute:**
1. GPU-seconds per call = prefill tokens ÷ prefill tok/s + output tokens ÷ decode tok/s. Use **M** values from P3B, otherwise conservative **E** values, and state them.
2. Energy ₹ per workflow = Σ GPU-seconds × device watts ÷ 3,600,000 × ₹/kWh.
3. Hardware allocation ₹ = laptop price ÷ (36 months × assumed active hours per month × 3,600) × GPU-seconds.
4. **Production monthly projection, at least two scenarios:**
   - **A:** a small dedicated or shared GPU VM in Mumbai, plus an app/DB VM.
   - **B:** a hosted open-weight API (with PII minimisation; it is an external call), plus an app/DB VM.
   - Volumes:
     - onboarding per month = headcount × (turnover % + growth %) ÷ 12, using BRSR figures and labelled assumptions
     - leave requests per month = headcount × an assumed requests per employee per month
     - state that TBO will supply official volumes later (brief p.11)
5. Cost per workflow in production = fixed monthly hosting ÷ total monthly workflows + variable cost.
6. **Frontier contrast:** the same token counts priced on a current frontier API. Show "≈ N× more per workflow".
7. Output: a table in `cost_summary.md` with every intermediate value. Include a **sensitivity line** ("if calls double, cost becomes …").
   Round to 2 significant figures and label E (or M).

**Cost wording rule:** the deck shows **one** headline per-workflow estimate, **one** monthly projection, and **one** frontier
contrast, each labelled E with its key assumptions in a footnote. Everything else goes to document page 4.

### P3B — Optional but recommended: 30-case local benchmark (about 2–3 hours)
This turns the cost estimate into a partly **measured** figure, which is strong for "cost logic".

1. **Ask the user** for approval to install Ollama (`winget install --id Ollama.Ollama -e`) and to pull `qwen3.5:4b` and `qwen3.5:9b` (about 4 GB and 7 GB).
   If declined, skip P3B and keep E values.
2. Write `analysis/bench/cases.jsonl`: 30 **fictional** chat requests (onboarding and leave), each with gold fields. Make 10 of them hard: ambiguous names, relative dates ("next Monday"), missing manager.
3. Write `analysis/bench/run_bench.py`. It calls `http://localhost:11434/api/chat` with:
   - `format` set to a JSON schema
   - `think: false`
   - `options: {temperature: 0, num_ctx: 4096, num_predict: 256}`
   Do one warm-up call and exclude it. Record Ollama's returned `prompt_eval_count`, `prompt_eval_duration`, `eval_count`, `eval_duration` and `total_duration`.
   Log GPU power in parallel with `nvidia-smi --query-gpu=power.draw,memory.used --format=csv,noheader,nounits -lms 250`.
4. Report in `analysis/bench/results.md`, separately for 4B and 9B:
   - field-level accuracy
   - median and p95 latency
   - tokens per second
   - average watts
   - peak VRAM
5. Label every result **"M (pilot, n=30 synthetic, RTX 5080 Laptop, date)"**. It is not the held-out evaluation; that happens in Round 2.
6. Feed the measured throughput and watts into `cost_model.py`.

**GATE P3:** show the user the message house, the agent roster, and `cost_summary.md` (and bench results).
The user approves the numbers before any slide is built.

---

## P4 — Build the deck (Codex, about 1 day)

### P4.1 Format
- 16:9, 13.333 × 7.5 in. **4 slides:** Cover · Content 1 · Content 2 · Thank You. The portal excludes the cover and thank-you from the 2-slide limit.
- Build with **python-pptx** from `deck/content.json` using `deck/build_deck.py`, so copy edits do not touch layout code.
  Output `output/submission/RelayHR_Round1_Deck.pptx`.
- **Everything editable:** native text boxes, shapes, connectors and tables. No text inside images. No screenshots.
- Speaker notes on every slide: sources (claims-register IDs) and assumption details.

### P4.2 Design system
- **Font:** Calibri throughout. Use bold for titles. Avoid emoji and rare glyphs; draw checks and diamonds as shapes.
- **Sizes:**
  - kicker 11 pt caps, letter-spaced
  - action title 24–26 pt bold
  - section headers 12 pt bold caps
  - body 11–12 pt; **minimum 10 pt**
  - footnote/sources 8 pt, only in shapes named `footnote_*` or `source_*`
- **Semantic colours** (use them consistently and show a tiny legend on both content slides):
  - Navy `#0B1F3A`: platform core, titles
  - Teal `#0E9F8E`: agents automate
  - Amber `#E8A317`: **named human decides** (always amber, always a diamond marker)
  - Coral `#D9534F`: failure and recovery
  - Slate `#334155` body text; muted `#64748B`; panel fill `#F1F5F9`; white background
- **Grid:** 0.45 in outer margins, 0.2 in gutters, everything aligned. Cards use small-radius rounded rectangles without heavy borders.
  Arrows point one way (left→right or top→bottom).
- **Word budget:** about 240 words per content slide (hard cap 270), cover 50 or fewer, thank-you 70 or fewer. Each content slide gets an
  **action title**: a full sentence of 14 words or fewer that states the takeaway.
- **python-pptx tips:**
  - Set the font, size and colour on **every run**.
  - Set `word_wrap=True` and `auto_size=MSO_AUTO_SIZE.NONE`.
  - Use `shapes.add_table` for tables and style the cells manually.
  - Add arrowheads to connectors via XML:

```python
from pptx.oxml.ns import qn
from lxml import etree
def arrowhead(connector):
    ln = connector.line._get_or_add_ln()
    tail = etree.SubElement(ln, qn('a:tailEnd'))
    tail.set('type', 'triangle'); tail.set('w', 'med'); tail.set('len', 'med')
```

### P4.3 Slide specifications (draft copy)
Draft copy is below. Tighten it if needed, but keep the meaning. Numbers in `{BRACES}` come from `analysis/cost_summary.md`
or P1. `check_pptx.py` fails the build if any `{PLACEHOLDER}` remains.

#### Cover
- Kicker: `TBO VOYAGEHACK 4.0 · ROUND 1 · CONCEPT & ARCHITECTURE`
- Title: **RelayHR**. Subtitle: *An agent-first HR services platform for TBO*
- Tagline: "Agents finish the routine work. Named humans make the decisions. Every action is checked, recorded and costed."
- Track line: "Problem statement: AI-Native HR Services Platform (Darwinbox)"
- Team: `{TEAM_NAME}`, then `{MEMBERS}`
- Links (11 pt): "Architecture document (6 pages): `{DOC_URL}` · Video walkthrough (5 min): `{VIDEO_URL}`"
- Visual: a "relay" line of 5 small teal nodes (HR → IT → Admin → Finance → Manager) with one amber diamond, ending in a check. Native shapes only.

#### Content slide 1: Solution · Innovation · Potential impact
- Kicker: `1 · SOLUTION · INNOVATION · POTENTIAL IMPACT`
- Action title: **"Agents close every onboarding loop; named humans keep the decisions that matter."**
- Problem line (under the title): "Today the HRMS records the hire, then HR emails IT, Admin and Finance, and chases each one (TBO brief)."
- **Zone A, hero, full width, about 2.3 in tall: "ONBOARDING, END TO END".** A flow of native shapes, with a "done =" caption under each node:
  1. ◆ **Offer approved** (amber): human decision, upstream
  2. **Intake & checks** (teal, Concierge): employee resolved, fields valid
  3. Fan-out into three parallel teal nodes:
     - **IT: laptop + accounts**: asset ID, accounts active
     - **Admin: access card**: card issued
     - **Finance: payroll setup**: setup receipt; the payroll run stays human
  4. ◆ **Manager ready** (amber): confirmed by the named manager
  5. ✓ **Verified complete** (navy): every mandatory receipt present
  - Coral callout on the IT node: "Response lost → reconcile by operation ID → exactly one laptop"
- **Zone B, bottom left: "AGENT DESIGN · 6 roles, only 2 use a model".** A compact 3-column table built from the P3.2 roster: *Agent · Does · Never*, with short cells of 6 words or fewer.
- **Zone C, bottom middle: "WHAT'S DIFFERENT: each is a live test in Round 2"**
  1. **Verified completion**: closes only on confirmed outcomes, not accepted tickets.
  2. **Exactly-once effects**: lost responses are reconciled, never blindly retried.
  3. **Governed change**: approvals bind to exact parameters; policy changes are previewed on past cases.
  4. **Extension without engine edits**: Leave is added through the registry.
- **Zone D, bottom right: "POTENTIAL IMPACT".** Three stat tiles:
  - "**≥80%** onboarding steps with no human touch (T)"
  - "**0** duplicate actions in injected-failure tests (T)"
  - "**0** manual chase emails per hire (T)"
  - Optional 4th tile, **only if** P2 found the TBO headcount: "**~{HIRES_PER_MONTH}** hires a month at TBO run through RelayHR (E)"
- **Bottom strip**, 8 small chips: "Covers all 8 brief objectives: End-to-end · Platform · Human decisions · Compliance by design · System of record · Safe failure · Conversational · Cost dashboard"
- Legend: teal square = agent automates · amber diamond = named human decides · coral = failure handled

#### Content slide 2: Implementation & feasibility · Adoption risk
- Kicker: `2 · IMPLEMENTATION & TECHNICAL FEASIBILITY · ADOPTION RISK`
- Action title: **"One governed gateway makes every agent action safe, cheap and extensible."**
- **Zone A, left 55%, hero: architecture diagram** (native shapes and connectors, top to bottom):
  1. Channels: Web chat (Teams/Slack-ready) · Manager inbox · HR console + kill switch · Impact & cost dashboard
  2. API: auth, role-based access, idempotency keys
  3. Durable workflow engine (Temporal) ⇄ Registry: workflows · agent skills · integrations (versioned)
  4. **Navy band: GOVERNED ACTION GATEWAY**, containing the chips Policy guard (OPA) · PII minimiser · Approval binding · Receipt + cost log
  5. Two blocks side by side:
     - **Model router**: rules → Qwen3.5-4B → 9B → human (local)
     - **Adapters → TBO mock APIs**: assets · accounts/directory · access cards · payroll setup · ticketing (grey = external)
  6. Bottom: **System of record (PostgreSQL)**: lifecycle hire→exit · approvals · policy versions · audit; and **Human queues**: approvals · exceptions · restricted (POSH/grievance)
- **Zone B, right column, three stacked cards:**
  1. **GOVERNANCE BY DESIGN**
     - Amber chips for the reserved list: Hiring/offer/pay · Resignation terms · Termination/PIP · Grade/role changes & exceptions · Statutory & payroll sign-off · POSH/grievance (route only). Caption: "HR-editable, versioned config".
     - Bullets: "Agents act with the requester's rights, never more; no self-approval." · "Model sees a pseudonymous ID and needed fields only; bank, ID and salary never enter prompts; inference runs on-premise."
  2. **MODEL CHOICE & COST**
     - A 4-step ladder graphic: Code (rules, dates, balances) → 4B (intake, summaries) → 9B (only when the schema check fails) → Human.
     - Big number: "**≈ ₹{CPW_EST}** per onboarding workflow (E)", with the caption "{CALLS} model calls; local GPU + allocated hosting".
     - Line: "≈ ₹{MONTHLY_EST}/month at TBO scale (E) · a frontier API would cost ≈ {FRONTIER_MULT}× more per workflow (E)"
  3. **EXTENSION MODEL**: "Leave = new workflow definition + leave-balance skill + policy & tests; **0 engine edits**. The registry validates schemas, dependencies and policies before activation."
- **Zone C, bottom band: "FEASIBILITY & ADOPTION"**
  - Timeline chips:
    - **Nov**: engine, gateway, one governed path
    - **Dec**: full onboarding on TBO mocks, Leave extension, measured cost
    - **8 Jan**: live extension test
  - Adoption: "Shadow → Assist → Autonomous, per step; reserved decisions are never automated."
  - Risk → mitigation (3 items):
    - Mock APIs differ → contract-tested adapters
    - Model mistakes → schema check, user confirmation, human fallback
    - HR trust → shadow mode and a full receipt trail
  - Feasibility line: "Runs on one RTX 5080 laptop; all components are open-source with commercial-use licences."
- `source_footer` (8 pt): "Sources: TBO HR brief pp.8–13; Qwen3.5 model cards (Apache-2.0); cost assumptions: architecture doc §4. T = target · E = estimate · M = measured."
- **If over budget, cut in this order:**
  1. legend words
  2. the second sentence of the Extension card
  3. channel labels, shortened to single words
  4. the third risk
  5. the feasibility line
  **Never cut:** the reserved list, the cost number with its E label, the zero-engine-edits claim, or the gateway band.

#### Thank-you slide
- "Thank you" · team name and members · contact email
- Links: architecture document · video · (Round 2: repository)
- AI-assistance disclosure (11 pt): "Research, drafting and layout were assisted by OpenAI Codex and Anthropic Claude; every design decision and claim was reviewed by the team." Edit this to match what was actually used.

### P4.4 Build steps
1. Write `deck/content.json` from the spec above, with numbers filled from `analysis/cost_summary.md`.
2. Write `deck/build_deck.py`. Give every shape a meaningful name (for example `zoneA_node_it`, `source_footer`).
3. Build, then run:
   - `python tools/check_pptx.py output/submission/RelayHR_Round1_Deck.pptx --content-slides 2 --min-pt 10 --max-words 270 --allow-placeholder DOC_URL --allow-placeholder VIDEO_URL`
     The two `--allow-placeholder` flags are only for use until the links exist (P6/P7). **The final P8 check runs without them.**
   - `powershell -ExecutionPolicy Bypass -File tools/render_pptx.ps1 -Pptx output/submission/RelayHR_Round1_Deck.pptx`
     This writes `output/submission/render_RelayHR_Round1_Deck/` (PDF and `slide-N.png`). Copy that PDF to `output/submission/RelayHR_Round1_Deck.pdf`.
4. **Open and inspect every PNG** (`slide-N.png`).

**GATE P4:** send the user the four PNGs and the check output.

---

## P5 — Deck QA (Codex)

Fix and re-render until every item passes. Record the results in `reviews/deck_qa.md`.

**Visual**
- No clipped or overflowing text, no overlaps, and consistent spacing.
- Text is readable at 960 px wide.
- Contrast is sufficient: no light text on teal or amber below 4.5:1.
- The amber diamond appears only where a human decides.

**60-second skim test.** Look only at the titles and the biggest elements. Can a stranger answer:
1. What is built?
2. Where do humans decide?
3. Why is it cheap?
4. How does it extend?
5. Is it feasible by January?

**Coverage**
- Every row in `requirements_matrix.md` that maps to the deck is visibly satisfied.
- All four portal topics are named on the slides.
- All 8 objectives appear.
- The agent design is visible.

**Honesty**
- Every number carries a T, E, M or B label, and each one appears in `claims_register.md`.
- No banned phrases.
- Competitors are mentioned only in the notes.

**Files**
- PPTX opens in PowerPoint without a repair prompt.
- The PDF has 4 pages with embedded fonts and is under 5 MB (or within the P1 size limit).
- File names: `RelayHR_Round1_Deck.pptx` and `.pdf` (add the team name if the portal requires it).

Then the user runs **Fable review #1** (`handoff/CLINE_FABLE_PROMPTS.md`, prompt 1). Codex applies the accepted fixes,
re-renders, and logs which fixes were accepted or rejected, with reasons, in `reviews/fable_1_actions.md`.

**GATE P5:** deck v2 PNGs, plus a summary of the fixes.

---

## P6 — Six-page architecture document (Codex, about 1.5 days)

This is the brief's own Round 1 deliverable. **Six pages maximum, including references, with no separate cover.**
A4 portrait, 0.6–0.7 in margins, Calibri 10–10.5 pt body, tight but readable.
Reuse the earlier pipeline: `tmp/documents/build_report.py` (python-docx) and `tmp/documents/render_word.ps1` (Word COM export to PDF, which reports the page count).
Create `doc/architecture.md`, `doc/build_doc.py` and `doc/render_doc.ps1` as adapted copies.
Export diagrams as high-resolution PNGs by rendering a `doc/figures.pptx` through `tools/render_pptx.ps1`, so the figures match the deck exactly.

| Page | Content |
|---|---|
| 1. Problem and chosen service | TBO's coordination problem (brief p.8); users (employee, manager, HR, IT/Admin/Finance, developer); onboarding scope and boundaries (starts after a human-approved offer; payroll runs and hiring stay human); the four proofs; a **compact 8-objective trace table** (objective → mechanism → where shown) |
| 2. Architecture and agent design | Architecture figure; data flow (9 steps, from the original plan §3); data ownership (Postgres holds business records and decisions, Temporal holds execution progress, the UI reads a projection); lifecycle states from hire to exit; **agent roster table** (P3.2) |
| 3. Governance and recovery | Governed action flow (allow / deny / approval / human); reserved-decision config as a **short YAML sample**; approvals bound to exact parameters; policy versions; kill-switch semantics; a **PII flow table** (field → reaches model? → where hosted → why); DPDP controls (purpose, consent where needed, retention, access/correction) described precisely, with commencement dates from P2; the labour-law **rule register** (statute, state, effective date, HR sign-off, values from TBO sample policies); fair-hiring rule for future talent-acquisition lines; the lost-response sequence (persist intent → dispatch → timeout → reconcile → exactly one) and a failure-scenario table |
| 4. Models and economics | Routing ladder and **how the threshold is justified** (held-out set: escalate when the schema check fails or an ambiguity flag is set; target ≥95% accepted extraction accuracy, T); benchmark results if P3B ran (M); cost formula with every input and source; per-workflow estimate; monthly projection under scenarios A and B; frontier contrast; sensitivity; provider swap via config (Ollama ↔ llama.cpp ↔ hosted API) |
| 5. Extension model | Contracts: workflow definition, capability/skill registration, integration adapter, action receipt (from the original plan §3); registry validation rules; **Leave worked example** (files added, tests, what is reused, a zero-line engine diff); developer-guide outline; how we will rehearse the finale's live extension test |
| 6. Delivery and validation | Milestones (26 Nov – 24 Dec) and owners (5 roles); acceptance-test table (original plan §4, labelled T); adoption path and risks; assumptions (starter kit pending; synthetic data only); licence inventory (P2); AI-assistance disclosure; compact references (numbered, short) |

**QA:**
- Render through Word to PDF; the page count must be **6 or fewer**.
- Inspect every page PNG.
- Check that numbers match `cost_summary.md` and the deck exactly.
- Check that the agent roster and reserved list match the deck word for word.

Outputs: `output/submission/RelayHR_Round1_Architecture.docx` and `.pdf`.
Upload the PDF to Google Drive or a similar host with "anyone with the link can view", test the link in a private window, and put it into `deck/content.json` as `{DOC_URL}`, then rebuild the deck.

**GATE P6:** report the page count, the page PNGs, and the doc link.

---

## P7 — Five-minute video (Codex prepares; a human records)

The video is **not limited to 2 slides**. Build a separate **video deck** (about 12–15 slides, same design system) with
progressive builds. It reuses the content-slide graphics, enlarged and revealed step by step.

| Time | Story | Visual |
|---|---|---|
| 0:00–0:30 | The problem: HR emails three teams and chases them; what RelayHR does in one line | Cover, then the problem line |
| 0:30–1:25 | The onboarding journey, cross-team, with parallel fan-out; agent roster | Slide 1 flow, revealed node by node; roster table |
| 1:25–2:20 | Governance: gateway decisions, reserved list as config, approval bound to parameters, PII and on-prem inference, kill switch | Gateway band zoomed; reserved chips; PII table |
| 2:20–3:00 | Lost-response recovery: one laptop, never two | 4-step sequence animation, labelled "**Design walkthrough**" (or a real clip if the prototype exists, labelled "Prototype, [date]") |
| 3:00–3:40 | Extension: Leave added, 0 engine edits | File list and registry validation |
| 3:40–4:25 | Model routing and cost logic: ladder, ₹/workflow (E), monthly projection (E), frontier contrast, benchmark (M) if it ran | Ladder and cost card |
| 4:25–5:00 | Feasibility, adoption path, plan to January; team; thank you | Timeline, then the thank-you slide |

Steps:
1. Write `video/script.md` at about 140 words per minute, **no more than 690 words in total**, with timings and slide cues. The script uses the same claims and labels as the deck.
2. Build `video/RelayHR_video_deck.pptx` with a script (`video/build_video_deck.py`), render it, and inspect it. Paste each slide's script into its speaker notes so they work as a teleprompter.
3. **Human recording.** In PowerPoint: Slide Show → **Record** → record from the beginning, with narration on (and the camera optional). Re-record individual slides as needed. Then **File → Export → Create a Video → Full HD (1080p)**, using recorded timings and narrations. Target 4:40–4:55; **never over 5:00**.
4. Check the MP4:
   - length is 5:00 or less
   - audio is clear
   - no slide shows a placeholder
   - file size fits the P1 limit (export at 720p if needed)
5. Upload it (YouTube Unlisted or Drive with link access) and test it in a private window. Put the URL into `{VIDEO_URL}`, then rebuild the deck and document.

**GATE P7:** report the video length, link, and how many takes were needed.

---

## P8 — Final audit and submission

1. The user runs **Fable review #2** (final audit prompt). Codex fixes the findings, re-renders everything, and logs the results in `reviews/fable_2_actions.md`.
2. Final checklist (Codex verifies; the user confirms):
   - [ ] Deck: 4 slides (cover + 2 + thank-you); `check_pptx.py` PASS; PDF and PPTX both present.
   - [ ] Document: 6 pages or fewer; PDF and DOCX.
   - [ ] Video: 5:00 or less; the link works logged-out.
   - [ ] The doc and video links on the cover and thank-you slides work logged-out.
   - [ ] Every number is identical across the deck, document, video script and `cost_summary.md`.
   - [ ] No `{PLACEHOLDER}`, TODO, or banned phrase anywhere (`grep -ri` across `output/submission` text and `video/script.md`).
   - [ ] The team name and member names are spelled correctly.
   - [ ] Codex gives the user the final `git add` / `git commit -m "Add Round 1 submission package"` / `git push` commands. The user runs them.
3. **The user submits on Unstop by 11 Nov**: upload the deck (PDF unless PPT is required), add the video and doc links in every available field, then **screenshot the confirmation**.
4. After submitting, Codex writes `handoff/ROUND2_KICKOFF.md`. It covers the starter-kit compatibility checklist, the build work packages (the original plan §4 ownership and milestones), and the test matrix, so the build can start on 26 Nov.

---

## Appendix A: what NOT to spend time on before submission
- No working UI, logo design, or animations beyond simple builds.
- No extra service lines beyond Leave as the extension example.
- No long competitor analysis (one paragraph of notes is enough).
- No paid tools or hosting.

## Appendix B: ECC (Everything Claude Code) and other add-ons
- **Do not install ECC for Round 1.** Round 1 is research and documents, and ECC's value is coding workflows (TDD, code review, security review).
  - Its Codex plugin adds 32 skills, agent roles and hooks to **every** Codex project, because it has no project scope. That would also reach the user's other hackathon.
  - Its README says rules are "always loaded" and that each MCP tool eats context.
  - Windows native support has open defects.
  - The Codex app's built-in Presentations, Documents, PDF and Browser plugins already cover Round 1.
- **Reconsider on about 24 Nov, before the build round,** and only selectively:
  - Try it on a throwaway repo first. Compare `/status` context usage before and after.
  - For Claude Code, prefer the no-hooks profile (`npx ecc-universal@2.2.3 install --profile minimal --target claude`) or named skills only, at **project** scope.
  - For Codex, use only the native plugin (`codex plugin marketplace add affaan-m/ECC`, then `codex plugin add ecc@ecc`), and disable it while working on the other hackathon.
  - Never stack install methods, and install only from the official `affaan-m/ECC` repo (MIT).
- If it is used in the build, list it in the README's AI-assistance disclosure. The brief requires naming the AI tools used and what they were used for.

## Appendix C: if time runs short (minimum viable package)
In priority order:
1. The 4-slide deck as PDF.
2. The video, recorded straight from the 4-slide deck plus 3–4 enlarged diagram slides.
3. The 6-page document, which can be a lightly formatted DOCX.
**Never** submit late to polish.
