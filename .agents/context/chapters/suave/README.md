# SUAVE chapter context

- Thesis chapter: `suave/suave.tex` (label `suave`), figures in `suave/figures/`.
- Paper: "SUAVE: An exemplar for self-adaptive underwater vehicles", SEAMS 2023
  (artifact track), pp. 181--187. Cite key `suave`.
- **Source of truth: the published chapter text.** No paper repo is configured.
  Author decision (2026-11-06).
- Implementation (reference only, not ground truth for paper claims):
  `~/ros_workspaces/suave_rebetmc_ws/src/suave/` (kas-lab/suave). It has evolved
  since publication (v1.6.0, 2026-10). Never use the current code to "correct" a
  claim in the published text; report divergences as findings instead.

## Rules

- The chapter is a verbatim copy of a published paper. Diagnose freely; propose
  scientific or wording changes only as findings, not edits.
- Known verbatim defects are logged in the thesis `open-findings.md` (F-008 onward).
- SUAVE labels are unprefixed (`sec:related`, `fig:tomasys`, `tab:results_m1`, ...).
  No collisions as of 2026-11-06; check before adding labels elsewhere.

## Files (bootstrapped 2026-11-06 from the chapter text, author-approved)

- `terminology.md`: use-case notation (T1/T2, U1/U2, F, FD, QA), macros, metric names.
- `contributions.md`: the paper's two contributions.
- `evaluation-claims.md`: the 20-run baseline results and their limits.
- `claim-ledger.md`: high-risk claims with evidence.
- `do-not-say.md`: prohibited claims.
