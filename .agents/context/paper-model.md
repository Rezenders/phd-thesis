# Paper Model

Authoritative thesis layout, build configuration, and implementation references.
Facts below were confirmed from repository evidence on 2026-11-05.

## LaTeX Configuration

- Build working directory: repository root.
- Entry point: `dissertation.tex` (class `dissertation.cls`, TU Delft template).
  `propositions.tex` (class `propositions.cls`) is a second, separate entry.
- TeX engine: XeLaTeX (`latexmk -xelatex`). Fonts are bundled in `fonts/`.
- Bibliography: BibTeX, single database `dissertation.bib`, style
  `\bibliographystyle{unsrt}` in `dissertation.tex`. `dissertation.bst` is present
  but is not the selected style.
- Glossary/acronyms: `glossaries` via `makeglossaries -d <build dir> dissertation`
  (`glossary.tex`, `abbreviations.tex`).
- Chapters are `\include`d, so each chapter writes its `.aux` file into a
  subdirectory of the build directory. The Makefile creates these from the
  `\include` lines.
- Preamble/macros: `dissertation.tex` (shared macros such as `\entity`,
  `\relationship`, `\attribute`, `\runtime`, `\kw`, PDDL/TypeQL listing languages),
  `abbreviations.tex`, and the PLANTA paper configuration `pddl/config/preamble.tex`,
  `pddl/config/macros.tex`, `pddl/navigation_experiment/plots/paper_support.tex`.
- Figures: `figs/` (thesis), plus per-chapter `suave/figures/`, `pddl/figures/`.
- Editorial material: none yet. `TODO` holds author reminders.
- Inactive sources (not built): `type/type.tex`, `ipa/ipadissertations_2018.tex`,
  `appendix-a/` (commented out in `dissertation.tex`).

## Validation Commands

The author's editor (VimTeX, `.nvim.lua`) compiles continuously into `build/`.
Agents must not build into, clean, or rely on `build/`, because concurrent
latexmk runs on one output directory corrupt each other's aux/log/PDF files.
Agents build into `build-agent/` by overriding the Makefile variable:

```bash
make BUILD=build-agent build-agent/dissertation.pdf    # agent thesis build (~20 s)
make BUILD=build-agent build-agent/propositions.pdf    # agent propositions build
chktex -q dissertation.tex                              # optional lint, no baseline yet
```

- Expected output: `build-agent/dissertation.pdf`, log `build-agent/dissertation.log`.
- `make`/`make all` and `make clean` act on `build/` and are author-only.
- `make all` also produces `build/dissertation_print.pdf` via Ghostscript.
- TeX Live is at `/usr/local/texlive/2026/bin/x86_64-linux`.
- Known benign warnings: `LaTeX Font Warning: Font shape ... undefined` for
  Inconsolata and Libertinus Math bold/italic shapes.
- No lint baseline has been established. Adopting one requires author approval.

## Chapter Map

| Order | File | Label | Role | Source of truth |
|---|---|---|---|---|
| front | `title/title.tex` | | Title page, committee | thesis |
| front | `summary/summary.tex` | | Summary + Samenvatting (placeholders) | thesis |
| front | `acks/acks.tex` | | Acknowledgements | thesis |
| 1 | `introduction/introduction.tex` | `introduction` | Motivation, research questions, contributions and outline | thesis |
| 2 | `suave/suave.tex` | `suave` | SUAVE exemplar paper | thesis copy (paper published) |
| 3 | `rosa/rosa.tex` | `rosa` | ROSA paper | thesis copy (paper accepted) |
| 4 | `pddl/pddl.tex` + `pddl/sections/*.tex` | `pddl` | PLANTA paper and its electronic supplement | paper repo (generated) |
| 5 | `cognitive_architecture/cognitive_architecture.tex` | `rosa_eval` | Tactical Retreat paper (currently an outline) | paper repo (not yet synced) |
| 6 | `conclusion/conclusion.tex` | `conclusion` | Conclusion and future work | thesis |
| back | `cv/cv.tex`, `publications/publications.tex` | | CV and publication list | thesis |
| sep. | `propositions.tex` | | TU Delft propositions | thesis |

Directory names `pddl/` and `cognitive_architecture/` and the label `rosa_eval`
are historical. They hold PLANTA and Tactical Retreat respectively.

## Paper Chapters: Source of Truth and Sync

Each paper chapter states in a `\blfootnote` that it is a verbatim copy of the
paper. Edits to scientific content belong in the paper source, not the chapter.

### PLANTA (`pddl/`)

- Paper repo: `~/ros_workspaces/planta_ws/src/planta_paper_overleaf/` (entry `main-acm.tex`).
- `pddl/sync_from_paper.py [PAPER_DIR]` regenerates `pddl/sections/`, `pddl/config/`,
  `pddl/figures/`, `pddl/tables/`, `pddl/navigation_experiment/`. It replaces those
  directories on every run. **Never edit files there by hand.**
- Mechanical transformations applied by the script: asset paths prefixed with
  `pddl/`; every label/ref key prefixed with `planta:` (supplement labels become
  `planta:S-<key>`); citation keys renamed via `CITE_KEY_MAP` (e.g. `PlanSys2` to
  `plansys2`); supplement body written to `pddl/sections/supplement.tex`.
- Hand-maintained: only `pddl/pddl.tex` (chapter title, abstract, footnote, `\input` list).
- Paper paths in `chapters/planta/` are already rewritten to thesis paths.

### Tactical Retreat (`cognitive_architecture/`)

- Paper repo: `~/ros_workspaces/suave_rebetmc_ws/tactical_retreat_overleaf/` (entry `main_els_sc.tex`).
- The thesis chapter is still an outline. No sync mechanism exists yet.

### SUAVE (`suave/`) and ROSA (`rosa/`)

- Chapter text lives in the thesis. The papers are published/accepted, so the
  thesis copy is authoritative. No paper repo is configured.

## Implementation References

Read-only ground truth when manuscript claims depend on implementation. Do not
propose code changes during thesis tasks.

| What to verify | Where to look |
|---|---|
| SUAVE exemplar | `~/ros_workspaces/suave_rebetmc_ws/src/suave/` |
| ROSA | `~/ros_workspaces/suave_rebetmc_ws/src/rosa/` (also `~/ros_workspaces/rosa_3_ws/`; canonical copy unconfirmed) |
| PLANTA | `~/ros_workspaces/planta_ws/src/{suave_planta,navigation_planta,owl_to_pddl,pddl_tomasys,plansys2}/` |
| Tactical Retreat | `~/ros_workspaces/suave_rebetmc_ws/src/typedb_tactics/` |
| Thesis experiment data | `data/` (`*_experiment.csv`, `preprocess_data.py`) |
