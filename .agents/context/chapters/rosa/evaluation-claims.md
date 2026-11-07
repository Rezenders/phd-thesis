# ROSA Evaluation Claims

Source: `rosa/rosa.tex`, `sec:rosa:evaluation`. Five evaluation dimensions:
feasibility, performance, reusability, development effort, development-effort scalability.

## Feasibility (SUAVE and extended SUAVE, simulation)

- **Supported:** In simulation, ROSA adapted SUAVE to U1 with structural adaptation,
  to U2 with parameter adaptation, and to U3 with TACA, with both BT and PDDL task decision layers.
- **Supported:** Extending to SUAVE extended only required adding the recharge action
  and the battery constraints to the model.
- Thresholds: High configuration needs water visibility > 3.25; search and inspect
  need battery ≥ 0.25. In the performance runs the battery discharges within 200 s.
- **Not supported:** real-robot deployment.

## Performance (`tab:results`, 100 runs per condition, same SUAVE parameters as the SUAVE paper)

| System | Search time (s) | Distance inspected (m)\* | Reaction time U1 / U2 / U3 (s) |
|---|---|---|---|
| SUAVE: None | 174.75 ± 36.00 | 33.20 ± 13.49 | N/A |
| SUAVE: BT | 84.09 ± 26.41 | 62.70 ± 7.78 | 0.08 / 0.10 / N/A |
| SUAVE: Metacontrol | 89.24 ± 35.57 | 60.57 ± 11.17 | 1.55 / 0.82 / N/A |
| SUAVE: ROSA | 85.11 ± 32.48 | 60.76 ± 10.29 | 1.24 / 1.57 / N/A |
| Extended: BT | 94.37 ± 34.92 | 20.88 ± 3.81 | 0.07 / 0.10 / 1.09 |
| Extended: ROSA | 92.75 ± 35.92 | 18.97 ± 3.38 | 1.39 / 1.67 / 2.50 |

\* The chapter's table header says "(s)"; the unit is metres (finding F-009).

- **Supported:** The managing subsystems performed similarly to each other, and
  ROSA did better than no managing subsystem. The paper treats this as additional evidence of feasibility.
- **Supported:** BT has much shorter mean reaction times (about 0.1 s vs 0.8--1.7 s
  for Metacontrol and ROSA), yet mission metrics stay similar.
- **Not supported:** ROSA outperforms BT or Metacontrol. No statistical tests were run.
- **Not supported:** comparing these numbers directly with SUAVE's 20-run table or with PLANTA's runs.

## Reusability (modeling only)

- **Supported:** ROSA's knowledge model can capture the adaptation knowledge for the
  AGV (Cámara et al.) and UAV (MORPH) scenarios, and all entity and relationship
  types were needed across the three use cases.
- **Scope:** The original experimental setups are not public, so ROSA was **not
  run** on them. "Scenarios similar to the ones presented."
- **Not supported:** ROSA was applied or executed on AGV or UAV systems.

## Development effort (`tab:dev_effort`)

- Counts: ROSA SUAVE 30, SUAVE extended 38, AGV 54, UAV 40 (entities + relationships).
  BT: SUAVE 57, extended 72 (BT nodes + System Modes), with the task-only BT
  nodes (10 and 16) subtracted.
- **Supported (bounded, author decision 2026-11-06):** On SUAVE, the ROSA models
  contain fewer modeled elements than the BT baseline, and ROSA separates task
  logic from adaptation logic while the BT couples them.
- **Not supported:** "ROSA requires less development effort" as a measured
  fact. The chapter states that the counts are not straightforwardly comparable because the
  difficulty of modeling an element differs between techniques.

## Development-effort scalability (hypothetical)

- Under Assumptions 1--2: base model has 10 elements per action, +6 per structural adaptation,
  +3 per parameter adaptation, giving $10 + 6n_{sa} + 3n_{pa}$ per action, which is linear.
- **Not supported:** empirical scalability measurements, or claims outside the stated assumptions.
