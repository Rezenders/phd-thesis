# SUAVE Terminology and Notation

Inside the chapter, keep the paper's wording. Framing chapters follow the
thesis-level `terminology.md`.

## Use-case notation

| Symbol | Meaning | Note |
|---|---|---|
| $T1$ | search for the pipeline | SUAVE calls these **tasks**. ROSA renames them **actions** A1/A2. |
| $T2$ | simultaneously follow and inspect the pipeline | |
| $U1$ | thruster failures | Same labels in ROSA; PLANTA uses `\Uone`, `\Utwo`. |
| $U2$ | changes in water visibility | |
| $F_1$--$F_3$ | TOMASys functions maintain\_motion, generate\_search\_path, follow\_pipeline | |
| $FD_1$--$FD_6$ | function designs all\_thrusters, recover\_thrusters, spiral\_low/medium/high, follow\_pipeline | |
| $QA_1$, $QA_2$ | water\_visibility ($[0,\infty)$, metres), performance ($[0,1]$) | |
| $O$, $FG$, $S$ | objective, function grounding, status | TOMASys elements. |

## Macros

- `\kw{...}`: node/package names (`dissertation.tex`).
- `\qa`: $\mathcal{QA}$, declared in `pddl/config/preamble.tex` (generated PLANTA
  file). SUAVE depends on it; if PLANTA's preamble changes, SUAVE can break.

## Names

- **Metacontrol**: the adaptation framework. **MROS**: its ROS 2 implementation
  (`MROS Reasoner` node). **TOMASys**: its metamodel (cited `corbato2013model`).
- **Managed / managing subsystem** (Weyns), consistent across the thesis.
- **Random managing subsystem**: picks configurations arbitrarily. **None**: fixed configuration, no managing subsystem.
- The chapter expands OWL as "Ontology Web Language" (verbatim from the paper).

## Metrics

- In-chapter: *search time* (time from search start until the pipeline is found;
  the time limit is used when it is not found) and *distance inspected* (metres).
- Framing chapters: use **pipeline search time** and **pipeline distance
  inspected** (PLANTA form). Author decision (2026-11-06).
