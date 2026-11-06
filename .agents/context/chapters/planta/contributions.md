# Contributions and Narrative Commitments

Stable contribution framing for the PLANTA manuscript. Use this file when revising the abstract, introduction, discussion, conclusion, response letters, and reviewer-comment edits.

## Main Contributions

The manuscript's contribution list in `pddl/sections/introduction.tex` states three contributions:

1. **Ontology-mediated planning approach for mission-wide TACA**
   - Combines task and reconfiguration actions in a single PDDL formulation.
   - Supports satisficing planning with runtime replanning.
   - Uses OWL and PDDL as standard modeling languages.

2. **Open-source ROS 2 implementation**
   - Designed for integration with ROS~2-based robotic systems.
   - Connects ontology/PDDL transformation, planning, execution, and runtime state updates.
   - Includes an extension of `\plansys` to support derived predicates and existential preconditions required by the generated PDDL models.

3. **Systematic evaluation**
   - Includes a comparison with the state-of-the-art approach by Cámara et al.
   - Includes a scalability analysis assessing the feasibility of satisficing planning in tested regimes where optimal planning becomes impractical.

## Required Alignment

High-level summaries should mention all three contributions when summarizing the paper as a whole, especially in:

- introduction contribution paragraph;
- conclusion first paragraph;
- cover letters and response letters;
- broad reviewer-response summaries.

A local passage may focus on only one contribution when its rhetorical function is narrower, but it must not imply that the other contributions do not exist.

## Central Narrative

The manuscript motivates PLANTA as a satisficing alternative to approaches that compute optimal task-and-configuration policies under probabilistic models.

Supported narrative:

- TACA requires considering dependencies between mission actions and architectural configuration over the mission.
- Existing approaches either do not fully address this, do so reactively, or have practical costs such as longer planning times, lower reusability, or reliance on detailed probabilistic models.
- PLANTA trades mission-level optimality guarantees for timely satisficing planning and runtime replanning from observed state.
- OWL is used for architectural knowledge; PDDL is used for planning; the ontology is translated and integrated with the task model.

## Contribution Guardrails

Do not claim:

- PLANTA computes optimal mission-level policies.
- PLANTA is generally superior to all existing self-adaptation approaches.
- PLANTA has demonstrated reusability across diverse real-world robotic systems; this remains future work.
- The evaluation proves general scalability beyond the tested planning-problem class.
- The SUAVE experiments show mission-performance superiority.

## Relation to Evaluation

The evaluation supports the contributions as follows:

- SUAVE supports feasibility of integration with a ROS~2-based robotic exemplar and reveals mission-performance limitations.
- The AGV/navigation comparison supports planning-time and peak-memory advantages over the replicated Cámara final-step comparison.
- The scalability experiments characterize how planning time behaves under controlled increases in map size, architectural configurations, quality requirements, mission-level PDDL actions, and combined stress-test conditions.

Use `.agents/context/chapters/planta/evaluation-claims.md` and `.agents/context/chapters/planta/claim-ledger.md` for precise evidence boundaries.
