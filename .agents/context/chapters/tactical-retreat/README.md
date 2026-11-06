# Tactical Retreat chapter context

- Thesis chapter: `cognitive_architecture/cognitive_architecture.tex` (label `rosa_eval`).
  **Status: outline only.** The paper text has not been brought into the thesis.
- Paper: "Tactical Retreat: Introducing New Adaptations by Leveraging Runtime Models"
  (`\approachname` = Tactical Retreat), in preparation for an Elsevier journal.
- Paper repo (source of truth): `~/ros_workspaces/suave_rebetmc_ws/tactical_retreat_overleaf/`
  (entry `main_els_sc.tex`, sections in `sections/`).
- Implementation: `~/ros_workspaces/suave_rebetmc_ws/src/typedb_tactics/`.

## Research questions (paper)

- RQ1: How can this work systematically integrate architecture-based self-adaptation
  into existing robotic systems through the use of runtime models?
- RQ2: How can the use of runtime models be leveraged to infer improved adaptation
  policies at runtime?

These differ from how `introduction/introduction.tex` describes the chapter
(see thesis `open-findings.md` F-003).

## Files (ported 2026-11-05)

- `terminology.md`: macros, notation, distinctions ("action" has three meanings, etc.).
- `implementation-notes.md`: implementation references, high-risk interfaces, accepted abstractions.
- `style-preferences.md`: the paper's preferences (also folded into the thesis-wide file).

Not ported: the paper repo's contributions, claim ledger, evaluation claims, and
do-not-say files are empty placeholders there. Its `open-findings.md` is paper-review
material. Populate this directory's claim files when the paper's evaluation settles.

## Integration notes

- Paper macros (`\approachname`, `\aal`, `\adapdec`, `\qrdec`, `\bb`, `\numberofmodels`),
  DSL listing languages, `InferenceRules`, and `\svgfigure` live in the paper's
  `preamble.tex`/`macros.tex` and are not in the thesis preamble yet.
- The paper needs `-shell-escape` (minted, Inkscape for `svg`) and Ubuntu fonts.
  The thesis Makefile does not pass `-shell-escape`.
