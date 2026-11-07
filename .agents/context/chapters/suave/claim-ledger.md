# SUAVE Claim Ledger

## Exemplar properties

- **Supported:** SUAVE lets different managing subsystems be connected without
  modifying the managed subsystem, the monitor nodes, or the execute mechanism, as long as they use `/diagnostics` and the System Modes services.
  - Evidence: `sec:managing_requirements`, conclusion. Demonstrated with Metacontrol and Random.
- **Supported, by design only:** can run on a real robot (ROS 2, ArduSub, BlueROV2).
  - Evidence: introduction, `sec:managed`. No real-robot experiment is reported.
  - **Do not claim:** SUAVE was validated or evaluated on a real robot.
- **Supported:** extensible by adding lifecycle nodes and updating the System Modes configuration.
  - Evidence: `sec:managing_requirements`. Later shown in practice by ROSA's extended SUAVE (battery, recharge).

## Evaluation

- **Supported:** with Metacontrol, mean search time was lower and mean distance
  inspected higher than with Random or None (20 runs each, one configuration).
  - Evidence: `tab:results_m1`.
  - **Do not claim:** statistical significance, or a general superiority of Metacontrol.
- The paper's own wording "Metacontrol improves the performance of the system, and
  outperforms the random managing subsystem" stays in the chapter. Framing chapters
  should scope it: "in the SUAVE baseline experiment".

## Simplifications

- Monitor step mocked (sine-wave visibility, scripted thruster failures), mock
  perception, no inspection. Sources of uncertainty such as ocean dynamics, sensor
  failures, and battery are out of scope of the original exemplar.
