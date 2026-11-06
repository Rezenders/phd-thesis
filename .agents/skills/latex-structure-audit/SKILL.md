---
name: latex-structure-audit
description: Diagnose LaTeX structure after targeted changes or across an active multi-file manuscript, without reviewing prose or editing source.
---

# LaTeX Structure Audit

Read-only source audit. Builds may create artifacts, but never change manuscript
files, keys, equations, or macros. This is not a scientific or stylistic review.

## Scope and tools

- **Incremental** (default after an edit): inspect the supplied diff, affected
  files, enclosing environments and relevant definitions/users. Search the active
  manuscript for label/key uniqueness even when only one file changed.
- **Full**: inspect all active files and relevant compiled-document diagnostics.
  Establish the selected entry point; do not include archival drafts by default.
- Read `.agents/context/paper-model.md` and run
  `python3 scripts/latex_project_map.py --root . --entry <MAIN_TEX>` (optionally
  `--fls <RECORDER>`). Inspect limitations and unresolved dependencies.
- Discover the harness's available LSP operations; prefer definition lookup,
  references, symbols and diagnostics when supported. Pi and Claude tool names
  differ. Do not install an extension or assume TexLab is mandatory. Fall back
  to `rg -n -F`, source reading and compilation.

## Procedure

1. Establish active files and change scope. Load
   `references/checklist.md` for concrete checks and evidence boundaries.
2. Reuse a current `paper-build` JSON report, with entry/command and source
   currency checked. If absent or structural changes affect validity, run
   `paper-build`; do not implement another build pipeline. Record NOT RUN if
   tools are unavailable. Distinguish source candidates from compiler findings.
3. Inspect labels and references, citations/bibliography keys, dependencies,
   important macro definitions/uses, and environment boundaries. Inspect local
   class/style files if they define relevant commands. Verify candidate problems
   with compilation or LSP where possible. Unknown package commands are not
   automatically undefined macros.
4. For incremental mode, compare protected constructs before/after against the
   author's approved change. Separate expected structural changes from unexpected
   changes. Report pre-existing findings separately, without attributing them to
   this edit. No baseline means introduction status is unknown.
5. Report findings and coverage. Do not fix them or feed them into a writer
   without human approval. No mandatory full audit for a minor wording edit.

## Output

For each finding: **file:line** (or unknown plus log location), **category**,
**severity**, **supporting evidence**, **recommended correction direction**,
**verification status** (compiler-confirmed / LSP-supported / source candidate /
unverified). Include reviewed files, mode, tools used/missing, build-report path,
protected-construct changes, unresolved dynamic dependencies, and checks not run.
A report with no candidates is not proof of a valid document when compilation or
coverage is incomplete. Environment checks are conservative, not a TeX parser.
