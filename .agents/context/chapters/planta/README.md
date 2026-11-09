# PLANTA chapter context

- Thesis chapter: `pddl/pddl.tex` (label `pddl`), body `\input` from `pddl/sections/`.
- Paper: "Plan your Self-Adaptation! -- Ontology-Mediated Task and Architecture
  Co-adaptation Planning for Robots", under review at ACM TAAS. Cite key `silva2025planyour`.
- Paper repo (source of truth): `~/ros_workspaces/planta_ws/src/planta_paper_overleaf/`.
  Its own `.agents/context/` holds paper-only material not ported here
  (`reviewer-contracts.md`, `open-findings.md`, `paper-model.md`, `lint-baseline.json`).

## Rules

- `pddl/sections/`, `pddl/config/`, `pddl/figures/`, `pddl/tables/`, and
  `pddl/navigation_experiment/` are thesis-owned since 2026-11-09 and no longer
  synced. Do not run `pddl/sync_from_paper.py`.
- Edit them for formatting only: adapt tables, listings, equations, figures and
  floats from the journal layout to the thesis template. Do not change content
  (wording, numbers, results, claims, equation meaning, citations, labels); report
  content findings to the author instead.
- `pddl/pddl.tex` holds the title, abstract, footnote and input list.
- All labels in the chapter carry the `planta:` prefix; supplement labels are `planta:S-<key>`.

## Files (ported 2026-11-05 from the paper repo, paths rewritten to thesis paths)

- `terminology.md`: macros (`\acronym` = PLANTA, `\tomasys`, `\plansys`, `\owltopddl`,
  `\pddltomasys`, `\CamaraApproach`, `\Uone`..., `\Sone`...), RQ names, metrics.
- `contributions.md`: the paper's three contributions and narrative.
- `evaluation-claims.md`: supported and unsupported results for SUAVE, AGV/Cámara, scalability.
- `claim-ledger.md`: high-risk claims with evidence.
- `do-not-say.md`: prohibited claims.
- `style-preferences.md`: PLANTA-specific preferences on top of the thesis-wide ones.

When the paper's context changes, re-port these files. They are copies, not links.
