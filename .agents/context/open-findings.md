# Open Findings

Track unresolved diagnostic findings. Reviewer/critic agents diagnose only; a
human decides which findings are accepted before the writer revises.

Recorded during agent setup on 2026-11-05 from repository inspection. None has
been accepted yet.

| ID | Source | Location | Finding | Severity | Human decision | Status |
|---|---|---|---|---|---|---|
| `F-001` | setup | `dissertation.bib` | Cámara et al. 2020 exists under three keys (`camara_software_2020`, `task_co_adapt_camara_garlan`, `CAMARASoftwareArchitectureTask2020`); with `unsrt` it can be listed more than once. Related to `TODO` "Check for repeated citations". A thesis-wide duplicate scan has not been done. | major | pending | open |
| `F-002` | setup | `cognitive_architecture/cognitive_architecture.tex:2` | Tactical Retreat chapter uses label `rosa_eval` and directory `cognitive_architecture/`; the chapter is an outline with an empty `\cite{}` in the footnote. | minor | pending | open |
| `F-003` | setup | `introduction/introduction.tex:76` | Introduction describes the Tactical Retreat chapter as "extends ROSA ... thorough evaluation of ROSA", which differs from the paper's RQs. See `contributions.md`. | major | pending | open |
| `F-004` | setup | `introduction/introduction.tex:75` | Introduction expands OWL as "Ontology Web Language"; W3C name and PLANTA abstract use "Web Ontology Language". Same line cites `camara_software_2020` while the PLANTA chapter cites `CAMARASoftwareArchitectureTask2020`. | minor | pending | open |
| `F-005` | setup | `conclusion/conclusion.tex` | Conclusion and future work discuss only ROSA; PLANTA and Tactical Retreat are absent and the RQs are not answered explicitly. | major | pending | open |
| `F-006` | setup | `summary/summary.tex`, `dissertation.tex` dedication | Summary, samenvatting, and dedication are template placeholders. | minor | pending | open |
| `F-007` | setup | `.nvim.lua` | Editor runs `make pdf`, but the Makefile defines no `pdf` target. | minor | pending | open |

## Rules

- Do not feed unapproved findings to the writer.
- Merge duplicates before asking for author decisions.
- Close findings only after a targeted revision and validation check.
