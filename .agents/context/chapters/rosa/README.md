# ROSA chapter context

- Thesis chapter: `rosa/rosa.tex` (label `rosa`, section labels `sec:rosa:*`).
- Paper: "ROSA: A Knowledge-based Solution for Robot Self-adaptation", accepted in
  the Robotics Software Engineering Journal. Cite key `silva2025rosa`. The thesis
  copy is authoritative.
- Implementation: `~/ros_workspaces/suave_rebetmc_ws/src/rosa/` (a second copy
  exists in `~/ros_workspaces/rosa_3_ws/`; canonical one unconfirmed).
- Typesetting: uses the thesis macros `\entity`, `\relationship`, `\attribute`,
  `\instance`, `\runtime` and the TypeQL listing language from `dissertation.tex`.
  Must not use `\acronym` (bound to PLANTA).

**Not bootstrapped.** Run `bootstrap-project-context` scoped to this chapter to
propose `terminology.md`, `contributions.md`, and `evaluation-claims.md` for author approval.
