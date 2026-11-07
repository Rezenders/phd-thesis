# SUAVE Evaluation Claims

Source: `suave/suave.tex`, Section "Evaluation" (`sec:results`), Table `tab:results_m1`.

## Setup

- Gazebo simulation, BlueROV2 model, ArduSub. Non-deterministic, so runs are automated.
- 300 s time limit; water visibility is a sine wave (period 80 s, min 1.25, max 3.75,
  no phase shift); thruster 1 fails at 35 s.
- Water visibility and thruster failures are **simulated by the monitor nodes**,
  not by Gazebo. Pipeline detection is a mock-up. Pipeline inspection is not implemented.
- Conditions: None (fixed configuration), Random, Metacontrol. **20 runs each.**

## Results (mean ± std)

| Managing subsystem | Search time (s) | Distance inspected (m) |
|---|---|---|
| None | 187.85 ± 42.40 | 31.40 ± 13.00 |
| Random | 180.15 ± 82.05 | 3.88 ± 3.19 |
| Metacontrol | 106.95 ± 39.46 | 51.15 ± 12.01 |

## Supported

- In this exemplar and configuration, Metacontrol had a lower mean search time and a
  higher mean distance inspected than Random and None.
- Metacontrol's search time had the lowest standard deviation of the three.
- The results serve as a baseline for comparing managing subsystems.

## Limits

- No statistical tests; only means and standard deviations over 20 runs.
- One parameter configuration, simulation only.
- Later chapters rerun SUAVE with different run counts (ROSA: 100 runs), so their
  numbers are **not** the same experiment as this table.

## Not supported

- Statistically significant improvement.
- Results on a real robot, or in other scenarios or configurations.
