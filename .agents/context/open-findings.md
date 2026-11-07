# Open Findings

Track unresolved diagnostic findings. Reviewer/critic agents diagnose only; a
human decides which findings are accepted before the writer revises.

Recorded during agent setup on 2026-11-05 from repository inspection. None has
been accepted yet.

| ID | Source | Location | Finding | Severity | Human decision | Status |
|---|---|---|---|---|---|---|
| `F-001` | setup | `dissertation.bib` | Resolved: all thesis chapter citations use the new shared entry `CAMARASoftwareArchitectureTask2020`; removed the two older aliases and the duplicate entry under the shared key. A thesis-wide duplicate scan remains outside this fix (see F-012). | major | approved | resolved |
| `F-002` | setup | `cognitive_architecture/cognitive_architecture.tex:2` | Tactical Retreat chapter uses label `rosa_eval` and directory `cognitive_architecture/`; the chapter is an outline with an empty `\cite{}` in the footnote. | minor | pending | open |
| `F-003` | setup | `introduction/introduction.tex:76` | Introduction describes the Tactical Retreat chapter as "extends ROSA ... thorough evaluation of ROSA", which differs from the paper's RQs. See `contributions.md`. | major | pending | open |
| `F-004` | setup | `introduction/introduction.tex:75` | Introduction expands OWL as "Ontology Web Language"; W3C name and PLANTA abstract use "Web Ontology Language". Same line cites `camara_software_2020` while the PLANTA chapter cites `CAMARASoftwareArchitectureTask2020`. | minor | pending | open |
| `F-005` | setup | `conclusion/conclusion.tex` | Conclusion and future work discuss only ROSA; PLANTA and Tactical Retreat are absent and the RQs are not answered explicitly. | major | pending | open |
| `F-006` | setup | `summary/summary.tex`, `dissertation.tex` dedication | Summary, samenvatting, and dedication are template placeholders. | minor | pending | open |
| `F-007` | setup | `.nvim.lua` | Editor runs `make pdf`, but the Makefile defines no `pdf` target. | minor | pending | open |
| `F-008` | bootstrap SUAVE/ROSA (2026-11-06) | `suave/suave.tex:4-6`, `rosa/rosa.tex:3-5` | Both chapters have a `\begin{abstract}Sample Abstract.\end{abstract}` placeholder in addition to the paper's `\section{Abstract}`. | major | pending | open |
| `F-009` | bootstrap SUAVE/ROSA | `rosa/rosa.tex:722` | `tab:results` header says "Distance inspected (s)"; the unit is metres (SUAVE table uses m). Possibly verbatim from the accepted paper. | minor | pending | open |
| `F-010` | bootstrap SUAVE/ROSA | `rosa/rosa.tex:709` | "The different managed subsystems had similar performance" should say *managing* subsystems. | minor | pending | open |
| `F-011` | bootstrap SUAVE/ROSA | `suave/suave.tex:116`, `rosa/rosa.tex:237` | Typos "Metacontol" and "funcional requirement" (possibly verbatim from the papers). | minor | pending | open |
| `F-012` | bootstrap SUAVE/ROSA | `dissertation.bib` | More duplicate keys: `kephart03computer`/`kephart2003vision` ("The vision of autonomic computing") and `system_modes`/`nordmann2021system` (System Modes). Metacontrol/TOMASys is cited as `corbato2013model` (SUAVE, intro) and `hernandez2018self` (ROSA). Extends F-001. | major | pending | open |
| `F-013` | bootstrap SUAVE/ROSA | `conclusion/conclusion.tex:4` | "showed that ... ROSA, can be applied to different use cases" overstates the ROSA chapter: AGV/UAV were modeled, not applied at runtime (see `chapters/rosa/do-not-say.md`). | major | pending | open |
| `F-014` | bootstrap SUAVE/ROSA | `conclusion/conclusion.tex:14-16` | Future work proposes ROSA PDDL integration (commented line calls it "ongoing"), but the ROSA chapter already ships a PlanSys2 integration, and PLANTA covers ontology-to-PDDL planning. | minor | pending | open |
| `F-015` | bootstrap SUAVE/ROSA | `suave/suave.tex`, `rosa/rosa.tex`, `pddl/` | SUAVE metrics have three names across chapters ("search time"/"distance inspected"; "distance of the pipeline inspected"; "pipeline search time"/"pipeline distance inspected"). Author decision: framing chapters use the PLANTA form; chapters stay verbatim. | minor | decided (framing uses PLANTA form) | open |
| `F-016` | bootstrap SUAVE/ROSA | `suave/suave.tex` | SUAVE uses `\qa`, which is defined only in the generated `pddl/config/preamble.tex`. A cross-chapter dependency on a generated file. | minor | pending | open |

## Rules

- Do not feed unapproved findings to the writer.
- Merge duplicates before asking for author decisions.
- Close findings only after a targeted revision and validation check.
