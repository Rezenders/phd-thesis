# Terminology and Macros

Canonical terminology for the PLANTA manuscript. Use this file to prevent macro drift, acronym drift, and technical ambiguity.

## Canonical Macros

Always use these macros for canonical concepts in manuscript prose where applicable:

| Concept | Macro | Renders as |
|---|---|---|
| Proposed system | `\acronym` | PLANTA |
| TOMASys ontology | `\tomasys` | TOMASys |
| PlanSys2 framework | `\plansys` | PlanSys2 |
| OWL-to-PDDL converter | `\owltopddl` | Owl2PDDL |
| Proposed ontology/PDDL model | `\pddltomasys` | PDDL-TOMASys |
| Cámara baseline | `\CamaraApproach` | CAMARA baseline macro |
| Uncertainty labels | `\Uone`, `\Utwo`, `\Uthree` | U1, U2, U3 |
| Scalability experiments | `\Sone`--`\Sfive` | S1--S5 (italic) |
| Research question | `\RQ{n}` | **RQn** (bold) |

## Research Question Dimensions

- RQ1 is **feasibility**, RQ2 is **performance efficiency**, RQ3 is **scalability**. Use these names consistently in the introduction, evaluation, discussion, and conclusions.
- Optimal planning means Fast Downward A* search with the blind heuristic (unit-cost actions, so optimal means shortest plan). Satisficing planning means eager greedy search with the goal-count heuristic.

## Core Terminology Distinctions

- **Action** can mean a PDDL action, a ROS action, or a robot/task action. Disambiguate when context does not make the meaning obvious.
- **Mission-level PDDL action** refers to a PDDL action schema that encodes a task-level mission action in the planning model.
- **Task plan** means the PDDL plan output, i.e., a sequence of grounded task and reconfiguration actions.
- **Architecture** means the software configuration, especially `FunctionDesign` selection.
- **Configuration** should be explicit about whether it refers to architectural configuration or generic experimental/system setup.
- **Reconfiguration action** means a PDDL action that changes `FunctionDesign` grounding unless explicitly discussing a ROS action or runtime operation.
- **Managing subsystem** follows SUAVE/ROSA terminology for the adaptation logic component.
- **Managed subsystem** follows SUAVE/ROSA terminology for the robot system being adapted.

## System and Baseline Names

- The proposed system is `\acronym`; avoid generic “the planner” or “the framework” unless the referent is unambiguous.
- Use `\plansys` for PlanSys2.
- Use `\owltopddl` for the OWL-to-PDDL tool.
- Use Cámara et al.~`\cite{CAMARASoftwareArchitectureTask2020}` or `\CamaraApproach` according to context.
- Use ROSA for the ROSA framework and cite `\cite{rosa}` where appropriate.
- Use SUAVE for the exemplar and cite `\cite{suave}` where appropriate.

## Evaluation Metrics

- SUAVE metrics:
  - `\emph{pipeline search time}`
  - `\emph{pipeline distance inspected}`
  - `\emph{reaction time}`
- Navigation/AGV metrics:
  - planning time
  - peak memory usage (estimated peak aggregate RSS, in MiB, not MB). Author decision
    (2026-10-25): the manuscript defines it once, at its first use in `planta:sec:nav_exp`
    (Experimental design, "peak resident set size (RSS) memory usage"). Everywhere else
    it is written simply as "peak memory" / "peak memory usage". Do not flag the absence
    of "RSS", "aggregate", or "estimated" elsewhere, and do not propose adding them.
  - total path length / distance traveled
  - estimated remaining battery
  - move actions and reconfiguration actions

## Common Risky Phrasings

Before using broad terms such as “outperforms,” “existing approaches,” “general,” “scalable,” “reusable,” “only,” or “proves,” check:

- `.agents/context/chapters/planta/claim-ledger.md`
- `.agents/context/chapters/planta/do-not-say.md`
- `.agents/context/chapters/planta/evaluation-claims.md`

Use “to the best of our knowledge” only when the claim is actually epistemic and appropriately scoped.
