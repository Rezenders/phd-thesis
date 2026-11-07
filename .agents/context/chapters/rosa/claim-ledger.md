# ROSA Claim Ledger

## Contribution and framing claims

- **Supported:** ROSA enables runtime TACA in ROS 2-based systems, **in simulation** (SUAVE extended, U3).
  - Evidence: `sec:rosa:evaluation` Feasibility results.
- **Supported:** The knowledge model captures the adaptation knowledge of three TACA-relevant scenarios (SUAVE, AGV, UAV).
  - Evidence: `sec:reusability`. AGV and UAV are modeled only.
  - **Do not claim:** ROSA was applied, deployed, or evaluated at runtime on AGV/UAV.
- **Supported:** Reusability, composability, and extensibility are design goals backed by the architecture premises and the modeling evidence.
  - **Do not claim:** they were quantitatively measured.
- **Scoped:** Related-work gaps are framed "to the best of our knowledge" (no reusable TACA solution; Cámara et al. the most complete). Keep that qualifier.

## Performance

- **Supported:** Similar mission performance to BT and Metacontrol on SUAVE; better than none.
  - Evidence: `tab:results` (100 runs, means ± std).
  - **Do not claim:** superiority over BT or Metacontrol, or statistical significance.
- **Supported:** BT reacts an order of magnitude faster than ROSA. Do not hide this
  when summarizing.

## Development effort

- **Supported (bounded):** ROSA SUAVE models have fewer modeled elements than
  the BT baseline (30 vs 57; 38 vs 72) and separate task logic from adaptation logic.
  - Evidence: `tab:dev_effort` and the BT discussion.
- **Caveat:** The chapter itself says the element counts cannot be compared
  straightforwardly. The ROSA abstract's "advantages in ... development effort" stays
  verbatim in the chapter, but framing chapters use the bounded form above.

## Scalability

- **Supported:** Under Assumptions 1--2, ROSA's model grows linearly ($10 + 6n_{sa} + 3n_{pa}$ per action).
  - **Do not claim:** empirical scalability, or scalability of runtime reasoning performance (not evaluated).

## Implementation

- **Supported:** The analyze step is TypeDB's reasoner (no separate analyze node);
  the configuration planner picks the highest-priority feasible configuration; the
  execute step uses lifecycle transitions, node start/kill, and the ROS parameter API.
- **Supported:** Integrations exist for BTs (`IsActionFeasible`, `RosaAction`) and
  PlanSys2 (`RosaPlanner`, `RosaAction`, `action_feasible` predicate).
- **Do not claim:** the configuration planner uses `estimation` for optimisation in
  the reference implementation. The chapter only says it selects by priority; estimations are part of the model.
