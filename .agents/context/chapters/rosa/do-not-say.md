# ROSA Do-Not-Say List

- Do not say ROSA was deployed or evaluated on a real robot. All ROSA evaluation is in simulation.
- Do not say ROSA was applied to, run on, or evaluated with the AGV or UAV systems; it **modeled** those scenarios.
- Do not say ROSA outperforms BT or Metacontrol on SUAVE. Performance is similar, with no statistical tests.
- Do not say ROSA reacts faster than BT; BT's reaction times are about 10x shorter.
- Do not state "ROSA requires less development effort" as a measured result. Use: fewer modeled elements than the BT baseline in SUAVE, plus separation of task and adaptation logic.
- Do not present development-effort scalability as empirical; it is an analytical result under Assumptions 1--2.
- Do not claim reusability, composability, or extensibility were quantitatively measured.
- Do not say ROSA performs task planning itself; the task decision layer (BT or PlanSys2) chooses actions using ROSA's feasibility knowledge.
- Do not describe PDDL integration with ROSA as future or ongoing work; the chapter already provides the PlanSys2 integration.
- Do not use `\acronym` for ROSA; it renders PLANTA.
- Do not compare ROSA's 100-run numbers directly with SUAVE's 20-run table or PLANTA's runs without saying they are separate experiments.
