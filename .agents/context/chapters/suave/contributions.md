# SUAVE Contributions

From the contribution list in the chapter's introduction (`suave/suave.tex`).

1. **Self-adaptation exemplar for AUVs using ROS 2.** It can be equipped with
   different adaptation logics, enables comparison of self-adaptation strategies,
   forms a basis for other adaptive robotic missions, and can run on real robots
   and in simulation (claimed by design: ROS 2, ArduSub, BlueROV2).
2. **Metacontrol-based adaptation logic formulation**, intended as a baseline and
   benchmark for self-adaptation strategies.

## Narrative

- Separates application concerns (managed subsystem) from adaptation concerns
  (managing subsystem) through fixed monitor (`/diagnostics`) and execute
  (System Modes `change_mode` services) interfaces.
- Only `MROS Reasoner`, `System Modes Bridge`, and `Adaptation Goal Bridge` are
  Metacontrol-specific. A random managing subsystem shows the managing subsystem can be swapped.
- In the thesis, SUAVE is the shared evaluation scenario for ROSA and PLANTA, and
  the introduction maps it to a partial answer to RQ1.3.

## Guardrails

- The real-robot claim is a design property. The chapter reports simulation only.
- "Easily reusable for other robotic and non-robotic applications" is asserted,
  not evaluated in this chapter.
