# Structural checks and evidence boundaries

Run searches only against the active files established by project discovery.
Pass filenames as separate arguments (quote paths); avoid scanning archived TeX.
Use literal `rg -n -F '\label{' <FILES...>` and equivalent searches as a starting
point, not a parser. Comments, verbatim, conditional code and macro bodies can
produce false matches. Read surrounding source before reporting.

| Check | Procedure | Verification boundary |
|---|---|---|
| Duplicate labels | Inventory literal `\label{...}` definitions; search every candidate key across active files; reuse duplicate-label build warnings. | Repeated macro-body labels may be parameterized; compiler confirms executed duplicates. |
| Unresolved references | Inventory `\ref`, `\eqref`, `\pageref`, cleveref and configured custom commands; use LSP definitions/references or exact key search. | Compile enough passes via project build system; external references may come from xr or auxiliary files. |
| Undefined citations | Resolve standard and configured custom citation arguments against active BibTeX/BibLaTeX resources, including multi-key lists. | Bibliography tool warnings and final TeX log are authoritative; remote/generated resources require explicit limitation. |
| Missing dependencies | Inspect project-map edges marked missing_or_external, ambiguous or dynamic_unresolved; verify input/include, local packages/classes and graphics paths with build output. | TeX search paths, import/subfiles, generated figures and macros may resolve outside the static map. |
| Important macros | Use paper-model/terminology to identify protected commands, locate definitions with LSP or `rg -n -F`, inspect argument count and affected uses. | Definitions can live in installed packages; no global unknown-command heuristic. |
| Environments | Inspect changed `\begin`/`\end` nesting, math delimiters and enclosing environments, possibly across inputs. Use compiler/ChkTeX findings. | Do not naïvely count commented, verbatim or conditional tokens as executed TeX. |
| Protected constructs | Compare the actual before/after passage: command names/arguments, citation/reference keys, labels, math/equations, environment boundaries, input paths, table alignment and figure options. | Report discrepancies from the approved edit; legitimate structural changes are not automatically errors. |

Recommend correction directions (for example, 'verify the intended label target'
or 'restore the approved equation'), not automatic edits, renames, or prose.
