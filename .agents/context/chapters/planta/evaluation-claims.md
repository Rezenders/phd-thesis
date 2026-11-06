# Evaluation Claims and Evidence Boundaries

Use this file when drafting or auditing results summaries. It records what the current manuscript can support and what must remain qualified.

## Research Questions

The evaluation is organized around three research questions (`pddl/sections/evaluation.tex`, opening list):

- **RQ1 (Feasibility):** integration of `\acronym` into a ROS~2-based system for runtime TACA, and its mission performance against existing managing subsystems. Evidence: implementation and `\plansys` integration, SUAVE and extended SUAVE (`planta:sec:suave_exp`).
- **RQ2 (Performance efficiency):** planning time and peak memory against `\CamaraApproach`, plus plan quality (total path length, estimated remaining battery). Evidence: AGV scenario (`planta:sec:nav_exp`).
- **RQ3 (Scalability):** planning time and plan length as mission and adaptation spaces grow, and the trade-off between optimal (A*) and satisficing (eager greedy) planning. Evidence: `\Sone`--`\Sfive` (`planta:sec:scale_exp`).

## SUAVE Experiments

### Supported

- The SUAVE experiments support the feasibility of applying `\acronym` to ROS~2-based robotic adaptation.
- The extended SUAVE scenario supports feasibility for task and architecture co-adaptation.
- The SUAVE experiments reveal mission-performance limitations relative to other managing subsystems.
- BT, Metacontrol, and ROSA each achieved significantly better results than `\acronym` on at least one metric in every experiment in which they were evaluated.
- BT achieved lower pipeline search times and greater pipeline distances inspected than `\acronym` across the original and extended experiments.
- `\acronym` performed significantly better than Random on both metrics in all original experiments.
- `\acronym` performed better than the configuration without a managing subsystem in experiments 2 and 3, but worse in experiment 1.
- BT's shorter mean reaction times may partly explain BT's advantage. This explanation is scoped to BT, not to Metacontrol or ROSA.

### Not Supported

- Do not claim that `\acronym` outperforms other SUAVE managing subsystems.
- Do not claim mission-performance superiority in SUAVE.
- Do not claim that reaction time causally explains mission-performance differences; the manuscript only permits a cautious “may partly explain” formulation.

## AGV / Navigation Comparison With Cámara et al.

### Supported

- In the evaluated AGV/navigation use case, `\acronym` has lower median planning time and lower median peak memory usage than `\CamaraApproach`.
- At the median, `\acronym` is 3.00 times faster (0.40 s vs 1.21 s) and its peak memory usage is 6.84 times smaller (67.39 MiB vs 461.09 MiB).
- Run-to-run spread is much larger for `\CamaraApproach`: time IQR 0.403--0.404 s (`\acronym`) vs 1.21--2.52 s, memory IQR 66.5--67.9 MiB vs 190--1148 MiB.
- Worst-time runs: `\acronym` wp16→wp25, 0.56 s, 66.88 MiB. `\CamaraApproach` wp52→wp24, 13.71 s, 4089.03 MiB.
- Plan quality: median distance (59.892), move actions (6), and reconfiguration actions (1) are identical. Median remaining battery is 25219.5 (`\acronym`) vs 25480 (`\CamaraApproach`), a −1.02% difference.
- Both approaches sometimes reconfigure more than once: `\acronym` in 11.85% of runs (up to 4), `\CamaraApproach` in 15.52% (up to 4).
- The reported comparison likely underestimates `\acronym`'s computational-performance advantage because only the reproducible final step of `\CamaraApproach` is compared.

### Data Source and Measurement

- Authoritative data: `~/ros_workspaces/planta_ws/src/planta_paper_overleaf/navigation_experiment/` (exported 2026-10-24, see `manifest.json`; not copied into the thesis, which has only `pddl/navigation_experiment/{data,plots,tables}`). Key files: `summaries/camara_metrics.csv`, `camara_comparisons.csv`, `camara_worst_observations.csv`, `camara_reconfigurations.csv`.
- The main comparison is eager greedy `\acronym` vs PRISM. The A* `\acronym` results are supplementary and practically identical (median 0.404 s, 67.11 MiB, 6.87×). Strategies are never pooled.
- n = 30,800 runs per method (3,080 init/goal pairs × 10 repetitions).
- Memory is estimated peak aggregate RSS in MiB: the command plus all descendant processes, sampled every 50 ms. Planning times exclude OWL preprocessing.
- Statistics: mean ± sample SD (ddof=1), type-7 quartiles, Tukey 1.5 IQR whiskers.

