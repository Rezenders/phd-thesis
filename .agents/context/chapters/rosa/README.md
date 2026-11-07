# ROSA chapter context

- Thesis chapter: `rosa/rosa.tex` (label `rosa`, section labels `sec:rosa:*`;
  figure, table, and listing labels are unprefixed).
- Paper: "ROSA: A Knowledge-based Solution for Robot Self-adaptation", accepted in
  the Robotics Software Engineering Journal. Cite key `silva2025rosa`.
- **Source of truth: the accepted chapter text.** No paper repo is configured.
  Author decision (2026-11-06).
- Implementation (reference only, not ground truth for paper claims):
  - `~/ros_workspaces/suave_rebetmc_ws/src/rosa/` (kas-lab/rosa), the main working copy.
  - `~/ros_workspaces/rosa_3_ws/src/rosa/`: a later TypeDB 3 migration branch. It
    postdates the paper; do not use it to check paper claims.
  - `~/ros_workspaces/suave_rebetmc_ws/src/suave_rosa/`: the SUAVE experiment setup (kas-lab/suave_rosa).
  - `ros_typedb` (in both workspaces): the ROS 2/TypeDB bridge.
  - `kas-lab/rosa_examples` (AGV/UAV models) is not checked out locally.
  The code has changed since acceptance. Report divergences as findings; never
  "correct" the paper from current code.
- Typesetting: uses the thesis macros `\entity`, `\relationship`, `\attribute`,
  `\instance`, `\runtime`, `\runtimefont`, and the TypeQL and PDDL listing languages
  (`dissertation.tex`). Uses natbib `\citep`. Must not use `\acronym` (bound to PLANTA).

## Files (bootstrapped 2026-11-06 from the chapter text, author-approved)

- `terminology.md`: knowledge-model element names, A/U notation, metrics.
- `contributions.md`: the paper's four contributions.
- `evaluation-claims.md`: the five evaluation dimensions, with numbers and limits.
- `claim-ledger.md`: high-risk claims with evidence.
- `do-not-say.md`: prohibited claims.
