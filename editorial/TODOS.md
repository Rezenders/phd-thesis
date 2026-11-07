# TODOs

- Uncomment promotors name and commitee members
- Check for repeated citations

Findings that need your input (from open-findings.md):

- F-003: The introduction describes Tactical Retreat as "extends ROSA… thorough
  evaluation of ROSA", which doesn't match that paper's own research questions.
- F-008: both chapters still contain a "Sample Abstract." placeholder.
- F-009 to F-011: in the ROSA results table, distance inspected is labelled in
  seconds instead of metres. ROSA also says "managed" where it means "managing",
  and there are two typos. These may be verbatim from the papers.
- F-012: more duplicate bibliography keys (Kephart, System Modes), and
  Metacontrol is cited under two different keys.
- F-013: conclusion.tex:4 overstates ROSA by saying it "can be applied to
  different use cases". That conflicts with the new ROSA do-not-say file.
- F-014: the conclusion's future work proposes adding PDDL planning to ROSA, but
  the ROSA chapter already includes a PlanSys2 integration.
- F-015 and F-016: the metric-name split across chapters (your decision is
  recorded), and SUAVE's dependency on the generated PLANTA preamble.

The <PROJECT_NAME>-style placeholders left in .agents/context/ are all in
passage-contract.md, which is meant to be a template. A good next step is
/scientific-claim-tightening on conclusion/conclusion.tex, since F-013 is the
one overclaim these new files now rule out.

## Planta

2. Abstract appears twice: it is in both the chapter-opening abstract box and
   \section{Abstract}. The old file filled the box, while SUAVE and ROSA put it
   in the section. Delete one if you prefer.
3. "Electronic supplement" wording: two sentences in the evaluation still
   mention it. That is the verbatim text, and the material is now sections
   4.13–4.15 of the same chapter.
4. Layout quirks:
   - About 12 overfull boxes, mostly wide equations and figures. The thesis page
     is narrower than the ACM manuscript, and the old chapter had overflows of
     the same size.
   - The long chapter title wraps onto two lines in the page header. This was
     already the case before. A short title, \chapter[short]{…}, would fix it
     but also changes the table of contents.
5. Building locally: xelatex isn't on your PATH, so I built with
   /usr/local/texlive/2026/bin/x86_64-linux.