### Scope Conditions

- The map from Cámara et al. is discretized to ensure uniform edge lengths.
- The complete original Cámara algorithm could not be replicated; the comparison uses a replicated implementation of the final reproducible PRISM-model step.
- PRISM is run for a single best path in the manuscript's comparison, whereas the original approach considers the ten best paths.

### Not Supported

- Do not claim broad superiority over all existing approaches.
- Do not claim a full end-to-end reproduction of Cámara et al.'s complete pipeline.
- Do not claim the comparison applies unchanged to non-discretized maps or domains requiring numeric fluents.

## Scalability Experiments

### Supported

- For the evaluated single-dimension variations, planning time remains manageable for map size, number of architectural configurations, and number of quality requirements.
- Increasing the number of mission-level PDDL actions has a larger effect on planning time, especially under A* search.
- Combining all varied dimensions causes planning time to increase substantially; A* becomes impractical for online TACA under the full-complexity tested configuration, while eager greedy remains more tractable but still high for frequent replanning.
- Endpoint mean planning times, A* vs eager greedy (`pddl/navigation_experiment/tables/scalability_summary.csv`):
  - `\Sone` (900 nodes): 0.92 s vs 0.95 s, plan length 47.2 for both.
  - `\Stwo` (15 configurations): 0.30 s vs 0.30 s, plan length 20.7.
  - `\Sthree` (4 corridor types): 0.20 s vs 0.20 s, plan length 20.3.
  - `\Sfour` (5 mission-level actions): 15.45 s (SD 1.24) vs 1.05 s (SD 0.30), plan length 46.0 vs 46.8.
  - `\Sfive` (90 nodes, all dimensions): 188.96 s (SD 20.43) vs 13.73 s (SD 3.66), plan length 48.1 vs 51.6.
- Satisficing planning remains tractable where optimal planning becomes impractical, at a moderate cost in plan length.
- Peak memory is not constant. Adaptive group means range from about 38 to 105 MiB (`\Sone`), 39--55 (`\Stwo`), 44--50 (`\Sthree`), 44--95 (`\Sfour`, eager greedy 44--46) and 76--308 MiB (`\Sfive`, eager greedy 76--90). Memory grows with map size and, under A*, with mission-level actions (`summaries/scalability_groups.csv`, metric `peak_memory`).
- Raw instance size is driven primarily by map size, while increased planning time in the mission-action and combined experiments stems from added branching factor rather than simply larger object/fact counts.

### Scope Conditions

- The scalability results apply to the considered class of planning problems.
- The evaluated domains are relatively simple planning domains where a plan exists and can be found by exploring only a small portion of the search space.
- The generated grid maps preserve connectivity after skipping nodes and removing edges.
- The full-complexity stress test uses a smaller maximum map size than the map-size-only experiment.

### Not Supported

- Do not claim general scalability to arbitrary robotic missions or all PDDL planning problems.
- Do not claim suitability for safety-critical high-frequency replanning.
- Do not claim numeric-fluent support; numeric-like values are symbolically encoded.

### Measurement Resolution

- Planning time has a resolution of about 50 ms, because the measured interval ends at the next memory-sampling poll. Treat sub-second differences and ratios with corresponding caution.
- Memory sampling can miss peaks of very short runs (about 0.05--0.1 s no-adaptation runs report 2.8--6 MiB with SD larger than the mean).

## Statistical Reporting Guardrails

- When discussing Wilcoxon tests, preserve the paired-run design and exclusion of pairs where either system did not find the pipeline.
- Preserve the direction of alternatives:
  - lower pipeline search time is better;
  - greater pipeline distance inspected is better.
- Avoid causal language unless the experiment establishes causality.
