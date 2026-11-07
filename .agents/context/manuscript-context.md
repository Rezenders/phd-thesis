# Manuscript Context Index

Compact entry point for the PhD thesis context. Reference material, not policy.
Behavioral rules live in `CLAUDE.md` / `AGENTS.md`.

## Project

- Project: PhD thesis of Gustavo Rezende Silva (TU Delft).
- Title: `Knowledge-based Self-adaptive Robotic Systems` (`dissertation.tex`).
- Structure: framing chapters (introduction, conclusion, summary, propositions)
  plus four paper-based chapters. Each paper chapter is a verbatim copy of a paper.

Build configuration, chapter map, and source-of-truth rules are authoritative in
`paper-model.md`.

## Two Context Levels

1. **Thesis level** (this directory): build, chapter map, cross-chapter
   terminology, thesis research questions and contributions, thesis-wide style.
2. **Chapter level** (`chapters/<name>/`): context inherited from the paper the
   chapter reproduces. Load it whenever the task touches that chapter.

| Chapter | Thesis files | Chapter context | Paper status |
|---|---|---|---|
| SUAVE | `suave/suave.tex` | `chapters/suave/` (bootstrapped 2026-11-06) | Published, SEAMS 2023 |
| ROSA | `rosa/rosa.tex` | `chapters/rosa/` (bootstrapped 2026-11-06) | Accepted, Robotics Software Engineering Journal |
| PLANTA | `pddl/pddl.tex` + generated `pddl/sections/` | `chapters/planta/` (ported from the paper repo) | Under review, ACM TAAS |
| Tactical Retreat | `cognitive_architecture/cognitive_architecture.tex` | `chapters/tactical-retreat/` (ported from the paper repo) | In preparation, Elsevier journal |

Thesis-level rules win over chapter-level rules for framing chapters. Inside a
paper chapter, chapter-level claim boundaries and terminology win, because the
chapter must stay a faithful copy of the paper.

## Focused Context Files

- `paper-model.md`: build commands, chapter map, sync and source-of-truth rules, implementation repositories.
- `terminology.md`: terms and macros shared across chapters, macro namespace conflicts.
- `contributions.md`: thesis research questions and how each chapter answers them.
- `style-preferences.md`: thesis-wide author preferences.
- `do-not-say.md`: thesis-level overclaims (introduction, conclusion, summary, propositions).
- `claim-ledger.md`, `evaluation-claims.md`: thesis-level claims only; per-paper claims live in `chapters/<name>/`.
- `open-findings.md`: unresolved thesis-level findings.
- `reviewer-contracts.md`: committee and promotor comments, when they arrive.
- `passage-contract.md`: template for author-approved drafting contracts.

## Operating Rule

Load only the context files needed for the current task. For a task in one
chapter, load the thesis-level `paper-model.md` and `terminology.md` plus that
chapter's directory. Do not duplicate detailed scientific facts in harness prompts.
