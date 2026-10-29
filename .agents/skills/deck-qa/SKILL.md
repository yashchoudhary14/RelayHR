---
name: deck-qa
description: Build, check, render and visually inspect the RelayHR submission deck (or the video deck) and fix problems until it passes. Use after every change to deck/content.json or deck/build_deck.py.
---

# Deck QA loop

Done when the check passes, every slide PNG has been inspected, and no visual problem is left.

1. Build: `python deck/build_deck.py` (or `python video/build_video_deck.py` for the video deck).
2. Check:
   `python tools/check_pptx.py output/submission/RelayHR_Round1_Deck.pptx --content-slides 2 --min-pt 10 --max-words 270`
   Add `--allow-placeholder DOC_URL --allow-placeholder VIDEO_URL` only while those links do not exist yet. The final check runs without them.
   For the video deck, use `--content-slides 20 --max-words 120`.
3. Render:
   `powershell -ExecutionPolicy Bypass -File tools/render_pptx.ps1 -Pptx output/submission/RelayHR_Round1_Deck.pptx`
   Copy the PDF from `output/submission/render_RelayHR_Round1_Deck/` to `output/submission/RelayHR_Round1_Deck.pdf`.
4. Open **every** `slide-N.png` and look for:
   - clipped or overflowing text
   - overlaps and misalignment
   - uneven spacing
   - low contrast
   - an amber diamond anywhere other than a human decision
   - unlabelled numbers
5. Fix the problems in `deck/content.json` or the build script, never in the PPTX by hand. Repeat from step 1. If the same problem survives two fixes, change the layout instead of shrinking the font below 10 pt.
6. Report in 5 lines or fewer:
   - check result
   - words per slide
   - what you fixed
   - anything left for the user
