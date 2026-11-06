# Terminology

Terms shared across chapters. Chapter-specific terminology lives in
`chapters/<name>/terminology.md`.

## Shared Concepts

| Concept | Required form | Notes |
|---|---|---|
| Self-adaptive system | self-adaptive system (SAS) | |
| Two-layer SAS design | managing subsystem / managed subsystem | Introduction, SUAVE, ROSA, and PLANTA all use this pair (Weyns). |
| Task-and-architecture co-adaptation | TACA | Expanded in the introduction. PLANTA treats it as its core problem. |
| Knowledge representation and reasoning | KR\&R | Used in the introduction RQs and in Tactical Retreat. |
| MAPE-K loop | MAPE-K | Cite `kephart03computer`. |
| Exemplar | SUAVE | Cite `suave`. Reused as the evaluation scenario in ROSA and PLANTA. |
| Knowledge-based managing subsystem | ROSA | Cite `silva2025rosa`. |
| Metacontrol ontology | TOMASys | Cite `corbato2013model`. PLANTA uses a modified version. |
| Planning language | PDDL | |
| Ontology language | OWL | The introduction expands it as "Ontology Web Language". The W3C name is "Web Ontology Language", which the PLANTA abstract uses. See `open-findings.md`. |

## Macro Namespace

Paper chapters bring their own macros into one shared preamble.

- `\acronym` is defined in `pddl/config/macros.tex` as `PLANTA`. It is global.
  Other chapters must not use `\acronym` for their own system names (the ROSA
  paper historically used `\acronym` for ROSA; the ROSA chapter currently writes
  ROSA literally).
- `\plansys`, `\tomasys` come from `pddl/config/macros.tex` and render PlanSys2 and TOMASys.
- `\red` is redefined by `pddl/config/macros.tex` (`dissertation.tex` relaxes it first).
- Tactical Retreat macros (`\approachname`, `\aal`, `\adapdec`, `\qrdec`, `\bb`,
  `\numberofmodels`) are not yet in the thesis preamble. Check for collisions
  before importing them.

## Labels and Cross-References

- Chapter labels: `introduction`, `suave`, `rosa`, `pddl` (PLANTA), `rosa_eval` (Tactical Retreat), `conclusion`.
- PLANTA labels all carry the `planta:` prefix (generated).
- Inside the thesis, a reference to another paper of this thesis should point to
  its chapter (`\Cref{rosa}`) in framing chapters. Inside verbatim paper chapters,
  keep the paper's `\cite`.

## Bibliography Keys

The same reference can exist under several keys because each paper brought its
own `.bib`. Known duplicate: Cámara, Schmerl, Garlan 2020 ("Software architecture
and task plan co-adaptation for mobile service robots") is `camara_software_2020`,
`task_co_adapt_camara_garlan`, and `CAMARASoftwareArchitectureTask2020`.
With `unsrt`, duplicates appear as separate bibliography entries.
