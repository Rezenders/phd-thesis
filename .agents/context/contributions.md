# Thesis Contributions

Recorded from the current draft of `introduction/introduction.tex` (2026-11-05).
**Status: draft wording, not yet author-approved as a contribution contract.**
Per-paper contributions live in `chapters/<name>/contributions.md`.

## Research Questions

Main question: How to design and engineer a reusable solution for task and
architecture co-adaptation for robotic systems?

- **RQ1.1** To what extent can KR\&R techniques promote reusability in self-adaptive robotic systems?
- **RQ1.2** How to architect robotic systems to enable knowledge-based task and architecture co-adaptation?
- **RQ1.3** How to systematically evaluate alternative approaches to robot self-adaptation?

## Chapter-to-RQ Mapping (current introduction)

| Chapter | Contribution | RQs |
|---|---|---|
| SUAVE (`suave`) | Exemplar for evaluating self-adaptive robotic systems | partial RQ1.3 |
| ROSA (`rosa`) | Knowledge-based managing subsystem (MAPE-K, TypeDB), evaluated on SUAVE, shown on AGV and UAV | partial RQ1.1, RQ1.2 |
| PLANTA (`pddl`) | Ontology-mediated planning for TACA (OWL to PDDL), evaluated on SUAVE and against Cámara et al. | partial RQ1.1, RQ1.2 |
| Tactical Retreat (`rosa_eval`) | Introduced as "extends ROSA, real robot, thorough evaluation of ROSA" | RQ1.3 |

## Narrative Commitments

- Robots need runtime adaptation of both task execution and software architecture.
- Prior TACA solutions require significant re-programming per use case (multiple
  DSL models, or a hand-implemented managing subsystem), hindering adoption.
- The thesis argues that KR\&R can make TACA solutions reusable.

## Required Alignment

The introduction outline, each chapter's own contribution statement, the
conclusion, the summary/samenvatting, and the propositions must use compatible
scope. A thesis-level summary must not state a chapter result more strongly than
that chapter's `claim-ledger.md` allows.

## Open Questions

- The Tactical Retreat description in the introduction does not match the
  paper's own research questions (systematic integration of architecture-based
  self-adaptation via runtime models; inferring improved adaptation policies at
  runtime). Which framing should the thesis use, and which RQ does it answer?
- The conclusion currently discusses only ROSA. Should it answer RQ1.1 to RQ1.3 explicitly?
