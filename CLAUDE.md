# CLAUDE.md
<!-- scientific-writing-agent canonical-workflow -->

## Scientific-Writing Agent Workflow

This project uses `.agents/` as the canonical shared workflow layer:

- `.agents/agents/` contains reusable agent role instructions.
- `.agents/skills/` contains reusable manuscript workflows.
- `.agents/context/` contains project-specific scientific context and guardrails.

Harness-specific directories such as `.claude/` and `.pi/` are adapters only. Prefer generated mirrors rather than divergent hand-maintained copies, especially for Overleaf-compatible repositories where symlinks are not supported. Reviewer and critic agents diagnose only; the writer uses an author-approved passage contract, human-approved findings, and at most one targeted revision. Follow `.agents/latex-safe-editing.md` for protected constructs, minimal diffs, and validation of approved edits.

## PhD Thesis Rules

This repository is a PhD thesis (`dissertation.tex`) made of framing chapters and
four paper chapters. Start from `.agents/context/manuscript-context.md`.

- **Paper chapters are verbatim copies of papers.** Load `.agents/context/chapters/<name>/`
  for any task in a paper chapter. Diagnose freely, but scientific edits belong in
  the paper repository, not the thesis.
- **PLANTA files are thesis-owned, formatting-only** (`pddl/sections/`, `pddl/config/`,
  `pddl/figures/`, `pddl/tables/`, `pddl/navigation_experiment/`). They are no longer
  synced from the paper; do not run `pddl/sync_from_paper.py`. Edit them only to fit
  the thesis template (layout of tables, listings, equations, figures, floats; line
  breaks; LaTeX plumbing). Do not change content: wording, numbers, results, claims,
  equation meaning, citations, labels. Content changes go to the author first.
- **Build into `build-agent/`, never `build/`.** The author's VimTeX owns `build/`.
  Use `make BUILD=build-agent build-agent/dissertation.pdf`. Do not run `make clean`.
- `\acronym` means PLANTA everywhere in the thesis.
- Framing chapters must not summarize a chapter result more strongly than that
  chapter's `claim-ledger.md` and `do-not-say.md` allow.
