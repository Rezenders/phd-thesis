# Do-Not-Say List

Use this file as a quick guardrail before drafting or revising high-level manuscript prose.

## Evaluation and Results

- Do not say that `\acronym` outperforms existing approaches generally.
- Do not say that `\acronym` outperforms other SUAVE managing subsystems.
- Do not say that SUAVE results demonstrate mission-performance superiority.
- Do not describe SUAVE performance differences as merely marginal without acknowledging statistically significant limitations.
- Do not imply that reaction time causally explains mission-performance differences; the manuscript only says it may partly explain them and does not establish causality.
- Do not generalize AGV/navigation results beyond the evaluated discretized scenario and the replicated Cámara final-step comparison.
- Do not claim general scalability beyond the evaluated class of planning problems.

## Implementation and Technical Behavior

- Do not say that diagnostics updates directly trigger replanning unless the statement is qualified by PlanSys2 execution/precondition monitoring.
- Do not say that `\acronym` supports PDDL numeric fluents or arithmetic numerical planning.
- Do not describe the OWL-to-PDDL ROS integration as a pure-Python converter; it wraps a Java JAR.
- Do not imply that upstream `\plansys` natively supports the PDDL features that this work adds.
- Do not conflate PDDL actions, ROS actions, and robot/task actions; disambiguate where context is not obvious.

## Scope and Contribution Framing

- Do not say that no prior work addresses TACA without qualification; scope related-work gap claims to the reviewed literature and/or use “to the best of our knowledge.”
- Do not say that `\acronym` proves reusability across diverse real-world robotic systems; future work is needed for that.
- Do not say that the approach computes optimal mission-level policies; it is a satisficing planning approach.
- Do not treat `task plan` and `architecture` as interchangeable.
