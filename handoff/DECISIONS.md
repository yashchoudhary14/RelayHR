# Decisions log

Use the format `YYYY-MM-DD · decision · reason · who`. Add new entries at the bottom.

- 2026-10-26 · Challenge: AI-Native HR Services Platform (Darwinbox); fallback is Multi-Supplier Optimization · Rubric is explicit and the proof points are testable · Codex + team
- 2026-10-28 · Service line: onboarding after an approved offer; Leave is the extension example · Cross-team depth plus a different workflow to prove reuse · Codex plan
- 2026-10-29 · Deck has 4 slides (cover + 2 content + thank-you), not 3 · The portal excludes cover and thank-you from the limit, and the thank-you slide carries the doc and video links · Claude review
- 2026-10-29 · Add an explicit agent roster (6 roles, 2 use a model) · Brief Round 1 asks for "agent design"; the original plan had none · Claude review
- 2026-10-29 · Cost: per-workflow estimate built from model calls × GPU-seconds plus allocated hosting, a monthly projection from TBO BRSR headcount and turnover, and a frontier-API contrast · "Cost logic" is a shortlisting criterion; the earlier ₹0.20 example mixed serving hours with workflows that wait on humans · Claude review
- 2026-10-29 · Internal freeze 10 Nov, submit 11 Nov · Idea deadline unconfirmed; registration closes 12 Nov · Claude review
- 2026-10-29 · Keep stack (Temporal, OPA, Postgres, FastAPI, Next.js, Ollama + Qwen3.5) and the name RelayHR (pending a quick name check) · Reasonable choices; changing them now costs time · Claude review
- 2026-10-29 · No ECC (Everything Claude Code) for Round 1; reconsider selectively about 24 Nov · Round 1 is documents, not code; ECC's Codex plugin is global (it would also affect the other hackathon) and adds context overhead · Claude review
- 2026-10-29 · Codex workflow: one phase per new thread; SESSION_LOG.md handoffs; cheapest-adequate model per phase; read-only researcher/reviewer subagents on gpt-6-luna; $deck-qa and $session-handoff skills · Fresh context, lower token use, self-verification · Claude review, at user request
- 2026-10-29 · Record 20 November 2026 as the user-reported idea deadline; leave time and remaining P1 fields blank until submission · User explicitly deferred these fields; research and drafting can proceed without inventing answers · User
- 2026-10-29 · Aim for earliest quality-checked completion; retain 10 November freeze and 11 November submission as planning targets · User prioritises quality and early submission; later deadline does not require delaying work · Codex, per user
- 2026-10-29 · P0 stops for human Git initialization and initial commit; no Git write commands run by Codex · No .git directory exists and AGENTS.md explicitly lists Git setup/commits as user gates · Codex
- 2026-10-29 · One-time authorization to execute P0 Git setup and initial commit using repository-local identity Yash choudhary <yashchoudhary.pilot@gmail.com> · User explicitly said to run the supplied commands now; this overrides the earlier no-write instruction for this requested setup · User
