# PLANTA Claim Ledger

This file records high-risk manuscript claims, their supported scope, and prohibited overextensions. Use it before drafting abstracts, introductions, conclusions, reviewer responses, and evaluation summaries.

## Evaluation Claims

### SUAVE feasibility and mission performance

- **Supported claim:** The SUAVE experiments support the feasibility of applying `\acronym` to ROS~2-based robotic adaptation, including TACA in the extended scenario.
  - **Evidence:** `pddl/sections/evaluation.tex`, SUAVE summary; `pddl/sections/discussion.tex`, SUAVE exemplar discussion.
  - **Allowed inference:** The implementation can be integrated with and executed on a realistic ROS~2-based robotic exemplar.
- **Supported limitation:** SUAVE reveals mission-performance limitations of `\acronym` relative to other managing subsystems.
  - **Evidence:** `pddl/sections/evaluation.tex` reports BT, Metacontrol, and/or ROSA outperforming `\acronym` on search time and/or distance inspected; `pddl/sections/conclusions.tex` now preserves this caveat.
- **Do not claim:** `\acronym` outperforms SUAVE baselines, achieves mission-performance superiority, or that reaction time causally explains mission performance.

### AGV / Cámara comparison

- **Supported claim:** In the evaluated AGV/navigation use case, `\acronym` outperforms `\CamaraApproach` in planning time and peak memory usage (median 3.00× faster, 6.84× smaller peak memory).
  - **Evidence:** `~/ros_workspaces/planta_ws/src/planta_paper_overleaf/navigation_experiment/summaries/camara_comparisons.csv`, `camara_metrics.csv`. Memory is estimated peak aggregate RSS of the process tree, in MiB.
  - **Scope:** The comparison uses a discretized map and a replicated implementation of the final reproducible step of the Cámara et al. approach.
- **Supported claim:** The two approaches produce plans of near-identical quality in the evaluated comparison. Median distance, move actions, and reconfiguration actions are identical, and median remaining battery differs by −1.02%.
  - **Evidence:** `~/ros_workspaces/planta_ws/src/planta_paper_overleaf/navigation_experiment/summaries/camara_metrics.csv`, `camara_comparisons.csv`, `camara_reconfigurations.csv`.
- **Do not claim:** `\acronym` always performs exactly one reconfiguration. It reconfigures more than once in 11.85% of runs.
- **Do not claim:** `\acronym` broadly outperforms existing approaches, all optimal-policy methods, or Cámara et al.'s complete original pipeline without qualification.

### Scalability

- **Supported claim:** Within the evaluated class of planning problems, planning time remains manageable for several single-dimension variations but increases substantially when mission-level PDDL action schemas increase or when all dimensions are combined.
  - **Evidence:** `pddl/sections/evaluation.tex`, scalability results for `\Sone`--`\Sfive`; `pddl/navigation_experiment/tables/scalability_summary.csv`.
- **Do not claim:** Peak memory is constant across scalability experiments. It ranges from about 38 to 308 MiB and grows with map size and mission-level actions.
- **Supported limitation:** Scalability results should be interpreted within relatively simple planning domains where a plan exists and can be found by exploring only a small part of the search space.
  - **Evidence:** `pddl/sections/introduction.tex` evaluation-scoping paragraph.
- **Do not claim:** General scalability to arbitrary robotic missions, safety-critical high-frequency replanning, or all PDDL problem classes.

## Implementation Claims

### Replanning behavior

- **Supported claim:** Runtime diagnostics update PDDL state predicates; `\plansys` plan execution monitors action preconditions and replanning occurs when execution/precondition validity fails.
  - **Evidence:** `pddl/sections/background.tex`; `~/ros_workspaces/planta_ws/src/suave_planta/src/suave_planta_controller.cpp` applies diagnostics and calls `execute_plan()` after failed execution result.
- **Do not claim:** Every diagnostics update directly or immediately triggers replanning.

### Numeric QA encoding

- **Supported claim:** Numeric QA values are encoded as symbolic constants and inequality predicates such as `lessThan`/`lessthan`, not as PDDL numeric fluents.
  - **Evidence:** `pddl/sections/discussion.tex`; `~/ros_workspaces/planta_ws/src/suave_planta/pddl/*_created.pddl`; `~/ros_workspaces/planta_ws/src/suave_planta/src/suave_planta_controller.cpp` symbolic-number insertion.
- **Do not claim:** `\acronym` supports PDDL 2.1 numeric fluents or arithmetic numerical planning.

### OWL-to-PDDL implementation path

- **Supported claim:** The OWL-to-PDDL transformation is provided as a standalone Kotlin/Java executable and integrated into ROS~2 through a Python ROS node that invokes the Java JAR.
  - **Evidence:** `pddl/sections/implementation.tex`; `~/ros_workspaces/planta_ws/src/owl_to_pddl/owl_to_pddl/owl_to_pddl.py`.
- **Do not claim:** The converter is a native pure-Python OWL-to-PDDL implementation.

### PlanSys2 extension

- **Supported claim:** This work extends `\plansys` to support the PDDL features required by the generated models, including derived predicates and existential preconditions.
  - **Evidence:** `pddl/sections/introduction.tex`, `pddl/sections/background.tex`, `pddl/sections/implementation.tex`.
- **Do not claim:** Upstream `\plansys` supports these features without the extension.

## Contribution Claims

- **Supported contributions:**
  1. Ontology-mediated planning approach for mission-wide TACA using a single PDDL formulation, satisficing planning, and runtime replanning.
  2. Open-source ROS~2 implementation, including an extension of `\plansys` for derived predicates and existential preconditions.
  3. Systematic evaluation, including a comparison with Cámara et al. and a scalability analysis.
  - **Evidence:** `pddl/sections/introduction.tex` contributions list; `pddl/sections/conclusions.tex` conclusion summary.
- **Do not claim:** The approach is optimal, generally dominant over all alternatives, or proven reusable across diverse real-world systems beyond the evaluated use cases.
