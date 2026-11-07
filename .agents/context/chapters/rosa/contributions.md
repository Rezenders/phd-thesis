# ROSA Contributions

From the contribution list in the chapter's introduction (`rosa/rosa.tex`).

1. **Modular architecture** that extends robotics architectures with a
   MAPE-K managing subsystem and supports reusability, composability, and extensibility.
2. **Reusable knowledge model** capturing all application-specific aspects of
   the adaptation logic required for TACA.
3. **Open-source reference implementation** (ROS 2, TypeDB, BehaviorTree.CPP and
   PlanSys2 integrations; kas-lab/rosa, kas-lab/ros_typedb).
4. **Experimental evaluation** based on **simulated** robotic self-adaptation scenarios.

## Central narrative

- Existing TACA solutions (MORPH, Cámara et al.) need multiple DSL models or
  task-specific transformations, and they lack runtime reusability ("to the best of our knowledge").
- ROSA puts **all** application-specific adaptation knowledge in **one** model
  that conforms to its knowledge model; the MAPE components are generic, stateless, and do not communicate with each other.
- TypeDB is chosen because the knowledge model needs n-ary, many-to-many, and
  higher-order relationships with attributes, without reification (unlike OWL).
- TACA comes from the task decision layer reading action feasibility from the KB
  (BT `IsActionFeasible`, PDDL `action_feasible` predicate) together with ROSA's architectural adaptation.

## Thesis mapping

- The introduction maps ROSA to partial answers to RQ1.1 and RQ1.2.
- PLANTA (`pddl`) later compares against ROSA on SUAVE; ROSA's results there come from PLANTA's own runs.

## Guardrails

- Reusability is shown by **modeling** the AGV and UAV scenarios, not by running them.
- Extensibility and composability are architectural arguments (premises 1--4), not measured.
