---
name: paper-build
description: Use when validating a scientific manuscript after substantive edits or before review and submission checks.
---

# Paper Build

Compilation is the primary validity signal; TexLab diagnostics supplement it.
Do not edit manuscript content, accept findings, or refresh baselines here.

## Workflow

1. Read `.agents/context/paper-model.md`. Establish the build working directory,
   entry point, build command, engine, bibliography backend, PDF and log paths.
   Inspect build metadata or use `scripts/latex_project_map.py` if needed. Ask
   rather than arbitrarily choosing among multiple entry points.
2. Use the configured project build command unchanged. Never assume `make pdf`
   exists. Only when no project command exists, use latexmk with the confirmed
   entry and engine. Respect project latexmkrc and bibliography settings; latexmk
   selects BibTeX/Biber from source and auxiliary metadata. If those disagree
   with the recorded backend, report the conflict before building.
3. From the project root run the utility below, supplying actual paths. Commands
   are trusted shell input: inspect them before execution. `--root` is the build
   working directory; paths passed to the utility are relative to it.
4. Collect actual output and relevant logs, including output-directory logs.
   Unchanged/cached logs are not evidence that a warning was newly introduced.
   A PDF's presence alone does not establish a successful or current build.
   Build stdout may include intermediate-pass warnings that disappeared on later
   passes. Use the verified final log to distinguish unresolved warnings from
   earlier observations; JSON `logs` records whether each supplied log was read,
   updated/unchanged, and how many diagnostics it contained.
5. Run the configured lint command separately and report its exit code/output.
   If none exists, use `--chktex` for applicable active TeX files when installed;
   respect local ChkTeX configuration. Skip generated/verbatim-only files as
   appropriate. Lint warnings are not compilation failures.
6. Compare only with an explicitly supplied, compatible existing diagnostic
   baseline or configured project diff-lint check. Never claim 'no new warnings'
   without a comparison.

## CLI examples

```bash
python3 scripts/latex_diagnostics.py --build --entry main.tex \
  --build-command 'make paper' --log build/main.log --pdf build/main.pdf \
  --chktex main.tex --output /tmp/build-report.json --summary
# Only without a configured build command:
python3 scripts/latex_diagnostics.py --build --entry main.tex --engine lualatex \
  --backend biber --log main.log --pdf main.pdf --output /tmp/build-report.json
# Parse captured logs without claiming compilation was run:
python3 scripts/latex_diagnostics.py --log build/main.log
```

Use `--help` for baseline, timeout and working-directory options. JSON schema 1
reports build/lint/PDF statuses, diagnostic category, severity, evidence, source
log and location, comparison status and limitations. Unknown TeX locations are
null, not guessed from a log's line number. Exit 0 means processing completed
(and any executed build succeeded), not a warning-free manuscript; 1 means
build failure; 2 means input/tool/timeout error. On error, JSON goes to stderr.

## Report

Report build PASS / FAIL / NOT RUN / UNAVAILABLE; PDF path and currency evidence;
fatal errors, undefined citations/references, duplicate labels, package warnings,
overfull/underfull boxes; lint status; baseline comparison or NOT COMPARED; and
missing capabilities. Preserve raw output in the JSON report. Wrapped TeX
messages or unusual package formats may need manual log inspection. Do not
claim a clean document when required checks were skipped or warnings remain.
