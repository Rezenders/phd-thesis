# ROSA Terminology and Notation

Inside the chapter, keep the paper's wording. Framing chapters follow the
thesis-level `terminology.md`.

## Typesetting macros (from `dissertation.tex`)

| Macro | Used for | Example |
|---|---|---|
| `\entity{}` | knowledge-model entities | `\entity{Action}`, `\entity{Component}` |
| `\relationship{}` | knowledge-model relationships | `\relationship{function design}`, `\relationship{constraint}` |
| `\attribute{}` | attributes | `\attribute{priority}` |
| `\instance{}` | model instances (italic) | `\instance{search pipeline}` |
| `\runtime{}` / `\runtimefont` | elements instantiated at runtime (coloured) | |

## Knowledge model

- **Architectural knowledge:** entities `Action`, `Function`, `Component`,
  `Component Parameter`; relationships `functional requirement`, `function design`, `component configuration`.
- **Adaptation heuristic knowledge:** entities `Measure`, `Quality Attribute`,
  `Environmental Attribute`; relationships `required action`, `measurement`, `constraint`, `estimation`.
- **Reconfiguration plan knowledge:** `reconfiguration plan`, `component activation`,
  `component deactivation`, `parameter adaptation`.
- **Function design** in ROSA is a *relationship* (Function to Components). In
  SUAVE/TOMASys it is an element $FD(F, \mathcal{C}, \qa^{exp})$. Do not conflate them when comparing chapters.
- Statuses (decision diagrams): component "unsolved"/"configuration error" means
  parameter adaptation; function "unsolved"/"configuration error" means structural
  adaptation; action "unfeasible" means TACA (the task decision layer picks another action).

## Use-case notation

- SUAVE in ROSA: actions **A1** search pipeline, **A2** follow and inspect pipeline,
  **A3** recharge battery (extension); uncertainties **U1** thruster failure,
  **U2** water visibility, **U3** battery level (extension). SUAVE itself calls A1/A2 "tasks" T1/T2.
- UAV (MORPH) scenario: A1--A5 have different meanings. Keep them local to `sec:morph_example`.

## Adaptation types

- **Parameter adaptation**: switching `component configuration`.
- **Structural adaptation**: switching `function design` and active components.
- **TACA**: task-and-architecture co-adaptation (cite `task_co_adapt_camara_garlan`
  in this chapter).

## Other names

- **Task decision layer**: the robotics architecture layer for task planning and
  execution (BT via BehaviorTree.CPP, or PDDL via PlanSys2). ROSA does not decide tasks itself.
- **BT managing system**: the baseline built for this paper (BT plus System Modes).
- **Overhead**: number of modeled elements (ROSA: entities + relationships; BT:
  BT nodes + System Modes modes/parameters).
- The chapter writes ROSA literally, never `\acronym`.

## Metrics

- In-chapter: *search time*, *distance of the pipeline inspected* / "distance
  inspected", and *reaction time* (introduced by this paper).
- Framing chapters: **pipeline search time**, **pipeline distance inspected**,
  **reaction time**. Author decision (2026-11-06).
